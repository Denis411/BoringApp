//
//  Price.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 25.09.2021.
//

import Foundation

enum Price {
    case free(price: Double)
    case cheap(minimalPrice: Double, maximumPrice: Double)
    case average(minimalPrice: Double, maximumPrice: Double)
    case pricey(minimalPrice: Double, maximumPrice: Double)
}
