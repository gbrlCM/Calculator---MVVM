//
//  CalculatorViewModelTest.swift
//  CalculatorTests
//
//  Created by Gabriel Ferreira de Carvalho on 07/01/22.
//

@testable import Calculator
import XCTest

class CalculatorViewModelTest: XCTestCase {
    
    var sut: CalculatorViewModel!
    var viewModelDelegate: CalcalutorViewModelDelegateDummy!

    override func setUp() {
        sut = CalculatorViewModel()
        viewModelDelegate = .init()
        sut.delegate = viewModelDelegate
    }
    
    override func tearDown() {
        sut = nil
        viewModelDelegate = nil
    }

    func testFirstNumberTap() {
        sut.tapNumber(number: 3)
        XCTAssertEqual(sut.firstNumber, 3)
    }
    
    func testSecondNumberTapWithoutFirst() {
        sut.tapOperation(.minus)
        sut.tapNumber(number: 4)
        XCTAssertEqual(sut.secondNumber, 4)
        XCTAssertNotNil(sut.firstNumber)
    }
    
    func testFirstNumberTapped34() {
        sut.tapNumber(number: 3)
        sut.tapNumber(number: 4)
        XCTAssertEqual(sut.firstNumber, 34)
    }
    
    func testFirstNumberTapped34Dot5() {
        sut.tapNumber(number: 3)
        sut.tapNumber(number: 4)
        sut.tapComma()
        sut.tapNumber(number: 5)
        
        XCTAssertEqual(34.5, sut.firstNumber!)
    }
    
    func testFirstNumberTapped0Dot7() {
        sut.tapComma()
        sut.tapNumber(number: 7)
        XCTAssertEqual(sut.firstNumber!, 0.7)
    }
    
    func testTapCommaTwice() {
        sut.tapNumber(number: 3)
        sut.tapComma()
        sut.tapComma()
        sut.tapNumber(number: 2)
        
        XCTAssertEqual(3.2, sut.firstNumber)
    }
    
    func testTapCommaAfterNumber() {
        sut.tapNumber(number: 3)
        sut.tapComma()
        sut.tapNumber(number: 2)
        sut.tapComma()
        sut.tapNumber(number: 1)
        
        XCTAssertEqual(3.21, sut.firstNumber)
    }
    
    func testSum() {
        executeOperation(.plus)
        XCTAssertEqual(5.6, sut.lastResult)
    }
    
    func testMinus() {
        executeOperation(.minus)
        XCTAssertEqual(1, sut.lastResult)
    }
    
    func testMultiplication() {
        executeOperation(.multiplication)
        XCTAssertEqual(7.59, sut.lastResult)
    }
    
    func testDivision() {
        executeOperation(.division)
        XCTAssertEqual(1.434783, sut.lastResult)
    }
    
    func testClearOfData() {
        executeOperation(.plus)
        XCTAssertNil(sut.firstNumber)
        XCTAssertNil(sut.secondNumber)
        XCTAssertNil(sut.operation)
    }
    
    func testTapOperationsInIncorrectOrder() {
        sut.tapOperation(.division)
        sut.tapOperation(.equal)
        
        XCTAssertNil(sut.firstNumber)
        XCTAssertNil(sut.secondNumber)
        XCTAssertNil(sut.operation)
    }
    
    func testDisplayTextForCorrectOperation() {
        sut.tapNumber(number: 3)
        sut.tapComma()
        sut.tapNumber(number: 3)
        sut.tapOperation(.minus)
        sut.tapNumber(number: 2)
        sut.tapComma()
        sut.tapNumber(number: 3)
        
        XCTAssertEqual(viewModelDelegate.displayedResult, "3.3 - 2.3")
    }
    
    func testDisplayTextForIncorrectOperation() {
        sut.tapOperation(.minus)
        sut.tapOperation(.equal)
        XCTAssertEqual("", viewModelDelegate.displayedResult)
    }
    
    func executeOperation(_ operation: Calculator.Operation) {
        sut.tapNumber(number: 3)
        sut.tapComma()
        sut.tapNumber(number: 3)
        sut.tapOperation(operation)
        sut.tapNumber(number: 2)
        sut.tapComma()
        sut.tapNumber(number: 3)
        sut.tapOperation(.equal)
    }
}
