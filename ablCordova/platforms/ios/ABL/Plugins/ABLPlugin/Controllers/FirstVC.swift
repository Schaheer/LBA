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
        
        textLabel.text = "Hello Cordova"
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
//        guard let secondVC = UIStoryboard.initialize(viewController: .secondVC) as? SecondVC else { return }
//        navigationController?.pushViewController(secondVC, animated: true)
        
        guard let secondVC = UIStoryboard.initialize(viewController: .OpenAccountTwoViewController) as? OpenAccountTwoViewController else { return }
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
