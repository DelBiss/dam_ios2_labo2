//
//  GameViewController.swift
//  pendu
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-06-04.
//

import UIKit

@IBDesignable class GameViewController: UIViewController, hangmanInputController {
    func onPress(input: String) {
        game?.guest(input)
        showState()
    }
    
    func showState(){
        self.answerLabel.text = self.game?.output
        self.wrong.text = self.game?.remaining
        if(game?.state == .win){
            keyboard.disable()
            view.backgroundColor = UIColor(named: "bgColorWin")
        } else if game?.state == .fail {
            keyboard.disable()
            view.backgroundColor = UIColor(named: "bgColorFail")
        }
    }
    
    enum GameType {
        case Dictionnary, Movie
    }
    @IBInspectable var isMovie:Bool = false
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var wrong: UILabel!
    @IBOutlet var keyboard: KeyboardController!
    var game:Game?
    
    @IBAction func reset() {
        
        RandomFrenchWord.shared.get { (words) in
            self.game = Game(word: words)
            self.keyboard.reset()
            self.showState()
            if self.isMovie {
                self.view.backgroundColor = UIColor(named: "bgColorGameMovie")
            } else {
                self.view.backgroundColor = UIColor(named: "bgColorGame")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboard.controller = self
        game = Game(word:"Hello World")
        showState()
    }


    

}
