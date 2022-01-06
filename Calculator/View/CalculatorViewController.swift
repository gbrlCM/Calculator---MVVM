//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Gabriel Ferreira de Carvalho on 06/01/22.
//

import Foundation
import UIKit

final class CalculatorViewController: UIViewController {
    
    let contentView = CalculatorView()
    let viewModel: CalculatorViewModel
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        viewModel.delegate = self
        contentView.delegate = self
    }
}

extension CalculatorViewController: CalculatorViewDelegate {
    func tapNumber(_ number: Int) {
        print("Number \(number)")
        viewModel.tapNumber(number: number)
    }
    
    func tapOperation(_ operation: Operation) {
        viewModel.tapOperation(operation)
    }
    
    func tapComma() {
        viewModel.tapComma()
    }
}

extension CalculatorViewController: CalculatorViewModelDelegate {
    func displayResults(_ result: String) {
        contentView.updateLabel(with: result)
    }
}
