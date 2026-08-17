//
//  BulkEndPoints.swift
//  Stack
//
//  Created by Jacobs, Joe on 7/9/26.
//

import Foundation

struct GetBulkData: Endpoint {
    let path: String = "/bulk-data"
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
}

struct GetBulkDataID: Endpoint {
    let id: String
    var path: String {
        return "/bulk-data/\(id)"
    }
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
}

struct GetBulkDataType: Endpoint {
    let type: String
    var path: String {
        return "/bulk-data/\(type)"
    }
    let method: EndpointMethod = .get
    var parameters: [URLQueryItem]
}
