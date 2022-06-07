//
//  KeyboardButtonView.swift
//  pendu
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-06-04.
//

import UIKit

@IBDesignable class KeyboardButtonController: UIView, hangmanInput, hangmanView {
    func disable() {
        isActive = false
        view.backgroundColor = UIColor(named: "KeyInactive")
    }
    
    
    
    
    @IBOutlet var view: KeyboardButtonController!
    @IBOutlet weak var label: UILabel!
    @IBInspectable var letter:String = " "
    var controller:hangmanInputController?{
        get{
            return _controller
        }
        set(val){
            _controller = val
            }
    }
    
    private var _controller:hangmanInputController?
    private var isActive:Bool = true
    
    override func draw(_ rect: CGRect) {
        if (label != nil)  {
            label.text = letter
        }
        
    }
    
    func reset() {
        if !isActive{
            isActive = true
            view.backgroundColor = UIColor(named: "KeyActive")
        }
    }
    
    //MARK:
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
        Bundle.main.loadNibNamed("KeyboardButtonView", owner: self, options: nil)
        addSubview(view)
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    
    @objc func touch(_ sender:UITapGestureRecognizer){
        print("Button: " + letter)
        if isActive{
            controller?.onPress(input: letter)
            disable()
        }
    }
    
    override func didAddSubview(_ subview: UIView) {
        let touchGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(touch(_:)))
        view.addGestureRecognizer(touchGestureRecognizer)
    }
    
}
