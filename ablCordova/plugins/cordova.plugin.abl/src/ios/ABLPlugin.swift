import Foundation

@objc(ABLPlugin)
public class ABLPlugin: CDVPlugin {
    
    var command: CDVInvokedUrlCommand?
    
    @objc(startFlow:) func startFlow(_ command: CDVInvokedUrlCommand) {
        
//        let first = command.argument(at: 0) as? String ?? "First Command"
        self.command = command
        
        print("Hello Cordova")
        
        instantiateVC()
    }
    
    private func instantiateVC() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "FirstVC") as? FirstVC else { return }
        let navigationController = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navigationController
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}