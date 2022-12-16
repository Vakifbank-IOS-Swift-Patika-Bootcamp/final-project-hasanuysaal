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


class GameListFilterView: UIView {
    
    @IBOutlet weak var upcomingGamesLabel: UILabel!
    @IBOutlet weak var popularGamesLabel: UILabel!
    
    weak var delegate: GameListFilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func setLabelsText(){
        upcomingGamesLabel.text = NSLocalizedString("Upcoming Games", comment: "")
        popularGamesLabel.text = NSLocalizedString("Popular Games", comment: "")
    }
    
    func setTapGestureRecoginzers() {
        upcomingGamesLabel.isUserInteractionEnabled = true
        popularGamesLabel.isUserInteractionEnabled = true
        
        let upComGameTapGr = UITapGestureRecognizer(target: self, action: #selector(upcomingGamesLabelTapped))
        upcomingGamesLabel.addGestureRecognizer(upComGameTapGr)
        
        let popGameTapGr = UITapGestureRecognizer(target: self, action: #selector(popularGamesLabelTapped))
        popularGamesLabel.addGestureRecognizer(popGameTapGr)
    }
    
    private func customInit() {
        let nib = UINib(nibName: "GameListFilterView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(view)
            view.frame = self.bounds
            setBorder()
            setTapGestureRecoginzers()
        }
        setLabelsText()
    }
    
    func setBorder(){
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:1)
        self.layer.addSublayer(border)
    }
    
    @objc func upcomingGamesLabelTapped() {
        self.delegate?.getUpcomingGames()
        self.removeFromSuperview()
    }
    
    @objc func popularGamesLabelTapped() {
        self.delegate?.getPopularGames()
        self.removeFromSuperview()
    }
    
    
}
