//
//  SquareView.swift
//  TicTacToe
//
//  Created by Tigran Gishyan on 26.04.22.
//

import UIKit

class SquareView: UIView {
    var label: UILabel!
    var button: UIButton!
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .blue
        initLabel()
        initButton()
        constructHierarchy()
        activateConstraints()
    }
}

extension SquareView {
    private func initLabel() {
        label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "A"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initButton() {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constructHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
