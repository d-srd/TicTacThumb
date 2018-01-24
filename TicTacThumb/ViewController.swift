//
//  ViewController.swift
//  TicTacThumb
//
//  Created by Dino Srdoč on 23/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import UIKit

@IBDesignable
class TicTacButton: UIButton {
    @IBInspectable
    var x: Int = 0
    @IBInspectable
    var y: Int = 0
}

extension UIColor {
    static var appleBlue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
}

class ViewController: UIViewController {
    // tic tac toe board is represented by 9 clickable buttons
    @IBOutlet var ticTacControls: [UIButton]!
    // displays name of next "player" and whether the game is won or board is full
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    // grid of pieces in a tic tac toe game
    var board: TicTacBoard<GamePieces> = TicTacBoard<GamePieces>(size: 3)
    // start the game with x
    var currentPlayer = GamePieces.x
    
    // don't immediately reset because the user won't see who won
    func resetUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let wself = self else { return }
            for control in wself.ticTacControls {
                control.setTitle(nil, for: .normal)
                control.tintColor = UIColor.appleBlue
            }
        }
    }
    
    @IBAction func ticTacFieldPressed(_ sender: TicTacButton) {
        // the selected field is empty
        guard board[sender.y, sender.x] == nil else {
            return
        }
        
        board[sender.y, sender.x] = currentPlayer
        sender.setTitle(String(describing: currentPlayer), for: .normal)
        
        if board.isWon(byPiece: currentPlayer) {
            board.reset()
            resetUI()
            
            return
        }
        
        guard !board.isFull else {
            board.reset()
            resetUI()
            currentPlayer = .x
            
            return
        }
        
        currentPlayer = currentPlayer.next
    }

}

