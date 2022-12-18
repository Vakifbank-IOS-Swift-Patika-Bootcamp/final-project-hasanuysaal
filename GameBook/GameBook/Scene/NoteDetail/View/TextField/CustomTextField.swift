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
    
    private func configure() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 10
        self.backgroundColor = UIColor.appSecondBackgroundColor
        self.textColor = .white
        self.tintColor = .systemRed
        layer.masksToBounds = true
        setButtonToRightView()
    }
    
    private func setButtonToRightView(){
        let button = UIButton()
        var configuration = UIButton.Configuration.bordered()
        configuration.image = UIImage(systemName: "magnifyingglass")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -16 , bottom: 0, trailing: 0)
        button.configuration = configuration
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        self.rightViewMode = .always
        self.rightView = button
    }
    
    @objc private func searchTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("gameNameSearchTapped"), object: nil)
    }
}
