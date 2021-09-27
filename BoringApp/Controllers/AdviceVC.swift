//
//  ViewController.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 21.09.2021.
//

import UIKit

class AdviceVC: UIViewController {

    @IBOutlet weak var adviceCardView: UIView!
    @IBOutlet weak var adviceCardTextField: UITextView!
    @IBOutlet weak var numberOfParticipantsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tagView: BATagView!
    
    private var requestFilter: Filter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearUIOnStart()
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
            case 0..<0.1:
                self.costLabel.text = "free"
            case 0.1..<0.3:
                self.costLabel.text = "cheap"
            case 0.3..<0.7:
                self.costLabel.text = "average"
            case 0.7...:
                self.costLabel.text = "pricey"
            default:
                self.costLabel.text = "???"
            }
        }
    }
    
    private func clearUIOnStart() {
        self.typeLabel.text = ""
        self.adviceCardTextField.text = ""
        self.numberOfParticipantsLabel.text = ""
        self.costLabel.text = ""
    }
    
    private func getActivity() {
        NetworkManager.shared.getActivity(with: requestFilter) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let activity):
                self.updateUIElements(with: activity)
            case .failure(let error):
                print(error.rawValue)
                self.presentBAAlertOnMainThread(title: "No Activity", message: error.rawValue)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilter" {
            let filterVC = segue.destination as! FilterVC
            filterVC.delegate = self
            if let filter = requestFilter {
                filterVC.requestFilter = filter
            }
        }
    }
}

extension AdviceVC: FilterVCDelegate {
    func modalViewDidDismiss() {
        clearUIOnStart() // Strange flashing UI bug without cleaning, maybe just simulator problem
        getActivity()
    }
    
    func filterUpdated(_ filter: Filter) {
        requestFilter = filter
    }
    
}

