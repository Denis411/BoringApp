//
//  BATagView.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 22.09.2021.
//

import UIKit
import SwiftUI

@IBDesignable class BATagView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerCurve = .continuous
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var maskedCorners: Bool {
        get {
            if !layer.maskedCorners.isEmpty {
                return false
            } else {
                return true
            }
        }
        set { layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner] }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
