//
//  FilterButton.swift
//  GameBook
//
//  Created by Hasan Uysal on 18.12.2022.
//

import UIKit

final class FilterButton: UIButton {

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
        configuration.title = NSLocalizedString("Filter", comment: "")
        configuration.image = UIImage(systemName: "slider.horizontal.3")
        configuration.imagePadding = 2
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .lightGray
        self.configuration = configuration

    }
}
