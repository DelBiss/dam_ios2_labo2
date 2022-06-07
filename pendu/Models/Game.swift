//
//  Game.swift
//  pendu
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-06-05.
//

import Foundation

class Game{
    enum  State {
        case ongoing, ended
    }
    
    private var word:String
    private var wrong:Int
    private let maxWrong:Int = 6
    private var _guess:String
    var state:State
    
    
    var output:String{
        get{
            
            out(word,_guess)
            
            
        }
    }
    
    var remaining:String{
        get{
            String(wrong) + "/" + String(maxWrong)
        }
    }
    
    init(word:String){
        self.word = word
        wrong = 0
        state = .ongoing
        _guess = ""
    }
    
    func guest(_ gletter:String){
        if(state == .ongoing){
            if(word.localizedStandardRange(of: gletter) != nil){
                _guess = _guess + gletter
            } else {
                wrong = wrong + 1
                if wrong >= maxWrong{
                    state = .ended
                }
            }
        }
    }
    
    private func out(_ word:String,_  guess:String) -> String {
        if(state == .ended){
                return word
        }
        
        var output:String = ""
        var isComplete = true
        for letter in word {
            var currentLetter = "ˍ"
            var letterFound = false
            let local = String(letter).folding(options: .diacriticInsensitive, locale: nil).lowercased()
            if String(letter) == " "{
                currentLetter = " "
                letterFound = true
            }
            for gletter in guess {
                if String(gletter).lowercased() == local{
                    currentLetter = String(letter)
                    letterFound = true
                    break;
                }
                
            }
            isComplete = isComplete && letterFound
            output = output + currentLetter
        }
        if(isComplete){
            state = .ended
        }
        return output
        
    }
}
