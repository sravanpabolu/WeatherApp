//
//  HomeScreenVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit

class HomeScreenVC: BaseViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Vars
    let homeScreenVM = HomeScreenVM()
    let defaultCities = [
        "Paris",
        "Dubai",
        "London",
        "Delhi",
        "Kolkata",
        "Mumbai",
        "Chennai",
        "Hyderabad",
        "Nellore",
        "Kochi"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //TODO: REMOVE THIS- This is for testing purpose
//        for aCity in self.defaultCities {
//            insertCity(name: aCity)
//        }
        
        let title = "Weather"
        self.navigationItem.title = title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped))
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings.png"), style: .plain, target: self, action: #selector(self.btnSettingsTapped))
        let helpButton = UIBarButtonItem(image: UIImage(named: "help.png"), style: .plain, target: self, action: #selector(self.btnHelpTapped))
        
        self.navigationItem.leftBarButtonItem = addButton
        self.navigationItem.rightBarButtonItems = [helpButton, settingsButton]

        fetchCities()
    }
    
    @objc private func btnAddTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: AddLocationVC = storyboard.instantiateViewController(identifier: Constants.AddLocationVCIdentifier) as AddLocationVC
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func btnSettingsTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: SettingsVC = storyboard.instantiateViewController(identifier: Constants.SettingsVCIdentifier) as SettingsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func btnHelpTapped() {
        print("Help")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: HelpScreenVC = storyboard.instantiateViewController(identifier: Constants.HelpScreenVCIdentifier) as HelpScreenVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func deleteCity(at index: Int) {
        do {
            try homeScreenVM.deleteCity(at: index)
        } catch  {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager delete Error")
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func insertCity(name: String) {
        do {
            try self.homeScreenVM.insertCity(name: name)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Insertion Error")
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func fetchCities() {
        do {
            try homeScreenVM.fetchCities()
        } catch  {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Fetch Error")
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
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
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            deleteCity(at: indexPath.row)
        }
    }
}

extension HomeScreenVC: AddLocationVCDelegate {
    func didSelect(location: String) {
        Logger.printMessage(message: location, request: "Selected location")
        insertCity(name: location)
    }
}
