//
//  FadeViews.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit


class FadeHead: UIView {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        let baseColor = UIColor.black
        l.colors = [
            baseColor.withAlphaComponent(1),
            baseColor.withAlphaComponent(0),
        ].map{$0.cgColor}
        layer.addSublayer(l)
        return l
    }()
    
    func newGrad() {
        layer.sublayers?.removeAll()
        
        let l = CAGradientLayer()
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        let baseColor = UIColor.black
        l.colors = [
            baseColor.withAlphaComponent(1),
            baseColor.withAlphaComponent(0),
        ].map{$0.cgColor}
        layer.addSublayer(l)
        l.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newGrad()
    }
    
}

class FadeTail: UIView {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        let baseColor = UIColor.black
        l.colors = [
            baseColor.withAlphaComponent(0),
            baseColor.withAlphaComponent(1),
        ].map{$0.cgColor}
        layer.addSublayer(l)
        return l
    }()
    
    func newGrad() {
        layer.sublayers?.removeAll()
        let l = CAGradientLayer()
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        let baseColor = UIColor.black
        l.colors = [
            baseColor.withAlphaComponent(0),
            baseColor.withAlphaComponent(1),
        ].map{$0.cgColor}
        layer.addSublayer(l)
        l.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newGrad()
    }
    
}
