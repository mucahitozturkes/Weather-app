//
//  ViewController.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var tempview: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var humLabel: UILabel!
    @IBOutlet weak var feelView: UIImageView!
    @IBOutlet weak var windView: UIImageView!
    @IBOutlet weak var hummView: UIImageView!
    
    @IBOutlet weak var backgorundView: UIView!
    
    @IBOutlet weak var cloud4Image: UIImageView!
    @IBOutlet weak var cloud3Image: UIImageView!
    @IBOutlet weak var cloud2Image: UIImageView!
    @IBOutlet weak var cloud1Image: UIImageView!
    
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
   
    @IBOutlet weak var cityCal: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate               = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       
        WeatherNetworkManager.shared.delegate  = self
        ForecastNetworkManager.shared.delegate = self
        setBackgroundView()
        setHideAll()
       
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func setBackgroundView() {
        backgorundView.layer.cornerRadius = 16
        
    }
    
    func setHideAll() {
        locationButton.addPulseAnimation()
                    self.cityCal.alpha          = 0.0
                    self.cityNameLabel.alpha    = 0.0
                    self.feelings.alpha         = 0.0
                    self.humidity.alpha         = 0.0
                    self.wind.alpha             = 0.0
                    self.descrption.alpha       = 0.0
                    self.imageView.alpha        = 0.0
                    self.hummView.alpha         = 0.0
                    self.windView.alpha         = 0.0
                    self.feelView.alpha         = 0.0
                    self.backgorundView.alpha   = 0.0
                    self.humLabel.alpha         = 0.0
                    self.windLbl.alpha          = 0.0
                    self.feelsLabel.alpha       = 0.0
                    self.tempview.alpha         = 0.0
    }
    
    
    func setUnHideAll() {
        locationButton.removePulseAnimation()
        UIView.animate(withDuration: 3.0) {
                    self.cityCal.alpha          = 1.0
                    self.cityNameLabel.alpha    = 1.0
                    self.feelings.alpha         = 1.0
                    self.humidity.alpha         = 1.0
                    self.wind.alpha             = 1.0
                    self.descrption.alpha       = 1.0
                    self.imageView.alpha        = 1.0
                    self.hummView.alpha         = 1.0
                    self.windView.alpha         = 1.0
                    self.feelView.alpha         = 1.0
                    self.backgorundView.alpha   = 1.0
                    self.humLabel.alpha         = 1.0
                    self.windLbl.alpha          = 1.0
                    self.feelsLabel.alpha       = 1.0
                    self.tempview.alpha         = 1.0
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
            
           
            DispatchQueue.main.async {
                UIView.transition(with: self.backgroundImage,
                                  duration: 3.0,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      let backgroundImageName = weather.setBackgroundImageAsLabel()
                                      if let image = UIImage(named: backgroundImageName) {
                                          self.backgroundImage.image = image
                                      } else {
                                          print("Image named \(backgroundImageName) not found.")
                                      }
                                  },
                                  completion: nil)

            }
            
            
            if let symbolImage = UIImage(systemName: weather.getConditionName())?.withTintColor(.white, renderingMode: .alwaysOriginal) {
                self.imageView.image = symbolImage
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
            
            self.temp1Label.text    = forecast.temp1String
            self.temp2Label.text    = forecast.temp2String
            self.temp3Label.text    = forecast.temp3String
            self.temp4Label.text    = forecast.temp4String
         
            
            if let symbolImage1 = UIImage(systemName: forecast.getConditionName(id: forecast.id1))?.withTintColor(.white, renderingMode: .alwaysOriginal),
               let symbolImage2 = UIImage(systemName: forecast.getConditionName(id: forecast.id2))?.withTintColor(.white, renderingMode: .alwaysOriginal),
               let symbolImage3 = UIImage(systemName: forecast.getConditionName(id: forecast.id3))?.withTintColor(.white, renderingMode: .alwaysOriginal),
               let symbolImage4 = UIImage(systemName: forecast.getConditionName(id: forecast.id4))?.withTintColor(.white, renderingMode: .alwaysOriginal) {
                    self.cloud1Image.image = symbolImage1
                    self.cloud2Image.image = symbolImage2
                    self.cloud3Image.image = symbolImage3
                    self.cloud4Image.image = symbolImage4
                }
            
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
            ForecastAPI.shared.fetchCityLocation(latitude: lat, longitude: lon)
            setUnHideAll()
           
         
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
