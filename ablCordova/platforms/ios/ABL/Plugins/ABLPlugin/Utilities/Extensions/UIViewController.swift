//
//  UIViewController.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/03/2022.
//

import UIKit

extension UIViewController {
    func presentInFullScreen(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func add(_ child: UIViewController, to view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    
    /**
     Initialize a nib.
     
     
     - returns: UIViewController.
     */
    public class func fromNib<T>() -> T? where T : UIViewController {
        return fromNib(nibName: nil)
    }
    
    /**
     Initialize a nib.
     
     - parameter nibName: Nib name.
     
     - returns: UIViewController.
     */
    public class func fromNib<T>(nibName: String?) -> T? where T : UIViewController {
        
        let name = nibName ?? String(describing: self)
        return self.init(nibName: name, bundle: Bundle.main) as? T
    }
    
    open func presentPOPUP(_ viewControllerToPresent: UIViewController, animated flag: Bool, modalTransitionStyle:UIModalTransitionStyle = .coverVertical, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            viewControllerToPresent.modalPresentationStyle = .overCurrentContext
            viewControllerToPresent.modalTransitionStyle = modalTransitionStyle
            
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
        
    }
    
    func showSelectionAlert(with datasource: [String], title: String? = "", block: @escaping ((Int, String) -> ()) = { _, _ in }) {
        if let alert: SelectionPopupVC = SelectionPopupVC.fromNib() {
            alert.setAlertWith(datasource: datasource, title: title, block: block)
            
            presentPOPUP(alert, animated: true)
        }
    }
    
    func showWebView(with type: ABLWebVC.ViewType, url: String? = nil, htmlString: String? = nil, completionBlock: (() -> ())? = {}) {
        let vc = UIStoryboard.init(name: "OpenAccount", bundle: nil).instantiateViewController(withIdentifier: "ABLWebVC") as! ABLWebVC
        vc.url = url
        vc.htmlString = htmlString
        vc.viewType = type
        vc.completionBlock = completionBlock
        
        present(vc, animated: true)
    }
    
}
