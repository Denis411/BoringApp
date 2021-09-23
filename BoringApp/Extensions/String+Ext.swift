//
//  String+Ext.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
