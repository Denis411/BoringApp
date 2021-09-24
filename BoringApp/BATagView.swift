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
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var cornerCurve: Bool = true {
        didSet { layer.cornerCurve = .continuous }
    }
    
    @IBInspectable var maskedCorners: Bool = true {
        didSet { layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner] }
    }
}
