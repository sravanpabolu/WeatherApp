//
//  HelpScreenVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit
import WebKit

class HelpScreenVC: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        guard let url = URL(string: Constants.UrlHelp) else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
