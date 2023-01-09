import Foundation
import UIKit

@objc(ABLPlugin)
public class ABLPlugin: CDVPlugin {
    
    var command: CDVInvokedUrlCommand?
    
    @objc(startFlow:) func startFlow(_ command: CDVInvokedUrlCommand) {
        self.command = command
        instantiateCNICUploadFlow()
//        openReviewDetails()
    }
    
    
    private func instantiateCNICUploadFlow() {

        guard let vc = UIStoryboard.initialize(
            viewController: .welcomeVC,
            fromStoryboard: .cnicUpload
        ) as? WelcomeVC else { return }
//
        
//        guard let vc = UIStoryboard.initialize(
//            viewController: .reviewDetailsVC,
//            fromStoryboard: .openAccount
//        ) as? ReviewDetailsVC else { return }

        
//        guard let vc = UIStoryboard.initialize(
//            viewController: .selectPreferredAccountVC,
//            fromStoryboard: .openAccount
//        ) as? SelectPreferredAccountVC else { return }

//        guard let vc = UIStoryboard.initialize(
//            viewController: .selectBankingMethodVC,
//            fromStoryboard: .openAccount
//        ) as? SelectBankingMethodVC else { return }
//
//        guard let vc = UIStoryboard.initialize(
//            viewController: .personalInformationBaseVC,
//            fromStoryboard: .openAccount
//        ) as? PersonalInformationBaseVC else { return }
        
        let navigationController = UINavigationController(rootViewController: vc)
        viewController.presentInFullScreen(navigationController, animated: true)
    }
    
    private func openReviewDetails() {
        guard let vc = UIStoryboard.initialize(
            viewController: .reviewDetailsVC,
            fromStoryboard: .openAccount
        ) as? ReviewDetailsVC else { return }
        
        viewController.presentInFullScreen(vc, animated: true)
    }
}
