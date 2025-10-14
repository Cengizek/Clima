//
//  ViewController.swift
//  Clima
//
//  Created by Cengiz Ekmekçi on 8.10.2025.
//

import UIKit

class WeatherViewController: UIViewController ,UITextFieldDelegate , WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if( textField.text != ""){
            return true
        }
        else {
            textField.placeholder = "Type something..."
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       if let cityName = searchTextField.text {
           weatherManager.fetchWeather(cityName: cityName)
        }
        
        searchTextField.text = ""
    }
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperatureString)
    }
    
    
}

