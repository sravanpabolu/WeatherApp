//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 04/05/21.
//

import UIKit

extension UIViewController {
    static func instance<T: UIViewController>() throws -> T {
        let identifier = String(describing: self)
        
        guard let controller = UIStoryboard().main.instantiateViewController(withIdentifier: identifier) as? T else {
            throw CustomError.invalidViewController
        }
        
        return controller
    }
}
