//
//  HomeScreenVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit

class HomeScreenVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Vars
    let homeScreenVM = HomeScreenVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertCity()
        fetchCities()
//        deleteCity()
    
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let self = self else { return }
        
            Logger.printMessage(message: "\(self.homeScreenVM.cities)", request: "Avaialble cities")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func deleteCity() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let self = self else { return }
            
            do {
                try self.homeScreenVM.deleteCity(name: "Dubai")
            } catch  {
                Logger.printMessage(message: error.localizedDescription, request: "DBManager Fetch  Error")
            }
        }
    }
    
    private func insertCity() {
        do {
            try homeScreenVM.insertCity(name: "Paris")
            try homeScreenVM.insertCity(name: "Dubai")
            try homeScreenVM.insertCity(name: "London")
            try homeScreenVM.insertCity(name: "Delhi")
            try homeScreenVM.insertCity(name: "Kolkota")
            try homeScreenVM.insertCity(name: "Mumbai")
            try homeScreenVM.insertCity(name: "Chennai")
            try homeScreenVM.insertCity(name: "Hyderabad")
            try homeScreenVM.insertCity(name: "Nellore")
            try homeScreenVM.insertCity(name: "Kochi")
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Error")
        }
    }
    
    private func fetchCities() {
        do {
            try homeScreenVM.fetchCities()
        } catch  {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Fetch  Error")
        }
    }
    
    
}

extension HomeScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeScreenVM.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeViewCellIdentifier) else { return UITableViewCell() }
        
        cell.textLabel?.text = homeScreenVM.cities[indexPath.row]
        
        return cell
    }
}

extension HomeScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: CityScreenVC = storyboard.instantiateViewController(identifier: Constants.CityScreenVCIdentifier) as CityScreenVC
        vc.cityName = homeScreenVM.cities[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
