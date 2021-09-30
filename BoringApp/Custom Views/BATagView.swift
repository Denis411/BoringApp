//
//  BATagView.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 22.09.2021.
//

import UIKit

@IBDesignable class BATagView: UIView {

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
}
