//
//  LoginViewController.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
class RegisterViewController: UITableViewController {
    @IBOutlet weak var btnRegister: PrimaryButton!
    @IBOutlet weak var txtUserName: PrimaryTextField!
    @IBOutlet weak var txtPassword: PrimaryTextField!
    @IBOutlet weak var txtConfirmPassword: PrimaryTextField!
    
    var registerViewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.btnRegister.isEnabled = validateLogin()
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
    
    @IBAction func btnRegisterButtonClicked(_ sender: Any) {
        self.endEditing()
        if self.txtPassword.text != self.txtConfirmPassword.text {
            self.showAlert(title: "Error", message: "Confirm password not match")
        } else if let userName = self.txtUserName.text, let passWord = self.txtPassword.text {
            self.showLoader {
                self.registerViewModel.doRegister(registerRequest: RegisterRequestModel.init(username: userName, password: passWord))
            }
        }
    }
}
extension RegisterViewController {
    fileprivate func setupViewModel() {
        self.registerViewModel = RegisterViewModel()
        self.registerViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.hideLoader()
                self?.backToLoginScreen()
            }
        }
        self.registerViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideLoader {
                    self?.showAlert(title: "Error", message: errorMessage)
                }
            }
        }
    }
}
extension RegisterViewController {
    func validateLogin() -> Bool {
        if txtUserName.text?.isEmpty ?? true ||
            txtPassword.text?.isEmpty ?? true ||
            txtConfirmPassword.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    func backToLoginScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " { // Dont allow to enter the space
            return false
        }
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == txtUserName {
                self.btnRegister.isEnabled = !(updatedText.isEmpty || txtPassword.text?.isEmpty ?? true)
            } else {
                self.btnRegister.isEnabled = !(updatedText.isEmpty || txtUserName.text?.isEmpty ?? true)
            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnRegister.isEnabled = validateLogin()
    }
}
