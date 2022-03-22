//
//  RegisterViewModel.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct RegisterRequestModel {
    var username: String
    var password: String
}
public class RegisterViewModel {
    var apiService = APIRequest(resource: RegisterDataResource())
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    var loginData : LoginData? {
        didSet {
            if  let data = loginData, !data.token.isEmpty {
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("incorrect username or password")
            }
        }
    }
    /// Fetch login data.
    func doRegister(registerRequest: RegisterRequestModel) {
        apiService.resource.httpBody = self.getLoginRequestData(registerRequest)
        apiService.load { [weak self] (loginData) in
            self?.loginData = loginData
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "incorrect username or password")
        }
    }
    /// Converts LoginRequestModel into Dictionary for login request.
    private func getLoginRequestData(_ param: RegisterRequestModel) -> [AnyHashable: Any] {
        let data: [AnyHashable: Any] = ["username": param.username,
                                        "password": param.password]
        return data
    }
}
/// Represents the login data resource information.
public struct RegisterDataResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.register.rawValue
    var headerData: [String : String]? = nil
    var requestType: ApiRequestMethodType = .POST
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = LoginData
}

