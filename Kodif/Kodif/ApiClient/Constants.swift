//
//  Constants.swift
//  Kodif

import Foundation

struct K {
    struct APIServer {
        static let PRODUCTION = "https://api.kodif.io"
        static let STAGING = "https://api-staging.kodif.io"
        static let envirment = Envirment.PRODUCTION
        
        static var flowUUID = ""
        static var initialParams = [String: Any]()
        
        static var uuId = ""
    }
}

enum HTTPHeaderField: String {
    case session = "session"
    case flowUuid = "flowUuid"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
    case urlencoded = "application/x-www-form-urlencoded"
}

enum Envirment: String {
    case PRODUCTION
    case STAGING
    case TESTING
}
