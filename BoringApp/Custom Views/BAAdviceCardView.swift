//
//  BAAdviceCardView.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 22.09.2021.
//

import UIKit

@IBDesignable class BAAdviceCardView: UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable public var cornerCurve: Bool = true {
        didSet { layer.cornerCurve = .continuous }
    }
    
    @IBInspectable public var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable public var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable public var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable public var shadowColor: UIColor {
        get { return UIColor(cgColor: layer.shadowColor!) }
        set { layer.shadowColor = newValue.cgColor }
    }
}

