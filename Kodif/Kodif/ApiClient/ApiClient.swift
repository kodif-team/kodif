//
//  APIClient.swift
//  Kodif


import Alamofire
import RxSwift

class APIClient: NetworkAPI {
    public static let shared = APIClient()
    
   
    func execute(userInput: [String: Any]) -> Observable<Screen> {
        return performRequest(route: APIRouter.execute(userInput: userInput))
    }
    
    func goBack() -> Observable<Screen> {
        return performRequest(route: APIRouter.goback)
    }
    
    func uploadDoc(fileName: String,
                   data:Data) -> Observable<String> {
        return uploadData(fileName: fileName, data: data, route: APIRouter.uploadDoc)
    }
}
