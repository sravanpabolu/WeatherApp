//
//  SettingsVM.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 02/05/21.
//

import Foundation
import CoreData

class SettingsVM {
    
    func updateSetting(isMetric: Bool) throws {
        do {
            AppSettings.shared.isMetric = isMetric ? .metric : .imperial
            try DBManager.shared.updateUnitSettings(isMetric: AppSettings.shared.isMetric)
        } catch {
            throw error
        }
    }
    
    func getCurrentSettings() throws {
        do {
            let settingsObjects: [NSManagedObject] = try DBManager.shared.getSettings()
            for anObject in settingsObjects {
                if let isMetricUnit = anObject.value(forKey: Constants.attrIsMetric) as? Bool {
                    AppSettings.shared.isMetric = isMetricUnit ? .metric : .imperial
                }
            }
        } catch {
            throw error
        }
    }
}
