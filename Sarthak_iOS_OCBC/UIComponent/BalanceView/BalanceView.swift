//
//  BalanceView.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
public class BalanceView: UIView {
    @IBOutlet private(set) weak var lblTopHeader: UILabel!
    @IBOutlet private(set) weak var lblBalance: UILabel!
    @IBOutlet private(set) weak var lblAccountNoHeader: UILabel!
    @IBOutlet private(set) weak var lblAccountNo: UILabel!
    @IBOutlet private(set) weak var lblAccountHolderHeader: UILabel!
    @IBOutlet private(set) weak var lblAccountHolder: UILabel!
    /// :nodoc:
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    /// :nodoc:
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    /// Initilize the view from the nib
    fileprivate func commonInit() {
        _ = fromNib(nibName: "BalanceView")
        setupUI()
    }
    private func setupUI() {
        self.lblTopHeader.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblBalance.font = UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.semibold)
        self.lblAccountNoHeader.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblAccountNo.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        self.lblAccountHolderHeader.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblAccountHolder.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        self.lblTopHeader.textColor = UIColor.white
        self.lblBalance.textColor = UIColor.white
        self.lblAccountNoHeader.textColor = UIColor.white
        self.lblAccountNo.textColor = UIColor.white
        self.lblAccountHolderHeader.textColor = UIColor.white
        self.lblAccountHolder.textColor = UIColor.white
        self.backgroundColor = UIColor.blue
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
    /// Sets the balance text.
    public var balance: String? {
        didSet {
            self.lblBalance.text = balance
        }
    }
    /// Sets the top label text.
    public var topText: String? {
        didSet {
            self.lblTopHeader.text = topText
        }
    }
    /// Sets the account no label text.
    public var accountNoHeader: String? {
        didSet {
            self.lblAccountNoHeader.text = accountNoHeader
        }
    }
    public var accountNo: String? {
        didSet {
            self.lblAccountNo.text = accountNo
        }
    }
    /// Sets the account holder label text.
    public var accountHolderHeader: String? {
        didSet {
            self.lblAccountHolderHeader.text = accountHolderHeader
        }
    }
    public var accountHolder: String? {
        didSet {
            self.lblAccountHolder.text = accountHolder
        }
    }
}
