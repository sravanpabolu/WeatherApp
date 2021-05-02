//
//  SettingsVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 02/05/21.
//

import UIKit

class SettingsVC: BaseViewController {
    
    @IBOutlet weak var segmentUnits: UISegmentedControl!
    
    let settingsVM = SettingsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try settingsVM.getCurrentSettings()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.segmentUnits.selectedSegmentIndex = (AppSettings.shared.isMetric == .metric) ? 0 : 1
            }
        } catch {
            self.showAlert(title: "Fetch Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func unitsChanged(_ sender: Any) {
        let isMetricSetting = (segmentUnits.selectedSegmentIndex == 0) ? true : false
        print(isMetricSetting)
        
        do {
            try settingsVM.updateSetting(isMetric: isMetricSetting)
        } catch {
            self.showAlert(title: "Update Error", message: error.localizedDescription)
        }
    }
    
}
