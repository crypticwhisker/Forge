import Testing
@testable import Forge


struct EndpointTests {

    @Test func buildEndPointURL() async throws {
        
        let testEndpoint = GetCardsSearch(
            query: "sauron",
            order: .cmc,
            includeExtras: true
        )
        let url = try testEndpoint.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/cards/search?q=sauron&order=cmc&include_extras=true")
        
    }

    @Test func buildTagEndPoint() async throws {
        
        let testEndpoint = GetBulkData(type: "oracle-tags")
        let url = try testEndpoint.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/bulk-data/oracle-tags")
        
    }
    
    @Test func buildAutoCompleteEndPoint() async throws {
        
        let testEndpoint = GetCardsAutoComplete(query: "sauron")
        let url = try testEndpoint.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/cards/autocomplete?q=sauron")
    }
    
    @Test func buildAllSetEndpoint() async throws {
        
        let ep = GetSetsAll()
        let url = try ep.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/sets")
        
    }
    
    @Test func buildSetCodeEndpoint() async throws {
        
        let ep = GetSetByCode(code: "ltr")
        let url = try ep.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/sets/ltr")
        
    }
    
    @Test func buildSetIDEndpoin() async throws {
        
        let ep = GetSetByCode(code: "08078706-ac5d-439b-8f01-894d38751367")
        let url = try ep.makeURL()
        
        #expect(url.absoluteString == "https://api.scryfall.com/sets/08078706-ac5d-439b-8f01-894d38751367")
        
    }
    
}
