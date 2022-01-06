//
//  CalculatorView.swift
//  Calculator
//
//  Created by Gabriel Ferreira de Carvalho on 06/01/22.
//

import Foundation
import UIKit
import SnapKit

final class CalculatorView: UIView {
    
    weak var delegate: CalculatorViewDelegate?
    
    private lazy var numberButtons: [UIButton] = {
        var buttons = Array(1...9).map(makeNumberButton)
        buttons.append(makeNumberButton(0))
        return buttons
    }()
    private lazy var commaButton: UIButton = {
        let button = UIButton()
        button.setTitle(",", for: .normal)
        styleNormalButton(button)
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let delegate = self?.delegate else {
                return
            }
            delegate.tapComma()
        }), for: .touchUpInside)
        return button
    }()
    private lazy var operationButton: [UIButton] = {
        let buttons = Operation.allCases.map(makeOperationButton)
        return buttons
    }()
    private var display: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private lazy var numberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        rowsNumberStackView.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    private lazy var rowsNumberStackView: [UIStackView] = {
        let stackViews = Array(0..<4).map(makeNumberColumnStackView)
        return stackViews
    }()
    private lazy var columnOperationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        operationButton.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        setupHierarchy()
        setupConstraints()
        
        display.text = "CALCULADORA!"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(numberStackView)
        addSubview(display)
        addSubview(columnOperationStackView)
        display.translatesAutoresizingMaskIntoConstraints = false
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        display.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.3)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(display.snp.bottom).offset(16)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        columnOperationStackView.snp.makeConstraints { make in
            make.top.equalTo(display.snp.bottom).offset(16)
            make.leading.equalTo(numberStackView.snp.trailing).offset(16)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.3)
        }
    }
    
    func updateLabel(with value: String) {
        display.text = value
    }
    
    private func makeNumberButton(_ number: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("\(number)", for: .normal)
        styleNormalButton(button)
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let delegate = self?.delegate else {
                return
            }
            delegate.tapNumber(number)
        }), for: .touchUpInside)
        return button
    }
    
    private func styleNormalButton(_ button: UIButton) {
        normalButtonStyle(button)
        button.backgroundColor = .darkGray
    }
    
    private func normalButtonStyle(_ button: UIButton) {
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
    }
    
    private func makeOperationButton(_ operation: Operation) -> UIButton {
        let button = UIButton()
        button.setTitle(operation.rawValue, for: .normal)
        normalButtonStyle(button)
        button.backgroundColor = .orange
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let delegate = self?.delegate else {
                return
            }
            delegate.tapOperation(operation)
        }), for: .touchUpInside)
        return button
    }
    
    private func makeNumberColumnStackView(_ column: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        if column == 3 {
            stackView.addArrangedSubview(numberButtons[9])
            stackView.addArrangedSubview(commaButton)
            
        } else {
            for i in (column * 3)...(3 * column + 3) {
                stackView.addArrangedSubview(numberButtons[i])
            }
        }
        
        return stackView
    }
    
}

protocol CalculatorViewDelegate: AnyObject {
    func tapNumber(_ number: Int)
    func tapOperation(_ operation: Operation)
    func tapComma()
}
