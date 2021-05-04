//
//  Constants.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

public enum CustomError: Error {
    case noData
    case apiError
    case invalidURL
    case serializationError
    case invalidResponse
    case genericError(message: String)
    case dbSaveError
    case invalidViewController
}

public typealias SuccessHandler = (_ status: Bool, _ data: Data?) -> Void
public typealias FailureHandler = (_ status: Bool, _ error: CustomError) -> Void

public enum Constants {
    private static let apiKey = "fae7190d7e6433ec3a45285ffcf55c86"
    static let UrlCurrentLocation = "http://api.openweathermap.org/data/2.5/weather?appid=" + Constants.apiKey
    static let urlLatLong = "http://api.openweathermap.org/data/2.5/weather?appid=" + Constants.apiKey
    static let UrlHelp = "https://openweathermap.org/faq"
}

public enum Units {
    case imperial, metric
}

//MARK:- TableView, CollectionView constants
public extension Constants {
    static let BookmarkedCityCellIdentifier = "BookmarkedCityCell"
}

//MARK:- View Controller Identifiers
public extension Constants {
    static let CityScreenVCIdentifier = "CityScreenVC"
    static let HelpScreenVCIdentifier = "HelpScreenVC"
    static let AddLocationVCIdentifier = "AddLocationVC"
    static let SettingsVCIdentifier = "SettingsVC"
}

//MARK: - CoreData
public extension Constants {
    static let citiesEntityName = "Cities"
    static let attrCityName = "cityName"
    static let attrLat = "lat"
    static let attrLong = "long"
    static let attrlocality = "locality"
    static let attrSubLocality = "subLocality"
    static let attrAdminArea = "adminArea"
    static let attrIsDefault = "isDefault"
    
    static let entitySettings = "Settings"
    static let attrIsMetric = "isMetric"
}

public extension Constants {
    struct AlertConstants {
        static let titleWarning = "Warning"
        static let btnOk        = "OK"
        static let msgInvalidController = "We can't take you to here now. Please apologize"
        static let titleError   = "Error"
        static let msgInvalidLocation = "Oops., selected location is invalid"
    }
}
