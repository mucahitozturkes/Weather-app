//
//  SearchVC.swift
//  Weather app
//
//  Created by mücahit öztürk on 18.03.2024.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var navInfos: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
      
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}


extension SearchVC: UISearchBarDelegate {
    
    @IBAction func findCity(_ sender: UIButton) {
        searchBar.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchBar.text {
            WeatherAPI.shared.fetchWeather(cityName: city)
            ForecastAPI.shared.fetchForecastCityName(cityName: city)
        }
    }
}


extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.resueID, for: indexPath) as! SearchCell
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


class SearchCell: UITableViewCell {
    
    static let resueID = "SearchCell"
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var backgroundCoverView: UIView!
    @IBOutlet weak var cityNAme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    private func configure() {
        cityNAme.text = "İstanbul"
        backgroundCoverView.layer.cornerRadius = 16
    }
}
