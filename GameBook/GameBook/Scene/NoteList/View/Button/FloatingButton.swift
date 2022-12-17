//
//  FloatingButton.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonSetup()
    }
    
    func buttonSetup(){
        self.frame = CGRect(x: UIScreen.main.bounds.width * 0.8 , y: UIScreen.main.bounds.height * 0.7, width: 50, height: 50)
        let image = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
        self.backgroundColor = .systemRed
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
    }
}
