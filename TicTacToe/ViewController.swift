//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tigran Gishyan on 26.04.22.
//

import UIKit

class ViewController: UIViewController {
    var mainStackView: UIStackView!
    var isXState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStackView()
        constructHierarchy()
        activateConstraints()
        
        createSquareGrid(size: 1...3)
    }
    
    func createSquareGrid(size: ClosedRange<Int>) {
        for _ in size {
            let stackView = createHorizontalStackView()
            mainStackView.addArrangedSubview(stackView)
            
            for _ in size {
                let squareView = SquareView()
                
                squareView.onButtonSelection = {
                    if self.isXState {
                        squareView.set(value: "X")
                    } else {
                        squareView.set(value: "O")
                    }
                    self.isXState.toggle()
                }
                
                let height = (Int(view.frame.width) - 50 - (size.upperBound - 1)*5)/size.upperBound
                NSLayoutConstraint.activate([
                    squareView.heightAnchor.constraint(equalToConstant: CGFloat(height))
                ])
                
                stackView.addArrangedSubview(squareView)
            }
        }
    }
    
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }
}

extension ViewController {
    private func initStackView() {
        mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .black
    }
    
    private func constructHierarchy() {
        view.addSubview(mainStackView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}
