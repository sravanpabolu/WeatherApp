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
        
        do {
            try homeScreenVM.insertCity(name: "Paris")
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Error")
        }
        
        do {
            try homeScreenVM.fetchCities()
        } catch  {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Fetch  Error")
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let self = self else { return }
            
            Logger.printMessage(message: "\(self.homeScreenVM.cities)", request: "Avaialble cities")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
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
