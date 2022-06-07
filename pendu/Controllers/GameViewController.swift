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
        if(game?.state == .ended){
            keyboard.disable()
            view.backgroundColor = UIColor.systemBlue
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
            self.view.backgroundColor = UIColor.systemPink
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isMovie {
            view.backgroundColor = UIColor.systemBlue
        } else {
            view.backgroundColor = UIColor.systemPink
        }
        keyboard.controller = self
        game = Game(word:"Hello World")
        showState()
    }


    

}
