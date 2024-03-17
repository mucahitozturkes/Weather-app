//
//  ViewController.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
   
    
    @IBOutlet weak var temp4Label: UILabel!
    @IBOutlet weak var temp3Label: UILabel!
    @IBOutlet weak var temp2Label: UILabel!
    @IBOutlet weak var temp1Label: UILabel!
    
    @IBOutlet weak var date4Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date1Label: UILabel!
    
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
        locationManager.delegate               = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        cityNameTextField.delegate             = self
        WeatherNetworkManager.shared.delegate  = self
        ForecastNetworkManager.shared.delegate = self
     
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
            WeatherAPI.shared.fetchWeather(cityName: city)
        }
    }
}


extension ViewController: NetworkManagerDelegate {
    
    func didUpdateWeather(_ networkManager: WeatherNetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
               self.cityCal.text       = weather.temperatureString
               self.cityNameLabel.text = weather.cityName
               self.feelings.text      = weather.feelsLikeString
               self.humidity.text      = weather.humidityString
               self.wind.text          = weather.windString
               self.descrption.text    = weather.descriptions

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
  
    
    
    func didFailWithErrorWeather(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: ForecastNetworkManagerDelegate {
    
    func didUpdateForecast(_ networkManager: ForecastNetworkManager, forecast: ForecastModel) {
         
        DispatchQueue.main.async {
            self.date1Label.text    = forecast.dates1
            self.date2Label.text    = forecast.dates2
            self.date3Label.text    = forecast.dates3
            self.date4Label.text    = forecast.dates4
            
        }
           
    }
    
    func didFailWithErrorForecast(error: Error) {
        print(error)
    }
    
}



extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            WeatherAPI.shared.fetchWeather(latitude: lat, longitude: lon)
            ForecastAPI.shared.fetchCityName(latitude: lat, longitude: lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
