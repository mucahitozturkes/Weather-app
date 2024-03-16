//
//  ViewController.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
   
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var wind: UILabel!
    
    @IBOutlet weak var descrption: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var feelings: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityCal: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate        = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        cityNameTextField.delegate      = self
        NetworkManager.shared.delegate  = self
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    

}

extension ViewController: UITextFieldDelegate {
    
    @IBAction func findCity(_ sender: UIButton) {
        cityNameTextField.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = cityNameTextField.text {
            WeatherManager.shared.fetchWeather(cityName: city)
        }
    }
}


extension ViewController: NetworkManagerDelegate {
    
    func didUpdateWeather(_ networkManager: NetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
               self.cityCal.text       = weather.temperatureString
               self.cityNameLabel.text = weather.cityName
               self.feelings.text      = weather.feelsLikeString
               self.humidity.text      = weather.humidityString
               self.wind.text          = weather.windString
               self.descrption.text    = weather.descriptions
             
                print("Name: ", weather.cityName)
                print("Temp: ", weather.temperatureString)
            
            
               if let symbolImage = UIImage(systemName: weather.getConditionName())?.withTintColor(.white, renderingMode: .alwaysOriginal) {
                   self.imageView.image = symbolImage
               }
            DispatchQueue.main.async {
                let backgroundImageName = weather.setBackgroundImageAsLabel()
                if let image = UIImage(named: backgroundImageName) {
                    self.backgroundImage.image = image
                } else {
                    print("Image named \(backgroundImageName) not found.")
                }
            }
              
           }
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}



extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            WeatherManager.shared.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
