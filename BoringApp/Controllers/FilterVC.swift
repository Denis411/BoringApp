//
//  SettingsVC.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import UIKit
import SwiftUI

protocol FilterVCDelegate {
    func filterUpdated(_ filter: Filter)
    func modalViewDidDismiss()
}

class FilterVC: UIViewController {
    
    @IBOutlet var typeButtonsCollection: [BAFilterTypeButton]!
    @IBOutlet weak var allTypeButton: BAFilterTypeButton!
    @IBOutlet weak var participantsNumberTextField: UITextField!
    @IBOutlet weak var priceSelector: UISegmentedControl!
    
    var delegate: FilterVCDelegate?
    
    public var requestFilter = Filter()
    private var userSelectedTypes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        prepareFilter()
        delegate?.filterUpdated(requestFilter)
        delegate?.modalViewDidDismiss()
    }
    
    @IBAction func tappedAllTypesButton(_ sender: BAFilterTypeButton) {
        if !sender.buttonSelected {
            sender.buttonSelected = true
            for index in 0..<typeButtonsCollection.count {
                typeButtonsCollection[index].buttonSelected = false
            }
            userSelectedTypes.removeAll()
        }
    }
    
    @IBAction func tappedFilterTypeButton(_ sender: BAFilterTypeButton) {
        if sender.buttonSelected {
            sender.buttonSelected = false
            let typeStringIndex = userSelectedTypes.firstIndex(of: sender.titleLabel!.text!.lowercased())
            if let index = typeStringIndex {
                userSelectedTypes.remove(at: index)
            }
        } else {
            allTypeButton.buttonSelected = false
            sender.buttonSelected = true
            userSelectedTypes.append(sender.titleLabel!.text!.lowercased())
        }
        
        if userSelectedTypes.isEmpty {
            allTypeButton.buttonSelected = true
        }
    }
    
    @IBAction func priceChanged(_ sender: UISegmentedControl) {
        switch priceSelector.selectedSegmentIndex {
        case 0:
            requestFilter.price = nil
        case 1:
            requestFilter.price = .free(price: 0.0)
        case 2:
            requestFilter.price = .cheap(minimalPrice: 0.1, maximumPrice: 0.2)
        case 3:
            requestFilter.price = .average(minimalPrice: 0.3, maximumPrice: 0.6)
        case 4:
            requestFilter.price = .pricey(minimalPrice: 0.7, maximumPrice: 1.0)
        default:
            break
        }
    }
    
    private func updateUI() {
        for index in 0..<typeButtonsCollection.count {
            typeButtonsCollection[index].buttonSelected = false
        }
        
        if let types = requestFilter.selectedTypes {
            if !types.isEmpty {
                allTypeButton.buttonSelected = false
                for type in types {
                    for index in 0..<typeButtonsCollection.count {
                        if type.lowercased() == typeButtonsCollection[index].titleLabel!.text!.lowercased() {
                            userSelectedTypes.append(typeButtonsCollection[index].titleLabel!.text!.lowercased())
                            typeButtonsCollection[index].buttonSelected = true
                        }
                    }
                }
            }
        } else {
            allTypeButton.buttonSelected = true
            for index in 0..<typeButtonsCollection.count {
                typeButtonsCollection[index].buttonSelected = false
            }
        }
        
        if let participants = requestFilter.participants {
            participantsNumberTextField.text = String(participants)
        }
        
        if let price = requestFilter.price {
            switch price {
            case .free(_):
                priceSelector.selectedSegmentIndex = 1
            case .cheap(_, _):
                priceSelector.selectedSegmentIndex = 2
            case .average(_, _):
                priceSelector.selectedSegmentIndex = 3
            case .pricey(_, _):
                priceSelector.selectedSegmentIndex = 4
            }
        }
    }
    
    private func prepareFilter() {
        if !userSelectedTypes.isEmpty {
            requestFilter.selectedTypes = userSelectedTypes
        } else {
            requestFilter.selectedTypes = nil
        }
        if !participantsNumberTextField.text!.isEmpty {
            requestFilter.participants = Int(participantsNumberTextField.text!)
        } else {
            requestFilter.participants = nil
        }
        
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
