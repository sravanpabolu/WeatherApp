//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit

class BaseViewController: UIViewController {
    func showAlert(title: String = "Weather", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        //        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        //        })
        //        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
