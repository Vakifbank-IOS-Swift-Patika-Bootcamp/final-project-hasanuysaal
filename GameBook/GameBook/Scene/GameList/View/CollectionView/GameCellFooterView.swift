//
//  GameCellFooterView.swift
//  GameBook
//
//  Created by Hasan Uysal on 12.12.2022.
//

import UIKit

protocol GameCellFooterViewDelegate: AnyObject{
    func nextButton()
    func previousButton()
}

protocol GameCellFooterViewProtocol: AnyObject{
    var delegate: GameCellFooterViewDelegate? { get set }
}

final class GameCellFooterView: UICollectionReusableView, GameCellFooterViewProtocol {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    weak var delegate: GameCellFooterViewDelegate?
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        delegate?.previousButton()
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        delegate?.nextButton()
    }
}
