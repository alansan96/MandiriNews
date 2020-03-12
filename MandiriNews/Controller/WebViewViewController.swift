//
//  WebViewViewController.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        url.insert("s", at: url.index(url.startIndex, offsetBy: 4))
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
    }
    


}
