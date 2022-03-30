//
//  ContentViewModile.swift
//  Codif
//
//  Created by Izzat on 11.06.2021.
//

import SwiftUI
import RxSwift

class ContentViewModel: ObservableObject {
        
    @Published var screen: Screen?
    @Published var showErrorAlert = false
    
    var errorText: String?
    private var disposeBag = DisposeBag()
    
    init() { }
    
    func getData() {
        var uInp = [String: Any]()
        for key in GlobalData.shared.userInputs.keys {
            if !key.isEmpty {
                uInp[key] = GlobalData.shared.userInputs[key]
            }
        }
        request(observable: APIClient.shared.execute(userInput: uInp))
    }
    
    func request(observable: Observable<Screen>) {
        observable
        .observe(on: MainScheduler.instance)
        .subscribe {[weak self] v in
            GlobalData.shared.variables = v.variables ?? [Variables]()
            self?.screen = v
        } onError: { error in
            if error is CustomError {
                switch error {
                case CustomError.invalidJSON :
                    self.errorText = "Invalid view JSON"
                    self.showErrorAlert.toggle()
                case CustomError.commonJsonNotFound:
                    self.errorText = "COMMON JSON not found"
                    self.showErrorAlert.toggle()
                case CustomError.invalidViewJSON:
                    self.errorText = "Invalid view JSON"
                    self.showErrorAlert.toggle()
                default:
                    break
                }
                return
            }
            self.errorText = error.localizedDescription
            self.showErrorAlert.toggle()
        } onCompleted: {
            GlobalData.shared.userInputs.removeAll()
        }
        .disposed(by: disposeBag)
    }
    
    func goBack() {
        request(observable: APIClient.shared.goBack())
    }
}
