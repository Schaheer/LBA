//
//  SimVerificationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 16/03/2022.
//

import UIKit

final class SimVerificationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        openSimVerificationVC()
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    private func openSimVerificationVC() {
        guard let resumeApplicationVC = UIStoryboard.initialize(
            viewController: .resumeApplicationVC,
            fromStoryboard: .cnicUpload
        ) as? ResumeApplicationVC else { return }
        
        navigationController?.pushViewController(resumeApplicationVC, animated: true)
    }
}
