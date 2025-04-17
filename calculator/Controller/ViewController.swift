//
//  ViewController.swift
//  calculator
//
//  Created by Sami Gündoğan on 16.04.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func numberTapped(_ sender: UIButton) {
        displayLabel.text = String(describing: sender.tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

