//
//  SortButton.swift
//  GameBook
//
//  Created by Hasan Uysal on 18.12.2022.
//

import UIKit

final class SortButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure(){
        var configuration = UIButton.Configuration.filled()
        configuration.title = NSLocalizedString("Sort", comment: "")
        configuration.image = UIImage(systemName: "arrow.up.arrow.down.circle")
        configuration.imagePadding = 2
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .lightGray
        self.configuration = configuration
        let border = CALayer()
        border.backgroundColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x:0 ,y: 0, width: 1, height: self.frame.size.width)
        self.layer.addSublayer(border)

    }
}
