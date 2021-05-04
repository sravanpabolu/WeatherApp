//
//  BookmarkedLocation.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import Foundation
import CoreLocation

struct BookmarkedLocation {
    var name, locality, subLocality,adminArea: String?
    var lat, long: CLLocationDegrees?
}
