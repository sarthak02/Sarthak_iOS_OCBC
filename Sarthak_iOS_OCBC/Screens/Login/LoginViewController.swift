//
//  LoginViewController.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
class LoginViewController: UITableViewController {
    @IBOutlet weak var btnLogin: PrimaryButton!
    @IBOutlet weak var btnRegister: SecondaryButton!
    @IBOutlet weak var txtUserName: PrimaryTextField!
    @IBOutlet weak var txtPassword: PrimaryTextField!
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.btnLogin.isEnabled = validateLogin()
        self.btnRegister.isEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewModel()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }

    @IBAction func btnLoginButtonClicked(_ sender: Any) {
        self.endEditing()
        if let userName = self.txtUserName.text, let passWord = self.txtPassword.text {
            self.showLoader {
                self.loginViewModel.doLogin(loginRequest: LoginRequestModel.init(username: userName, password: passWord))
            }
        }
    }
    @IBAction func btnRegisterButtonClicked(_ sender: Any) {
        self.endEditing()
        self.pushToRegisterScreen()
    }
}
extension LoginViewController {
    fileprivate func setupViewModel() {
        self.loginViewModel = LoginViewModel()
        self.loginViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.hideLoader()
                self?.moveToDashBoardScreen()
            }
        }
        self.loginViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideLoader {
                    self?.showAlert(title: "Error", message: errorMessage)
                }
            }
        }
    }
}
extension LoginViewController {
    func validateLogin() -> Bool {
        if txtUserName.text?.isEmpty ?? true || txtPassword.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    func moveToDashBoardScreen() {
        let dashboardStoryBoard = UIStoryboard(name: "Dashboard", bundle: .main)
        guard let dashboardController = dashboardStoryBoard.instantiateViewController(identifier: "DashboardNavigationViewController") as? UINavigationController else {
            return
        }
        UIWindow.key?.rootViewController = dashboardController
    }
    func pushToRegisterScreen() {
        let registerStoryBoard = UIStoryboard(name: "Register", bundle: .main)
        guard let registerViewController = registerStoryBoard.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController else {
            return
        }
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " { // Dont allow to enter the space
            return false
        }
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == txtUserName {
                self.btnLogin.isEnabled = !(updatedText.isEmpty || txtPassword.text?.isEmpty ?? true)
            } else {
                self.btnLogin.isEnabled = !(updatedText.isEmpty || txtUserName.text?.isEmpty ?? true)
            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnLogin.isEnabled = validateLogin()
    }
}
