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
    var showRecording: Bool = false
    
    override func viewDidLoad() {
        if(showRecording) {
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.allowsInlineMediaPlayback = true
            webConfiguration.mediaTypesRequiringUserActionForPlayback = []
            
            guard let path = Bundle.main.path(forResource: "how_to_use", ofType:"mov") else {
                Logger.printMessage(message: "Can't load video", request: "Invalid Video")
                return
            }
            
            let videoURL:URL = URL(fileURLWithPath: path)
            let request:URLRequest = URLRequest(url: videoURL)
            self.webView.load(request)
        } else {
            guard let url = URL(string: Constants.UrlHelp) else { return }
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    func load(url: String) {
        let html = "<video playsinline controls width=\"100%\" src=\"\(url)\"> </video>"
        self.webView.loadHTMLString(html, baseURL: nil)
    }
}
