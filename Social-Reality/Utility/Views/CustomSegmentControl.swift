//
//  CustomSegmentControl.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[(String, UIImage?)]!
    private var buttonImages:[UIImage]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor:UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[(String, UIImage?)]) {
        
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.backgroundColor = UIColor.clear
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[(String, UIImage?)]) {
        
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        buttons.forEach({ $0.tintColor = textColor })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        button.tintColor = selectorTextColor
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.tintColor = textColor
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.tintColor = selectorViewColor
            }
        }
    }
    
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(selectedIndex)
        selectorView = UIView(frame: CGRect(x: selectorPosition, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle.0, for: .normal)
            button.setImage(buttonTitle.1, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.setTitleColor(textColor, for: .normal)
            button.tintColor = textColor
            buttons.append(button)
        }
        buttons[selectedIndex].setTitleColor(selectorTextColor, for: .normal)
        buttons[selectedIndex].tintColor = selectorTextColor
    }
    
}
