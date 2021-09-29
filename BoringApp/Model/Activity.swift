//
//  Activity.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import Foundation

struct Activity: Codable, Hashable {
    let activity: String
    let type: String
    let participants: Int
    let price: Double
    let link: String?
}
