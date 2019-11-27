//
//  DetailViewController.swift
//  Project16
//
//  Created by Alexander Tu on 27.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var cityName: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let cityName = cityName else { return }
        let url = URL(string: "https://en.wikipedia.org/wiki/" + cityName)!
        webView.load(URLRequest(url: url))
    }
}
