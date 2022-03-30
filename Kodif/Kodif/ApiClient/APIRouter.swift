//
//  APIRouter.swift
//  Kodif

import Alamofire
import SwiftUI

enum APIRouter: URLRequestConvertible {
    
    case execute(userInput: [String: Any])
    case goback
    case uploadDoc
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .post
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .execute:
            return "/api/v1/self-serve/execute"
        case .uploadDoc:
            return "/api/v1/self-serve/"
        case .goback:
            return "/api/v1/self-serve/goback"
        }
    }
    
    // MARK: - Parameters
    private var parameters: [String: Any]? {
        switch self {
        case .execute(let userInput):
            return ["session" : K.APIServer.uuId, "flowUuid": K.APIServer.flowUUID, "userInputs": userInput, "initialParams": K.APIServer.initialParams]
        case .goback:
            return ["session" : K.APIServer.uuId, "flowUuid": K.APIServer.flowUUID, "initialParams": K.APIServer.initialParams]
        default:
            return nil
        }
    }
    
    // MARK: - Content Type
    private var contentType: String {
        switch self {
        case .uploadDoc:
            return ContentType.multipart.rawValue
        default:
            return ContentType.json.rawValue
        }
    }
    
    private var baseURL: String {
        switch K.APIServer.envirment {
        case .PRODUCTION:
            return K.APIServer.PRODUCTION
        default:
            return K.APIServer.STAGING
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        
        var urlRequest = URLRequest(url: try url.appending(path).asURL())
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

