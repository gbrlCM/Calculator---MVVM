//
//  CalcalutorViewModelDelegateDummy.swift
//  CalculatorTests
//
//  Created by Gabriel Ferreira de Carvalho on 10/01/22.
//

import Foundation
@testable import Calculator

final class CalcalutorViewModelDelegateDummy: CalculatorViewModelDelegate {
    var displayedResult: String = ""
    
    func displayResults(_ result: String) {
        displayedResult = result
    }
}
