//
//  ViewController.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 21.09.2021.
//

import UIKit

class AdviceVC: UIViewController {

    @IBOutlet weak var adviceCardView: UIView!
    @IBOutlet weak var tagView: BATagView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdviceCardView()
    }

    private func configureAdviceCardView() {
        adviceCardView.layer.cornerCurve = .continuous
    }
}

