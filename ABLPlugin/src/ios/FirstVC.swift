//
//  FirstVC.swift
//  TestCordovaApp
//
//  Created by Muhammad Shayan Zahid on 28/02/2022.
//

import UIKit

final class FirstVC: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = "Hello Shayan"
    }
}
