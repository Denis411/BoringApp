//
//  BATagView.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 22.09.2021.
//

import UIKit

@IBDesignable class BATagView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
