//
//  CalculatorVC.swift
//  calculator
//
//  Created by Sami Gündoğan on 16.04.2025.
//

import UIKit

// MARK: - Operation Enum

enum Operation: Int {
    case add = 1,
         subtract,
         multiply,
         divide
}

class CalculatorVC: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Properties

    private var displayValue: String = "0"
    private var storedValue: Double = 0
    private var currentOperation: Operation? = nil
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayValue
    }

    // MARK: - Actions

    @IBAction func numberTapped(_ sender: UIButton) {
        let number = sender.tag
        if displayValue == "0" {
            displayValue = String(number)
        } else {
            displayValue += String(number)
        }
        displayLabel.text = displayValue
    }

    @IBAction func decimalButton(_ sender: UIButton) {
        if !displayValue.contains(".") {
            displayValue += "."
            displayLabel.text = displayValue
        }
    }

    @IBAction func equalsTapped(_ sender: UIButton) {
        let secondValue = Double(displayValue) ?? 0
        guard let operation = currentOperation else { return }
        var result: Double = 0
        
        switch operation {
        case .add:
            result = storedValue + secondValue
        case .subtract:
            result = storedValue - secondValue
        case .multiply:
            result = storedValue * secondValue
        case .divide:
            if secondValue == 0 {
                showDivisionByZeroAlert()
                return
            }
            result = storedValue / secondValue
        }
        
        displayValue = format(result)
        displayLabel.text = displayValue
        currentOperation = nil
    }

    @IBAction func operationTapped(_ sender: UIButton) {
        let tag = sender.tag
        guard currentOperation == nil else { return }
        storedValue = Double(displayValue) ?? 0
        
        if let operation = Operation(rawValue: tag) {
            currentOperation = operation
        } else {
            print("Invalid operation")
        }
        displayValue = "0"
    }

    @IBAction func percentTapped(_ sender: UIButton) {
        let value = Double(displayValue) ?? 0
        displayValue = String(value / 100)
        displayLabel.text = displayValue
    }

    @IBAction func invertSignTapped(_ sender: UIButton) {
        let value = Double(displayValue) ?? 0
        let invertedValue = value * -1
        
        if invertedValue.truncatingRemainder(dividingBy: 1) == 0 {
            displayValue = String(Int(invertedValue))
        } else {
            displayValue = String(invertedValue)
        }
        displayLabel.text = displayValue
    }

    @IBAction func clearTapped(_ sender: UIButton) {
        displayValue = "0"
        storedValue = 0
        currentOperation = nil
        displayLabel.text = displayValue
    }
}

// MARK: - Private Helpers

private extension CalculatorVC {
    
    func showDivisionByZeroAlert() {
        let alert = UIAlertController(
            title: "Warning!",
            message: "Dividing by zero breaks the universe",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func format(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(format: "%.2f", value)
        }
    }
}
