//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tigran Gishyan on 26.04.22.
//

import UIKit

class ViewController: UIViewController {
    var squareView: SquareView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSquareView()
        constructHierarchy()
        activateConstraints()
    }
}

extension ViewController {
    private func initSquareView() {
        squareView = SquareView()
        squareView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constructHierarchy() {
        view.addSubview(squareView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
