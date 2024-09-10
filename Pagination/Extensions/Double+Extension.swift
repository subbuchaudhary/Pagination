//
//  Double+Extension.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

extension Double {
    var toCurrencyValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        let number = NSNumber(value: self.roundToDecimal(2))
        guard let formattedValue = formatter.string(from: number) else { return "$0.00" }
        return formattedValue
    }

    var toPercentageValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        let number = NSNumber(value: self.roundToDecimal(2))
        guard let formattedValue = formatter.string(from: number) else { return "0%" }
        return "\(formattedValue)%"
    }

    private func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
