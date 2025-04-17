//
//  CalculatorVC.swift
//  calculator
//
//  Created by Sami Gündoğan on 16.04.2025.
//

import UIKit

class CalculatorVC: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    
    enum Operation: Int {
        case add = 1,
             subtract,
             multiply,
             divide
    }
    
    var displayValue : String = "" // ekranda gösterilen değer
    var storedValue: Double =  0 // işlem için saklanan ilk sayı
    var currentOperation: Operation? = nil // seçilen işlem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayValue // app açıldığında ekranı temizle
    }

    @IBAction func numberTapped(_ sender: UIButton) { // rakam butonları
        let number = sender.tag
        if displayValue == "0" {
            displayValue = String(number)
        }else {
            displayValue += String(number)
        }
        displayLabel.text = displayValue // label i güncelle
    }

    @IBAction func decimalButton(_ sender: UIButton) { // (,) butonu için nokta ekler
        if !displayValue.contains(".") {
            displayValue += "."
            displayLabel.text = displayValue
        }
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        let secondValue = Double(displayValue) ?? 0 // 2. sayı alınır
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
        displayValue = format(result) // sonucu formatla
        displayLabel.text = displayValue
        currentOperation = nil
    }
    
    private func showDivisionByZeroAlert() {
            let alert = UIAlertController(title: "Warning!", message: "Dividing by zero breaks the universe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    private func format(_ value: Double) -> String {    // sonucu düzgün biçimde gösteren yardımcı fonksiyon
            return value.truncatingRemainder(dividingBy: 1) == 0 ?
                String(Int(value)) :
                String(format: "%.2f", value) // değilse virgülden sonra 2 basamak
        }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        displayValue = "0"
        storedValue = 0
        currentOperation = nil
        displayLabel.text = displayValue
    }
    
    @IBAction func operationTapped(_ sender: UIButton) {
        let tag = sender.tag
        guard currentOperation == nil else { return }
        storedValue = Double(displayValue) ?? 0
        
        if let operation = Operation(rawValue: tag) {
            currentOperation = operation
        }else{
            print("Invalid operation")
        }
        displayValue = "0"
    }
    
    @IBAction func percentTapped(_ sender: UIButton) {  // "%" butonuna tıklanınca çalışır, sayıyı 100'e böler
        let value = Double(displayValue) ?? 0
        displayValue = String(value / 100)
        displayLabel.text = displayValue
    }
    
    @IBAction func invertSignTapped(_ sender: UIButton) {  // "+/-" butonuna tıklanınca sayının işaretini tersine çevirir
        let value = Double(displayValue) ?? 0
        displayValue = String(value * -1)
        displayLabel.text = displayValue
    }
    
}
