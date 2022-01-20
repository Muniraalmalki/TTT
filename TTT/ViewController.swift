//
//  ViewController.swift
//  TTT
//
//  Created by munira almallki on 25/02/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    var debug = true
    
    @IBOutlet weak var winnerLabel: UILabel!
     @IBAction func resetButtonPressed(_ sender: UIButton) {
     reset()
    }
    class Line {
        var redCount = 0
        var blueCount = 0
        func upCount(currentPlayerRed: Bool) {
            if currentPlayerRed {
                self.redCount += 1
            }
            else {
                self.blueCount += 1
            }
        }
    }
    class Game {
        var winningLines: [String: Line] = ["topRow": Line(),
            "midRow": Line(),"bottom": Line(),"left": Line(),"midCol": Line(),"right": Line(),"diag1": Line(),"diag2": Line()]
        var check: [Int:[String]] = [1: ["topRow", "left", "diag1"],2: ["topRow", "midCol"],3: ["topRow", "right", "diag2"],4: ["midRow", "left"],5: ["midRow","midCol", "diag1", "diag2"],6: ["midRow", "right"],7: ["left", "bottom", "diag2"],8: ["bottom", "midCol"],9: ["bottom", "right", "diag1"]
        ]
        func isWinningMove(space: Int, isRed yesOrNo: Bool) -> Bool {
            
            for line_name in check[space]! {
                let potentialWin = winningLines[line_name]!
                potentialWin.upCount(currentPlayerRed: yesOrNo)
                if potentialWin.redCount >= 3 || potentialWin.blueCount >= 3 {
                    return true
                }
            }
            
            return false
        }
        
        func reset() {
            for line in self.winningLines {
                line.1.redCount = 0
                line.1.blueCount = 0
            }
        }
  
    func debug() {
        for line in self.winningLines {
            print(line.0, ": blue: ", line.1.blueCount, ", red: ", line.1.redCount)
        }
    }
}
    @IBOutlet var spaceButtons: [UIButton]!
    var playerIsRed = true
    
    var done = false
    var game = Game()
    func reset(){
            
            for button in spaceButtons {
                button.backgroundColor = UIColor.lightGray
            }
            done = false
            
            winnerLabel.isHidden = true
            game.reset()
        }
   
    @IBAction func squarePressed(_ sender: UIButton) {
        var playerColor: UIColor
        if playerIsRed {
            playerColor = UIColor.red
        }
        else {
            playerColor = UIColor.blue
        }
      
        if sender.backgroundColor == UIColor.lightGray && !done {
            sender.backgroundColor = playerColor
            
            checkWin(space: sender.tag)
            playerIsRed = !playerIsRed
        }
        
        if debug == true {
            print("Player red: ", playerIsRed, ", box: ", sender.tag)
            game.debug()
        }
    }
    
        
        
    func checkWin(space:Int){
        var winner = ""
        if playerIsRed{
            winner = "Congrats, Red Win"
        }else{
            winner = "Congrats, Blue Win"
        }
        if game.isWinningMove(space: space , isRed: playerIsRed){
            winnerLabel.text = winner
            winnerLabel.isHidden = false
            done = true
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
      reset()
    }

}


