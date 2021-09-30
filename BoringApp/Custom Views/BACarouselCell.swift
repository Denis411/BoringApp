//
//  CarouselCell.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 29.09.2021.
//

import UIKit

class BACarouselCell: UICollectionViewCell {

    // MARK: - SubViews

    private lazy var cardView = UIView()

    private lazy var typeView = UIView()
    private lazy var typeLabel = UILabel()

    private lazy var textField = UITextView()

    private lazy var stackView = UIStackView()

    private lazy var participantImage = UIImageView()
    private lazy var numberOfParticipantsLabel = UILabel()

    private lazy var priceImage = UIImageView()
    private lazy var priceLabel = UILabel()

    // MARK: - Properties

    static let cellID = "CarouselCell"

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups

private extension BACarouselCell {
    func setupUI() {
        backgroundColor = .clear
        setupCardView()
    }

    private func setupCardView() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        cardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowOffset = CGSize(width: 0, height: 6)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.cornerCurve = .continuous
        cardView.layer.cornerRadius = 12

        setupTypeView()
        setupTextView()
        setupParticipantView()
        setupPriceView()
    }

    private func setupTypeView() {
        cardView.addSubview(typeView)
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        typeView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        typeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        typeView.layer.backgroundColor = UIColor.systemRed.cgColor
        typeView.layer.cornerCurve = .continuous
        typeView.layer.cornerRadius = 12
        typeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]

        typeView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 2).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -2).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 12).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -12).isActive = true
        typeLabel.textColor = .white
    }

    private func setupTextView() {
        cardView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 6).isActive = true
        textField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 6).isActive = true
        textField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -6).isActive = true
        textField.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30).isActive = true
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.textAlignment = .natural
    }

    private func setupParticipantView() {
        cardView.addSubview(participantImage)
        participantImage.translatesAutoresizingMaskIntoConstraints = false
        participantImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 6).isActive = true
        participantImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -6).isActive = true
        participantImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        participantImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        participantImage.image = UIImage(systemName: "person.fill")
        participantImage.tintColor = .black

        cardView.addSubview(numberOfParticipantsLabel)
        numberOfParticipantsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfParticipantsLabel.leadingAnchor.constraint(equalTo: participantImage.trailingAnchor,
                                                           constant: 6).isActive = true
        numberOfParticipantsLabel.centerYAnchor.constraint(equalTo: participantImage.centerYAnchor).isActive = true
        numberOfParticipantsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setupPriceView() {
        cardView.addSubview(priceImage)
        cardView.addSubview(priceLabel)

        priceImage.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        priceImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -6).isActive = true
        priceImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        priceImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        priceImage.image = UIImage(systemName: "dollarsign.circle")
        priceImage.tintColor = .black

        priceLabel.leadingAnchor.constraint(equalTo: priceImage.trailingAnchor, constant: 6).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: priceImage.centerYAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -6).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

// MARK: - Public
extension BACarouselCell {
    public func configure(type: String, activity: String, participants: Int, price: Double) {
        let capitalizedTypeLabel = type.capitalizingFirstLetter()
        typeLabel.text = capitalizedTypeLabel
        textField.text = activity
        numberOfParticipantsLabel.text = String(participants)

        switch price {
        case 0..<0.1:
            priceLabel.text = "free"
        case 0.1..<0.3:
            priceLabel.text = "cheap"
        case 0.3..<0.7:
            priceLabel.text = "average"
        case 0.7...:
            priceLabel.text = "pricey"
        default:
            priceLabel.text = "???"
        }
    }
}
