//
//  CalculatorViewControllerTest.swift
//  CalculatorTests
//
//  Created by Gabriel Ferreira de Carvalho on 10/01/22.
//

@testable import Calculator
import SnapshotTesting
import XCTest

class CalculatorViewControllerTest: XCTestCase {
    
    var sut: CalculatorViewController!

    override func setUp() {
        sut = CalculatorViewController(viewModel: .init())
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
    }

    func testViewLayout() {
        assertSnapshot(matching: sut, as: .image)
    }
}
