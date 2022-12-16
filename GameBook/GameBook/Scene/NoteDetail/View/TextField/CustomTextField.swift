//
//  CustomTextField.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
        self.textColor = .white
        self.tintColor = .systemRed
        layer.masksToBounds = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Game Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
}
