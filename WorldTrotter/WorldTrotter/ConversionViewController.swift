//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Leon Jones on 07/02/2018.
//  Copyright © 2018 CAM Software Services. All rights reserved.
//

import UIKit


class ConversionViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var farenheightTextField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn rance: NSRange,
                   replacementString string: String) -> Bool {
        let currentHasDecimal = textField.text?.range(of: ".")
        let replacementHasDecimal = string.range(of: ".")
        return !(currentHasDecimal != nil && replacementHasDecimal != nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Conversion view didLoad")
        updateCelciusLabel()
    }
    
    var farenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    var celciusValue: Measurement<UnitTemperature>? {
        if let farenheitValue = farenheitValue {
            return farenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelciusLabel() {
        if let celciusValue = celciusValue {
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        } else {
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func farenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            farenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        farenheightTextField.resignFirstResponder()
    }
}
