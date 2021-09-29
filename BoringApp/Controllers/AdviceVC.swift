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
    private var activityPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearUIOnStart()
        getActivity()
    }
    
    @IBAction func refreshActivity(_ sender: UIButton) {
        getActivity()
    }
    
    @IBAction func favoriteActivity(_ sender: UIButton) {
        if let activity = adviceCardTextField.text,
           let participants = Int(numberOfParticipantsLabel.text!),
           let type = typeLabel.text?.lowercased(),
           let price = activityPrice {
            let favorite = Activity(activity: activity, type: type, participants: participants, price: price, link: nil)
            
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.presentBAAlertOnMainThread(title: "Success!", message: "You have successfully favorited this activity", errorType: .success)
                    return
                }
                
                self.presentBAAlertOnMainThread(title: "Sometging went wrong.", message: error.rawValue, errorType: .error)
            }
        }
    }
    
    private func updateUIElements(with activity: Activity) {
        DispatchQueue.main.async {
            self.typeLabel.text = activity.type.capitalizingFirstLetter()
            self.adviceCardTextField.text = activity.activity
            self.numberOfParticipantsLabel.text = String(activity.participants)
            
            self.activityPrice = activity.price
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
                self.presentBAAlertOnMainThread(title: "No Activity", message: error.rawValue, errorType: .warning)
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
        
        if segue.identifier == "showFavorites" {
            let favoritesVC = segue.destination as! FavoritesVC
            favoritesVC.modalPresentationStyle = .fullScreen
        }
    }
}

extension AdviceVC: FilterVCDelegate {
    func modalViewDidDismiss() {
        getActivity()
    }
    
    func filterUpdated(_ filter: Filter) {
        requestFilter = filter
    }
    
}

