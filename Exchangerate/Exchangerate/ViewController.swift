//
//  ViewController.swift
//  Exchangerate
//
//  Created by Edgar Sargsyan on 26.08.23.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var valutaTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!

    @IBAction func exchangeButton(_ sender: Any) {
        guard let baseCurrency = valutaTextField.text, let moneyText = moneyTextField.text else {
            return
        }
        
        fetchExchangeRates { result in 
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    let responseVC = self.storyboard?.instantiateViewController(withIdentifier: "ResponseController") as! ResponseController
                    responseVC.baseCurrency = baseCurrency
                    responseVC.multiplier = Double(moneyText) ?? 1.0
                    responseVC.rates = model.rates
                    self.navigationController?.pushViewController(responseVC, animated: true)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
        func fetchExchangeRates(completion: @escaping (Result<Model, Error>) -> Void) {
            guard let url = URL(string: "https://api.exchangerate.host/latest") else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Model.self, from: data!)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
}
