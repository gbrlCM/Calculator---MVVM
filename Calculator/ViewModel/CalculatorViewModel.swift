//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Gabriel Ferreira de Carvalho on 06/01/22.
//

import Foundation

final class CalculatorViewModel {
    var firstNumber: Double?
    var secondNumber: Double?
    var operation: Operation?
    var didPressComma: Bool
    var lastResult: Double
    weak var delegate: CalculatorViewModelDelegate?
    
    init() {
        firstNumber = nil
        secondNumber = nil
        lastResult = 0
        operation = nil
        didPressComma = false
    }
    
    private func executeOperation() {
        defer { self.lastResult = lastResult.rounded(nOfDecimals: 6) }
        
        guard
            let firstNumber = firstNumber,
            let secondNumber = secondNumber,
            let operation = operation,
            let delegate = delegate
        else {
            delegate?.displayResults("" )
            return
        }
        
        switch operation {
        case .plus:
            lastResult = firstNumber + secondNumber
            delegate.displayResults("\(lastResult)")
        case .minus:
            lastResult = firstNumber - secondNumber
            delegate.displayResults("\(lastResult)")
        case .multiplication:
            lastResult = firstNumber * secondNumber
            delegate.displayResults("\(lastResult)")
        case .division:
            lastResult = firstNumber / secondNumber
            delegate.displayResults("\(lastResult)")
        case .equal:
            break
        }
    }
    
    func tapComma() {
        didPressComma = true
    }
    
    func tapNumber(number: Int) {
        let newNumber: Double
        if operation == nil {
            newNumber = calculateNewNumber(for: firstNumber, adding: number)
            firstNumber = newNumber
        } else {
            newNumber = calculateNewNumber(for: secondNumber, adding: number)
            secondNumber = newNumber
        }
        
        delegate?.displayResults(generateDisplayText())
    }
    
    func tapOperation(_ operation: Operation) {
        if operation == .equal {
            executeOperation()
            self.firstNumber = nil
            self.secondNumber = nil
            self.operation = nil
            didPressComma = false
            return
        }
        
        self.operation = operation
        
        if firstNumber == nil {
            firstNumber = 0
        }
        
        didPressComma = false
        delegate?.displayResults(generateDisplayText())
        
    }
    
    private func generateDisplayText() -> String {
        var string: String = ""
        
        if let firstNumber = firstNumber {
            string.append("\(firstNumber)")
        }
        
        if let operation = operation {
            string.append(" \(operation.rawValue) ")
        }
        
        if let secondNumber = secondNumber, operation != nil{
            string.append("\(secondNumber)")
        }
        
        return string
    }
    
    private func calculateNewNumber(for original: Double?, adding value: Int) -> Double {
        if didPressComma {
            if let original = original {
                var newValue = original
                let nOfDecimals = Decimal(newValue).significantFractionalDecimalDigits
                let addedDecimal = (Double(value) / pow(10, Double(nOfDecimals+1)))
                newValue += addedDecimal
                
                return newValue.rounded(nOfDecimals: 6)
            } else {
                return (Double(value)*0.1).rounded(nOfDecimals: 6)
            }
        } else {
            if let original = original {
                var newValue = original*10
                newValue += Double(value)
                return newValue.rounded(nOfDecimals: 6)
            } else {
                return Double(value).rounded(nOfDecimals: 6)
            }
        }
    }
    
}

protocol CalculatorViewModelDelegate: AnyObject {
    func displayResults(_ result: String)
}
