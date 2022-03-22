//
//  TransferViewController.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
protocol TransferViewControllerDelegate {
    func transferDidSucessFull(transactionData: TransactionData)
}
class TransferViewController: UITableViewController {
    @IBOutlet weak var btnTransfer: PrimaryButton!
    @IBOutlet weak var txtRecepient: PickerTextField!
    @IBOutlet weak var txtDescription: PrimaryTextView!
    @IBOutlet weak var txtAmount: PrimaryTextField!
    @IBOutlet weak var lblDescriptionPlaceHolder: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    var delegate:TransferViewControllerDelegate?
    var transferViewModel:TransferViewModel!
    var payeeViewModel:PayeeViewModel!
    var balanceViewModel: BalanceViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Make a transfer"
        self.btnTransfer.isEnabled = false
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
        self.setupTransferViewModel()
        self.lblBalance.text = "Account balance :  \(self.balanceViewModel?.getFormattedBalanceWithCurreny() ?? "")"
        lblDescriptionPlaceHolder.font = txtDescription.font
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupPayeesViewModel()
    }
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    @IBAction func btnTrasferButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        let deduction = Double(self.txtAmount.text ?? "0") ?? 0.0
        let canSendAmount = self.balanceViewModel?.canSendAmount(amount: deduction) ?? false
        if canSendAmount {
            if let payeeAccNo = self.payeeViewModel.allPayee[self.txtRecepient.selectedIndex].accountNo,
               let strDescription = self.txtDescription.text,
               let amount = self.txtAmount.text {
                self.showLoader()
                self.transferViewModel.doTransfer(transferRequest: TransferRequestModel.init(amount: Int(amount) ?? 0, receipientAccountNo: payeeAccNo, description: strDescription))
            }
        } else {
            self.showAlert(title: "Warning", message: "You do not have enough balance.\nYour available balance is \(self.balanceViewModel?.getFormattedBalanceWithCurreny() ?? "")")
        }
    }
}
extension TransferViewController {
    func setupTransferViewModel() {
        self.transferViewModel = TransferViewModel()
        self.transferViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.hideLoader(completion: {
                    let transactionModel = TransactionData.init(id: self?.transferViewModel.transferData?.id, type: "transfer", amount: Double(self?.transferViewModel.transferData?.amount ?? 0), currency: "SGD", sender: nil, receipient: ReceipientInfo(accountNo: self?.transferViewModel.transferData?.recipientAccountNo, accountHolder: self?.payeeViewModel.allPayee[self?.txtRecepient.selectedIndex ?? 0].name), date: Common.getCurrentTimeStamp(), description: self?.transferViewModel.transferData?.description)
                    self?.balanceViewModel?.updateBalanceAfterTransfer(transactionData: transactionModel)
                    self?.lblBalance.text = "Account balance :  \(self?.balanceViewModel?.getFormattedBalanceWithCurreny() ?? "")"
                    self?.showAlert(title: "Success", message: "Transfer successful", buttonHandler: {[weak self] (_) in
                        self?.navigationController?.popViewController(animated: true)
                        self?.delegate?.transferDidSucessFull(transactionData: transactionModel)
                    })
                })
            }
        }
        self.transferViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideLoader(completion: {
                    self?.showAlert(title: "Error", message: errorMessage)
                })
            }
        }
    }
    func setupPayeesViewModel() {
        self.payeeViewModel = PayeeViewModel()
        self.payeeViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.hideLoader(completion: {
                    let arrPayee = self?.payeeViewModel.allPayee.map({ payeeData -> String in
                        let name = payeeData.name ?? ""
                        let accountNo = payeeData.accountNo ?? ""
                        return  name + " - " + accountNo
                    })
                    self?.txtRecepient.pickerItems = arrPayee ?? []
                })
            }
        }
        self.payeeViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideLoader(completion: {
                    self?.txtRecepient.pickerItems = []
                })
            }
        }
        self.showLoader {
            self.payeeViewModel.getAllPayees()
        }
    }
}
extension TransferViewController {
    fileprivate func validateTransfer() -> Bool {
        if txtRecepient.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    fileprivate func validateTextField(_ textField: UITextField, _ updatedText: String) {
        if textField == txtRecepient {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true)
        } else if textField == txtDescription {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtRecepient.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true)
        } else if textField == txtAmount {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtDescription.text?.isEmpty ?? true || txtRecepient.text?.isEmpty ?? true)
        }
    }
}
extension TransferViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            validateTextField(textField, updatedText)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnTransfer.isEnabled = validateTransfer()
    }
}
extension TransferViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        lblDescriptionPlaceHolder.isHidden = !(textView.text.isEmpty)
        self.btnTransfer.isEnabled = validateTransfer()
    }
}
