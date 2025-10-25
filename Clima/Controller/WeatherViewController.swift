//
//  ViewController.swift
//  Clima
//
//  Created by Cengiz Ekmekçi on 8.10.2025.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController   {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    
    
    @IBAction func currentLocation(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    
    
}


//Mark: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
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
}



 //Mark: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityNameCapitalized
        }
    }
    func didFailWithError(error: Error) {
        print("Failed to fetch weather: \(error)")
    }
}

//Mark: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.startUpdatingLocation( )
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
