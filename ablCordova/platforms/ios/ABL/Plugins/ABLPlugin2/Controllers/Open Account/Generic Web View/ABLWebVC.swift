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
    
    @IBOutlet weak var bottomButton: ButtonSetting!
    
    var url: String?
    var htmlString: String?
    
    var viewType: ViewType?
    
    var completionBlock: (() -> ())?
    
    enum ViewType: String {
        case termsNConditions = "Terms & Conditions"
        case declaration = "Declaration"
        case keyFactStatement = "KFS"
        case POIDetails = "Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = viewType?.rawValue
        bottomButton.setTitle("Agree", for: .normal)
        
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
        case .POIDetails:
            if let htmlString = htmlString {
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
            bottomButton.setTitle("Okay", for: .normal)
        case .none:
            break
        }
    }
    
    @IBAction func agreeTapped(_ sender: Any) {
        completionBlock?()
        
        dismiss(animated: true)
    }
    
}
