//
//  NetworkAPI.swift
//  Kodif

import RxSwift
import Alamofire
import AlamofireActivityLogger
import Rollbar

class NetworkAPI {
        
    @discardableResult
    func performRequest(route:URLRequestConvertible) -> Observable<Screen> {
        return Observable.create {observer in
            
            let notification = UINotificationFeedbackGenerator()
            let request = Alamofire.request(route)
                .log(level: .all, options: [.onlyDebug, .jsonPrettyPrint, .includeSeparator])
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        guard let contentData = try? decoder.decode(ContentData.self, from: value) else {
                            notification.notificationOccurred(.error)
                            observer.onError(CustomError.invalidJSON)
                            Rollbar.error("Invalid JSON")
                            return
                        }
                        
                        if contentData.errorDetails != nil {
                            Rollbar.error(contentData.errorDetails)
                        }

                        guard let json = contentData.manifests?.first(where: {$0.type == "COMMON"})?.json else {
                            notification.notificationOccurred(.error)
                            observer.onError(CustomError.commonJsonNotFound)
                            return
                        }
                        guard let view = try? decoder.decode(Screen.self, from: Data(json.utf8)) else {
                            notification.notificationOccurred(.error)
                            observer.onError(CustomError.invalidViewJSON)
                            return
                        }
                        observer.onNext(view)
                    case .failure(let error):
                        notification.notificationOccurred(.error)
                        Rollbar.error(error.localizedDescription)
                        observer.onError(error)
                    }
                    observer.onCompleted()
                })
            return Disposables.create {request.cancel()}
        }
    }
    
    
    func uploadData(fileName: String,
                       data:Data,
                       route:URLRequestConvertible) -> Observable<String> {
        return Observable.create {observer in
            let notification = UINotificationFeedbackGenerator()
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "BLS_BLOB", fileName: fileName, mimeType: "image/jpeg")
            },
                             with: route,
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.log(level: .all, options: [.onlyDebug, .jsonPrettyPrint, .includeSeparator])
                                        .uploadProgress { progress in // main queue by default
                                            //Float(progress.fractionCompleted)
                                            print("Upload Progress: \(progress.fractionCompleted)")
                                    }
                                    .responseString(completionHandler: { (response: DataResponse<String>) in
                                        switch response.result {
                                        case .success(let value):
                                            observer.onNext(value)
                                        case .failure(let error):
                                            notification.notificationOccurred(.error)
                                            observer.onError(error)
                                        }
                                        observer.onCompleted()
                                    })
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            })
            return Disposables.create()
        }.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

enum CustomError: Error {

    case invalidJSON

    case commonJsonNotFound
    
    case invalidViewJSON

    case unexpected(code: Int)
}
