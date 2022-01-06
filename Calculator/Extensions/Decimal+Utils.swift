//
//  Decimal+Utils.swift
//  Calculator
//
//  Created by Gabriel Ferreira de Carvalho on 06/01/22.
//

import Foundation

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
