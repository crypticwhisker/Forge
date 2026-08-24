import Foundation
import OSLog

protocol ForgeNetworkProtocol: Sendable {
    func fetchAndDecode<T: Decodable>(from endpoint: Endpoint, as type: T.Type) async throws -> T
}

public struct ForgeNetwork: ForgeNetworkProtocol {
    
    let session: URLSession
    let decoder: JSONDecoder
    let logger: Logger
    
    init(
        session: URLSession,
        decoder: JSONDecoder = .init(),
        logger: Logger = .init()
    ) {
        self.session = session
        self.decoder = decoder
        self.logger = logger
    }
    
    func decode<T: Decodable>(data: Data, as type: T.Type) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            logger.debug("\(error)")
            throw FetchError.decodeError
        }
    }
    
    func fetchAndDecode<T: Decodable>(from endpoint: Endpoint, as type: T.Type) async throws -> T {
        do {
            
            let url = try endpoint.makeURL()
            var request = URLRequest(url: url)
            
            switch endpoint.method {
            case .get:
                request.httpMethod = "GET"
            case .post:
                request.httpMethod = "POST"
            }
            
            let (data, response) = try await session.data(for: request)
            
            // Make sure we get a response at all
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
            // 200-300 is success
            
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 404:
                throw FetchError.noMatchError
            case 503:
                throw FetchError.downError
            default:
                if let apiError = try? decode(data: data, as: SFError.self) {
                    throw FetchError.apiError(apiError)
                }
            }
            
            return try decode(data: data, as: T.self)
        }
    }
    
}
