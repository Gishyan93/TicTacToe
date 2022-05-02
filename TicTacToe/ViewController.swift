//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tigran Gishyan on 26.04.22.
//

import UIKit

enum GameState {
    case started
    case win(winner: String)
    case draw
}

class ViewController: UIViewController {
    var newGameButton: UIButton!
    var titleLabel: UILabel!
    var mainStackView: UIStackView!
    var overlayView: UIView!
    var winnerLabel: UILabel!
    
    var squareViews: [SquareView] = []
    var isXState: Bool = true
    var isReadyForValidations: Bool = false
    
    var gamePlayArray: [[String]] = [] {
        didSet {
            if isReadyForValidations {
                checkGameStatus()
            }
        }
    }
    
    var gameState: GameState = .started {
        didSet {
            switch gameState {
            case .started:
                isReadyForValidations = false
                squareViews.forEach({ $0.removeData() })
                for i in gamePlayArray.indices {
                    for j in gamePlayArray[i].indices {
                        gamePlayArray[i][j] = ""
                    }
                }
                isXState = true
                isReadyForValidations = true
                overlayView.isHidden = true
                winnerLabel.isHidden = true
            case .win(let winner):
                winnerLabel.text = "Winner is \(winner)"
                winnerLabel.isHidden = false
                overlayView.isHidden = false
            case .draw:
                winnerLabel.text = "That was great game. Do you want to start again?"
                winnerLabel.isHidden = false
                overlayView.isHidden = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTitleLabel()
        initStackView()
        initNewgameButton()
        initOverlayView()
        initWinnerLabel()
        
        constructHierarchy()
        activateConstraints()
        
        createSquareGrid(size: 1...3)
        
        newGameButton.addTarget(
            self, action: #selector(newGameButtonPressed),
            for: .touchUpInside
        )
    }
    
    func createSquareGrid(size: ClosedRange<Int>) {
        for i in size {
            let stackView = createHorizontalStackView()
            mainStackView.addArrangedSubview(stackView)
            
            gamePlayArray.append([])
            for j in size {
                let squareView = SquareView()
                gamePlayArray[i-1].append("")
                
                squareView.onButtonSelection = {
                    if self.isXState {
                        self.gamePlayArray[i-1][j-1] = "X"
                        squareView.set(value: "X")
                    } else {
                        self.gamePlayArray[i-1][j-1] = "O"
                        squareView.set(value: "O")
                    }
                    self.isXState.toggle()
                }
                
                let height = (Int(view.frame.width) - 50 - (size.upperBound - 1)*5)/size.upperBound
                NSLayoutConstraint.activate([
                    squareView.heightAnchor.constraint(equalToConstant: CGFloat(height))
                ])
                
                squareViews.append(squareView)
                stackView.addArrangedSubview(squareView)
            }
        }
        gameState = .started
        isReadyForValidations = true
    }
    
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }
    
    @objc func newGameButtonPressed() {
        gameState = .started
    }
    
    func checkGameStatus() {
        for i in gamePlayArray.indices {
            if gamePlayArray[i][0] != "" && gamePlayArray[i][0] == gamePlayArray[i][1] && gamePlayArray[i][0] == gamePlayArray[i][2] {
                gameState = .win(winner: gamePlayArray[i][0])
                return
            }

            if gamePlayArray[0][i] != "" && gamePlayArray[0][i] == gamePlayArray[1][i] && gamePlayArray[0][i] == gamePlayArray[2][i] {
                gameState = .win(winner: gamePlayArray[0][i])
                return
            }
        }

        // now check diagonally top left to bottom right
        if gamePlayArray[0][0] != "" && gamePlayArray[0][0] == gamePlayArray[1][1] && gamePlayArray[0][0] == gamePlayArray[2][2] {
            gameState = .win(winner: gamePlayArray[0][0])
            return
        }

        // and check diagonally bottom left to top right
        if gamePlayArray[0][2] != "" && gamePlayArray[0][2] == gamePlayArray[1][1] && gamePlayArray[0][2] == gamePlayArray[2][0] {
            gameState = .win(winner: gamePlayArray[0][2])
            return
        }
    }
}
// MARK: - Layout
extension ViewController {
    private func initWinnerLabel() {
        winnerLabel = UILabel()
        winnerLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        winnerLabel.numberOfLines = 0
        winnerLabel.textAlignment = .center
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initOverlayView() {
        overlayView = UIView()
        overlayView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.2)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initNewgameButton() {
        newGameButton = UIButton(type: .system)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.white, for: .normal)
        newGameButton.layer.cornerRadius = 12
        newGameButton.backgroundColor = .darkText
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 35, weight: .heavy)
        titleLabel.textColor = .black
        titleLabel.text = "TicTacToe"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initStackView() {
        mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .black
    }
    
    private func constructHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(mainStackView)
        view.addSubview(newGameButton)
        view.addSubview(overlayView)
        view.addSubview(winnerLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            overlayView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            
            winnerLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 25),
            winnerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            winnerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            newGameButton.heightAnchor.constraint(equalToConstant: 45),
            newGameButton.widthAnchor.constraint(equalToConstant: 200),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}
