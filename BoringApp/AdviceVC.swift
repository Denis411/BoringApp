//
//  ViewController.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 21.09.2021.
//

import UIKit
import SwiftUI

class AdviceVC: UIViewController {

    @IBOutlet weak var adviceCardView: UIView!
    @IBOutlet weak var adviceCardTextField: UITextView!
    @IBOutlet weak var numberOfParticipantsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tagView: BATagView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:- подумать о лучшем варианте
        clearUI()
        
        configureAdviceCardView()
        getActivity()
    }
    
    @IBAction func refreshActivity(_ sender: UIButton) {
        getActivity()
    }
    
    private func updateUIElements(with activity: Activity) {
        DispatchQueue.main.async {
            self.typeLabel.text = activity.type.capitalizingFirstLetter()
            self.adviceCardTextField.text = activity.activity
            self.numberOfParticipantsLabel.text = String(activity.participants)
            
            switch activity.price {
            case 0:
                self.costLabel.text = "free"
            case 0.01...0.29:
                self.costLabel.text = "cheap"
            case 0.30...0.69:
                self.costLabel.text = "average"
            case 0.70...:
                self.costLabel.text = "pricy"
            default:
                self.costLabel.text = "???"
            }
        }
    }
    
    private func clearUI() {
        DispatchQueue.main.async {
            self.typeLabel.text = ""
            self.adviceCardTextField.text = ""
            self.numberOfParticipantsLabel.text = ""
            self.costLabel.text = ""
        }
    }

    private func configureAdviceCardView() {
        adviceCardView.layer.cornerCurve = .continuous
    }
    
    private func getActivity() {
        NetworkManager.shared.getActivity { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let activity):
                self.updateUIElements(with: activity)
            case .failure(let error):
                print(error)
            }
        }
    }
}

