//
//  FavoritesVC.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 28.09.2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private var carouselView: BACarouselView?
    
    private var favorites: [Activity] = []
    private var carouselData = [BACarouselView.BACarouselData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        loadData()
        carouselView = BACarouselView(pages: carouselData.count)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        carouselView?.configureView(with: carouselData)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let activity = favorites[carouselView!.currentPage]
        PersistenceManager.updateWith(favorite: activity, actionType: .remove) { error in
            guard let error = error else {
                if let index = self.favorites.firstIndex(of: activity) {
                    self.favorites.remove(at: index)
                    self.carouselData.removeAll()
                    self.loadData()
                    self.carouselView?.configureView(with: self.carouselData)
                }
                return
            }

            self.presentBAAlertOnMainThread(title: "Can`t delete activity", message: error.rawValue, errorType: .error)
        }
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func setupUI() {
        guard let carouselView = carouselView else { return }
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        carouselView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        carouselView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130).isActive = true
    }
    
    private func loadData() {
        for activity in favorites {
            carouselData.append(.init(type: activity.type, activity: activity.activity, participants: activity.participants, price: activity.price))
        }
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                self.presentBAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, errorType: .error)
            }
        }
    }
}
