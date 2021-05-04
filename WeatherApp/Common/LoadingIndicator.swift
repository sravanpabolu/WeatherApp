//
//  LoadingIndicator.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 04/05/21.
//

import UIKit

class LoadingIndicator: UIView {
    static let shared = LoadingIndicator()
    
    private lazy var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showLoader(on view: UIView) {
        view.addSubview(self)
        self.addSubview(loader)
        
        Logger.printMessage(message: "SHOW")
        
        self.loader.centerXAnchor(equalTo: view.centerXAnchor)
        self.loader.centerYAnchor(equalTo: view.centerYAnchor)
        self.loader.heightAnchor(equalTo: 64)
        self.loader.widthAnchor(equalTo: 64)
    }
    
    func dismissLoader() {
        Logger.printMessage(message: "Hide")
        
        loader.stopAnimating()
        loader.removeFromSuperview()
        self.removeFromSuperview()
    }
    
}
