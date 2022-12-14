//
//  ABLWebVC.swift
//  ABL
//
//  Created by Schaheer Saleem on 13/12/2022.
//

import UIKit
import WebKit

class ABLWebVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    var htmlString: String?
    
    var viewType: ViewType?
    
    var agreeBlock: (() -> ())?
    
    enum ViewType: String {
        case termsNConditions = "Terms & Conditions"
        case declaration = "Declaration"
        case keyFactStatement = "KFS"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = viewType?.rawValue
        
        switch viewType {
        case .termsNConditions, .keyFactStatement:
            if let url = url {
                let url = URL(string: url)!
                webView.load(URLRequest(url: url))
            }
        case .declaration:
            if let htmlString = htmlString {
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
        case .none:
            break
        }
    }
    
    @IBAction func agreeTapped(_ sender: Any) {
        agreeBlock?()
        
        dismiss(animated: true)
    }
    
}
