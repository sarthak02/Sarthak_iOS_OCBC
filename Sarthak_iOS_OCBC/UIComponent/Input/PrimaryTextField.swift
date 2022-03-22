//
//  PrimaryTextField.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
public class PrimaryTextField: UITextField {
    public init() {
        super.init(frame: .zero)
        configure()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    func configure() {
        self.borderStyle = .none
        self.addLineAtBottom()
        self.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        self.textColor = UIColor.black
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
}
