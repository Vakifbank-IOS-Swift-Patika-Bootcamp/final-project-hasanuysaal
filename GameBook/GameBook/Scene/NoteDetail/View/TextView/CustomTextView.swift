//
//  CustomTextView.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 10
        self.backgroundColor = UIColor.appSecondBackgroundColor
        self.textColor = .white
        self.tintColor = .systemRed
        self.viewWithTag(100)
        layer.masksToBounds = true
        self.text = ""
    }
}

