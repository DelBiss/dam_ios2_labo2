//
//  KeyboardController.swift
//  pendu
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-06-04.
//

import UIKit

protocol hangmanInputController {
    func onPress(input: String)
    
}

protocol hangmanInput {
    var controller:hangmanInputController? {get set}
}

protocol hangmanView {
    func reset()
    func disable()
}

class KeyboardController: UIView, hangmanInputController, hangmanView, hangmanInput  {
    func disable() {
        for button in hangmanInputViews {
            button.disable()
            
        }
    }
    
    var controller: hangmanInputController?
    
    func reset() {
        for button in hangmanInputViews {
            button.reset()
        }
    }
    
    func onPress(input: String) {
        print("Keyboard: " + input)
        controller?.onPress(input: input)
    }
    
  

    @IBOutlet var view: KeyboardController!
    @IBOutlet var hangmanInputViews: [KeyboardButtonController]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    //MARK:
    func loadViewFromNib() {
        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        for HIView in hangmanInputViews {
            HIView.controller = self
        }
    }

}
