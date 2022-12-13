//
//  BaseViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 13.12.2022.
//

import UIKit
import MaterialActivityIndicator

class BaseViewController: UIViewController {
    
    let indicator = MaterialActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
    
    func setNavBarTitle(view: UIViewController, title: String){
        view.title = title
    }
    
    private func setupActivityIndicatorView(){
        view.addSubview(indicator)
        setupActivityIndıcatorViewConstraints()
    }
    
    private func setupActivityIndıcatorViewConstraints(){
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
