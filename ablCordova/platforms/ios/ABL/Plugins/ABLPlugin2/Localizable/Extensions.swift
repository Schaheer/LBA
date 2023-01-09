//
//  Extensions.swift
//  AABEngage
//
//  Created by Apple on 10/30/2021.
//

import Foundation

import UIKit
import Kingfisher

extension UISegmentedControl {
    func textColor(selectedColor: UIColor, normalColor: UIColor) {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:selectedColor], for: .selected)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:normalColor], for: .normal)
        //        self.layer.borderWidth = 1
        //        self.layer.borderColor = UIColor.clrSegmentSelectedText.cgColor
    }
}
extension Dictionary {
    func convertParametersToJsonObject() -> Any {
        let attachmentParameterJson = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let jsonObject = try? JSONSerialization.jsonObject(with: attachmentParameterJson!, options: [])
        
        return jsonObject!
    }
}


final class TableViewContentSized: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
final class CollectionViewContentSized: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
extension UITableViewCell {
    static func nibName() -> String {
        return String(describing: self.self)
    }
    
    static func register(tableView: UITableView)  {
        let nibName = String(describing: self.self)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension UICollectionViewCell {
    static func nibName() -> String {
        return String(describing: self.self)
    }
    
    static func register(collectionView: UICollectionView)  {
        let nibName = String(describing: self.self)
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}



//
//extension UITextField {
//    func textFieldSetting() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.clrStatusBar.cgColor
//        self.layer.cornerRadius = self.frame.height / 2
//        self.clipsToBounds = true
//    }
//}
//
//extension UITextView {
//    func textViewSetting() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.clrStatusBar.cgColor
//        self.layer.cornerRadius = 6
//        self.clipsToBounds = true
//    }
//}
//
//extension UIButton {
//    func buttonSetting() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.clrStatusBar.cgColor
//        self.layer.cornerRadius = self.frame.height / 2
//        self.clipsToBounds = true
//        self.backgroundColor = .clrDarkBlue
//        self.setTitleColor(.white, for: .normal)
//    }
//}
//
extension UIView {
    //MARK:- Corner Radius of only two side of UIViews
    func roundCorners(corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func circle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    //    func showLoader(viewController: UIViewController) {
    //        let child = HZProgressHud()
    //        viewController.addChild(child)
    //        child.view.frame = viewController.view.frame
    //        child.view.frame.origin.y = 0
    //        viewController.view.addSubview(child.view)
    //        child.didMove(toParent: viewController)
    //    }
    //
    //    /* Remove Loader */
    //    func removeLoader(viewController: UIViewController) {
    //        let child = viewController.children.last
    //        child?.willMove(toParent: nil)
    //        child?.view.removeFromSuperview()
    //        child?.removeFromParent()
    //    }
}


extension Data {
    func toBase64String() -> (String, String) {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        // let imageData:Data = self.pngData()! as Data
        //        let mimeType = UIImage.fileMimeType(for: imageData)
        
        let strBase64 = self.base64EncodedString(options: .lineLength64Characters)
        return (strBase64, "mimeType")
    }
    
    func toBase64StringWithMimeType() -> (String, String) {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        let mimeType = UIImage.fileMimeType(for: self)
        let strBase64 = self.base64EncodedString(options: .lineLength64Characters)
        return (strBase64, mimeType)
    }
}
extension UIImage {
    
    func toBase64String() -> (String, String) {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        let imageData:Data = self.pngData()! as Data
        let mimeType = UIImage.fileMimeType(for: imageData)
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return (strBase64, mimeType)
    }
    static func fileMimeType(for data: Data) -> String {
        
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    
    func resizeByByte(maxByte: Int) -> Data {
        
        var compressQuality: CGFloat = 1

        var imageData = Data()
        var imageByte = self.jpegData(compressionQuality: 1)?.count

        while imageByte! > maxByte {
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageByte = self.jpegData(compressionQuality: compressQuality)?.count
            compressQuality -= 0.1
        }

        if maxByte > imageByte! {
            return imageData
        } else {
            return self.jpegData(compressionQuality: 1)!
        }
    }
    
    
    //
    //    public class func gif(data: Data) -> UIImage? {
    //        // Create source from data
    //        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
    //            print("SwiftGif: Source for the image does not exist")
    //            return nil
    //        }
    //
    //        return UIImage.animatedImageWithSource(source)
    //    }
    //
    //    public class func gif(url: String) -> UIImage? {
    //        // Validate URL
    //        guard let bundleURL = URL(string: url) else {
    //            print("SwiftGif: This image named \"\(url)\" does not exist")
    //            return nil
    //        }
    //
    //        // Validate data
    //        guard let imageData = try? Data(contentsOf: bundleURL) else {
    //            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
    //            return nil
    //        }
    //
    //        return gif(data: imageData)
    //    }
    //
    //    public class func gif(name: String) -> UIImage? {
    //        // Check for existance of gif
    //        guard let bundleURL = Bundle.main
    //          .url(forResource: name, withExtension: "gif") else {
    //            print("SwiftGif: This image named \"\(name)\" does not exist")
    //            return nil
    //        }
    //
    //        // Validate data
    //        guard let imageData = try? Data(contentsOf: bundleURL) else {
    //            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
    //            return nil
    //        }
    //
    //        return gif(data: imageData)
    //    }
    //
    //    @available(iOS 9.0, *)
    //    public class func gif(asset: String) -> UIImage? {
    //        // Create source from assets catalog
    //        guard let dataAsset = NSDataAsset(name: asset) else {
    //            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
    //            return nil
    //        }
    //
    //        return gif(data: dataAsset.data)
    //    }
    //
    //    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
    //        var delay = 0.1
    //
    //        // Get dictionaries
    //        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
    //        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
    //        defer {
    //            gifPropertiesPointer.deallocate()
    //        }
    //        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
    //        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
    //            return delay
    //        }
    //
    //        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
    //
    //        // Get delay time
    //        var delayObject: AnyObject = unsafeBitCast(
    //            CFDictionaryGetValue(gifProperties,
    //                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
    //            to: AnyObject.self)
    //        if delayObject.doubleValue == 0 {
    //            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
    //                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
    //        }
    //
    //        if let delayObject = delayObject as? Double, delayObject > 0 {
    //            delay = delayObject
    //        } else {
    //            delay = 0.1 // Make sure they're not too fast
    //        }
    //
    //        return delay
    //    }
    //
    //    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
    //        var lhs = lhs
    //        var rhs = rhs
    //        // Check if one of them is nil
    //        if rhs == nil || lhs == nil {
    //            if rhs != nil {
    //                return rhs!
    //            } else if lhs != nil {
    //                return lhs!
    //            } else {
    //                return 0
    //            }
    //        }
    //
    //        // Swap for modulo
    //        if lhs! < rhs! {
    //            let ctp = lhs
    //            lhs = rhs
    //            rhs = ctp
    //        }
    //
    //        // Get greatest common divisor
    //        var rest: Int
    //        while true {
    //            rest = lhs! % rhs!
    //
    //            if rest == 0 {
    //                return rhs! // Found it
    //            } else {
    //                lhs = rhs
    //                rhs = rest
    //            }
    //        }
    //    }
    //
    //    internal class func gcdForArray(_ array: [Int]) -> Int {
    //        if array.isEmpty {
    //            return 1
    //        }
    //
    //        var gcd = array[0]
    //
    //        for val in array {
    //            gcd = UIImage.gcdForPair(val, gcd)
    //        }
    //
    //        return gcd
    //    }
    //
    //    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
    //        let count = CGImageSourceGetCount(source)
    //        var images = [CGImage]()
    //        var delays = [Int]()
    //
    //        // Fill arrays
    //        for index in 0..<count {
    //            // Add image
    //            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
    //                images.append(image)
    //            }
    //
    //            // At it's delay in cs
    //            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
    //                source: source)
    //            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
    //        }
    //
    //        // Calculate full duration
    //        let duration: Int = {
    //            var sum = 0
    //
    //            for val: Int in delays {
    //                sum += val
    //            }
    //
    //            return sum
    //            }()
    //
    //        // Get frames
    //        let gcd = gcdForArray(delays)
    //        var frames = [UIImage]()
    //
    //        var frame: UIImage
    //        var frameCount: Int
    //        for index in 0..<count {
    //            frame = UIImage(cgImage: images[Int(index)])
    //            frameCount = Int(delays[Int(index)] / gcd)
    //
    //            for _ in 0..<frameCount {
    //                frames.append(frame)
    //            }
    //        }
    //
    //        // Heyhey
    //        let animation = UIImage.animatedImage(with: frames,
    //            duration: Double(duration) / 1000.0)
    //
    //        return animation
    //    }
    //
}

extension UITextFieldDelegate {
    func doneButtonTapped() {
        
    }
}




extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus Simulators"
        case iPhones_X_XS_12MiniSimulator = "iPhone X or iPhone XS or iPhone 12 Mini Simulator"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case iPhone_12Mini = "iPhone 12 Mini"
        case iPhone_12_12Pro = "iPhone 12 or iPhone 12 Pro"
        case iPhone_12ProMax = "iPhone 12 Pro Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhones_5_5s_5c_SE
        case 1334: return .iPhones_6_6s_7_8
        case 1792: return .iPhone_XR_11
        case 1920: return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2208: return .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators
        case 2340: return .iPhone_12Mini
        case 2426: return .iPhone_11Pro
        case 2436: return .iPhones_X_XS_12MiniSimulator
        case 2532: return .iPhone_12_12Pro
        case 2688: return .iPhone_XSMax_ProMax
        case 2778: return .iPhone_12ProMax
        default: return .unknown
        }
    }
}


extension UIDatePicker {
    func setMinimumDate(_ date: Date) {
        self.minimumDate = date
    }
    
    func setMaximumDate(_ date: Date) {
        self.maximumDate = date
    }
    
    func setDateSelectionRange(from fromDate: Date, to toDate: Date) {
        setMinimumDate(fromDate)
        setMaximumDate(toDate)
    }
    
    func futureDatesOnly() {
        minimumDate = Date()
    }
    
    func fromToday() {
        minimumDate = Date()
    }
}





private let iPhoneMiniMultiplier = 1.0
private let iPhoneMultiplier = 1.3
private let iPadMultiplier = 1.6

private let iPhoneMiniIdentifiers : [
    UIDevice.ScreenType
] = [
    .iPhones_5_5s_5c_SE,
    .iPhones_6_6s_7_8,
    .iPhone_12Mini,
]

let IPAD = UIScreen.main.traitCollection.userInterfaceIdiom == .pad

extension CGFloat {
    var adjustedFontSize: CGFloat {
        var fontSize = self
        if IPAD {
            fontSize *= iPadMultiplier
        } else if iPhoneMiniIdentifiers.contains(UIDevice.current.screenType) {
            fontSize *= iPhoneMiniMultiplier
        } else {
            fontSize *= iPhoneMultiplier
        }
        
        return fontSize
    }
}

extension UIImageView {
    func setImage(urlString: String, placeholder: String? = nil, completionHandler:((Int) -> Void)? = nil) {
        //        let url2 = "\(urlString)".validURL()
        var string = urlString.lowercased().replacingOccurrences(of: "http", with: "https")
        string = string.replacingOccurrences(of: "httpss", with: "https")
        if let url = URL(string: string) {
            print("valid url")
            print(url)
            var tempPlaceHolder = placeholder
            if placeholder == nil {
                tempPlaceHolder = "placeholder"
            }
            self.kf.setImage(with: url, placeholder: UIImage(named: tempPlaceHolder!), options: nil, progressBlock: nil, completionHandler: { result in
                switch result {
                case .success(let response):
                    print("Image: \(response.image). Got from: \(response.cacheType)")
                    DispatchQueue.main.async {
                        self.image = response.image
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if placeholder != nil {
                        self.image = UIImage(named: placeholder!)
                    }
                }
            })
        } else {
            print("invalid url")
            if placeholder != nil {
                self.image = UIImage(named: placeholder!)
            }
        }
    }
}
