//
//  ActivityIndicatorView.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 09/03/2022.
//

import UIKit
import NVActivityIndicatorView

final class ActivityIndicatorView {
    
    private let superWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    private let overlayView = UIView()
    private var activityIndicator: NVActivityIndicatorView?
    
    static let shared: ActivityIndicatorView = {
        return ActivityIndicatorView()
    }()
    
    private init() {
        
        if let window = superWindow {
            overlayView.frame = window.frame
            overlayView.backgroundColor = .white
            overlayView.alpha = 0.7
            
            let activityFrame = CGRect(
                x: overlayView.center.x - 30,
                y: overlayView.center.y - 30,
                width: 60,
                height: 60
            )
            
            activityIndicator = NVActivityIndicatorView(frame: activityFrame, type: .ballRotateChase, color: .black)
            guard let activityIndicator = activityIndicator else { return }
            
            overlayView.addSubview(activityIndicator)
        }
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.superWindow?.addSubview(self.overlayView)
            self.activityIndicator?.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.overlayView.removeFromSuperview()
            self.activityIndicator?.stopAnimating()
        }
    }
}
