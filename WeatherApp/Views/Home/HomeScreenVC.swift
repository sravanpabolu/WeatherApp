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
        let howToUseButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(btnPlayTapped))
        
        self.navigationItem.leftBarButtonItem = addButton
        self.navigationItem.rightBarButtonItems = [howToUseButton, helpButton, settingsButton]

        fetchCities()
    }
    
    @objc private func btnAddTapped() {
        do {
            let vc: AddLocationVC = try AddLocationVC.instance()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "Invalid Controller")
            self.showAlert(title: Constants.AlertConstants.titleWarning, message: Constants.AlertConstants.msgInvalidController)
        }
    }
    
    @objc private func btnSettingsTapped() {
        do {
            let vc = try SettingsVC.instance()
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "Invalid Controller")
            self.showAlert(title: Constants.AlertConstants.titleWarning, message: Constants.AlertConstants.msgInvalidController)
        }
    }
    
    @objc private func btnHelpTapped() {
        do {
            let vc: HelpScreenVC = try HelpScreenVC.instance()
            vc.showRecording = false
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "Invalid Controller")
            self.showAlert(title: Constants.AlertConstants.titleWarning, message: Constants.AlertConstants.msgInvalidController)
        }
    }
    
    @objc private func btnPlayTapped() {
        do {
            let vc: HelpScreenVC = try HelpScreenVC.instance()
            vc.showRecording = true
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "Invalid Controller")
            self.showAlert(title: Constants.AlertConstants.titleWarning, message: Constants.AlertConstants.msgInvalidController)
        }
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
    
    private func insertCity(location: BookmarkedLocation) {
        do {
            try self.homeScreenVM.insertCity(location: location)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Insertion Error")
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func fetchCities() {
        LoadingIndicator.shared.showLoader(on: self.view)
        do {
            try homeScreenVM.fetchCities()
        } catch  {
            Logger.printMessage(message: error.localizedDescription, request: "DBManager Fetch Error")
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            LoadingIndicator.shared.dismissLoader()
            self.tableView.reloadData()
        }
    }
}

extension HomeScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeScreenVM.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BookmarkedCityCell = tableView.dequeueReusableCell(withIdentifier: Constants.BookmarkedCityCellIdentifier) as? BookmarkedCityCell else { return UITableViewCell() }
        
        cell.title.text = homeScreenVM.cities[indexPath.row].name
        cell.subTitle.text = homeScreenVM.cities[indexPath.row].locality
        
        return cell
    }
}

extension HomeScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: CityScreenVC = storyboard.instantiateViewController(identifier: Constants.CityScreenVCIdentifier) as CityScreenVC
        
        let someLocation = homeScreenVM.cities[indexPath.row]
        vc.location = someLocation
        navigationController?.pushViewController(vc, animated: true)
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            deleteCity(at: indexPath.row)
        }
    }
}

extension HomeScreenVC: AddLocationVCDelegate {
    func didSelect(location: BookmarkedLocation) {
        Logger.printMessage(message: location, request: "Selected location")
        guard let name = location.name,
              let locality = location.locality,
              !name.isEmpty,
              !locality.isEmpty else {
            self.showAlert(title: Constants.AlertConstants.titleError,
                           message: Constants.AlertConstants.msgInvalidLocation)
            return
        }
        insertCity(location: location)
    }
}
