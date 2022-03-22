//
//  SecondaryButton.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import UIKit
public class SecondaryButton: UIButton {
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
    private func configure() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.semibold)
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .disabled)
        self.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .highlighted)
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.blue.cgColor
    }
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = (self.isEnabled) ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
        }
    }
}
