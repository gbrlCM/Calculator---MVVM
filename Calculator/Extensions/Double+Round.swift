//
//  Double+Round.swift
//  Calculator
//
//  Created by Gabriel Ferreira de Carvalho on 10/01/22.
//

import Foundation

extension Double {
    
    func rounded(nOfDecimals: Double) -> Double {
        let multiplier = pow(10, nOfDecimals)
        return Double((self * multiplier).rounded() / multiplier)
    }
}
