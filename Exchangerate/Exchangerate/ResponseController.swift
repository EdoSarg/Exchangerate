//
//  ResponseController.swift
//  Exchangerate
//
//  Created by Edgar Sargsyan on 26.08.23.
//

import UIKit

class ResponseController: UIViewController {

    @IBOutlet weak var responseLabel: UILabel!
    
    var baseCurrency: String?
      var multiplier: Double = 1.0
      var rates: [String: Double]?

      override func viewDidLoad() {
          super.viewDidLoad()
          calculateAndDisplayResult()
      }
      func calculateAndDisplayResult() {
          guard let baseCurrency = baseCurrency, let rates = rates else {
              return
          }
          
          if let exchangedRate = rates[baseCurrency] {
                     let calculatedAmount = exchangedRate * multiplier
                     responseLabel.text = "\(calculatedAmount) \(baseCurrency)"
                 }
             }
         }
