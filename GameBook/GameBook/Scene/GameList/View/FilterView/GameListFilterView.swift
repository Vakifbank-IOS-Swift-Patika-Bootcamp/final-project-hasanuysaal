//
//  GameListFilterView.swift
//  GameBook
//
//  Created by Hasan Uysal on 12.12.2022.
//

import UIKit

protocol GameListFilterViewDelegate: AnyObject {
    func getPopularGames()
    func getUpcomingGames()
}


final class GameListFilterView: UIView {
    
    @IBOutlet private weak var upcomingGamesLabel: UILabel!
    @IBOutlet private weak var popularGamesLabel: UILabel!
    
    weak var delegate: GameListFilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func setLabelsText(){
        upcomingGamesLabel.text = NSLocalizedString("Upcoming Games", comment: "")
        popularGamesLabel.text = NSLocalizedString("Popular Games", comment: "")
    }
    
    private func setTapGestureRecoginzers() {
        setUpcomingLabelGestureRecognizer()
        setPopularLabelGestureRecognizer()
    }
    
    private func setUpcomingLabelGestureRecognizer(){
        upcomingGamesLabel.isUserInteractionEnabled = true
        let upComGameTapGr = UITapGestureRecognizer(target: self, action: #selector(upcomingGamesLabelTapped))
        upcomingGamesLabel.addGestureRecognizer(upComGameTapGr)
    }
    
    private func setPopularLabelGestureRecognizer(){
        popularGamesLabel.isUserInteractionEnabled = true
        let popGameTapGr = UITapGestureRecognizer(target: self, action: #selector(popularGamesLabelTapped))
        popularGamesLabel.addGestureRecognizer(popGameTapGr)
    }
    
    private func customInit() {
        let nib = UINib(nibName: "GameListFilterView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(view)
            view.frame = self.bounds
            view.backgroundColor = UIColor.appSecondBackgroundColor
            setBorder()
            setTapGestureRecoginzers()
            setLabelsText()
        }
        
    }
    
    private func setBorder(){
        let border = CALayer()
        border.backgroundColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:1)
        self.layer.addSublayer(border)
    }
    
    @objc private  func upcomingGamesLabelTapped() {
        self.delegate?.getUpcomingGames()
        self.removeFromSuperview()
    }
    
    @objc private func popularGamesLabelTapped() {
        self.delegate?.getPopularGames()
        self.removeFromSuperview()
    }
}
