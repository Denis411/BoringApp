//
//  BAFilterTypeButton.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 24.09.2021.
//

import UIKit

@IBDesignable class BAFilterTypeButton: UIButton {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable public var cornerCurve: Bool = true {
        didSet { layer.cornerCurve = .continuous }
    }
    
    @IBInspectable public var maskedCorners: Bool = true {
        didSet { layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner] }
    }
    
    public var buttonSelected: Bool = false {
        didSet {
            if buttonSelected {
                self.alpha = 1.0
            } else {
                self.alpha = 0.3
            }
        }
    }
}
