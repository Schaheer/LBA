//
//  SettingUIDesign.swift
//  AABEngage
//
//  Created by Shakeel Ahmed on 08/10/2021.
//

import UIKit

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

class LabelSetting: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        print(self.text!)
        checkScreenSize()
        self.text = self.text?.localizeString()
        print(self.text!)
    }
    
    func checkScreenSize() {
        var fontSize = self.font.pointSize
//        if IPAD {
//            fontSize *= iPadMultiplier
//        } else if iPhoneMiniIdentifiers.contains(UIDevice.current.screenType) {
//            fontSize *= iPhoneMiniMultiplier
//        } else {
//            fontSize *= iPhoneMultiplier
//        }
        
        self.font = UIFont(name: self.font.fontName, size: fontSize)
    }
}

class CenterLabelSetting: LabelSetting {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textAlignment = .center
    }
}

class ButtonSetting: UIButton {
    
    @IBInspectable var backGroundColor: UIColor = UIColor.clear {
        didSet {
            // self.backGroundColor = backGroundColor
        }
    }
    
    @IBInspectable var setFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            self.titleLabel?.font = setFont
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkScreenSize()
        self.setTitle(self.titleLabel?.text?.localizeString(), for: .normal)
        if #available(iOS 15.0, *) {
            self.configuration = .none
        }
    }
    
    func checkScreenSize() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        if var fontSize = self.titleLabel?.font.pointSize,
           let fontName = self.titleLabel?.font.fontName {
            
//            if IPAD {
//                fontSize *= iPadMultiplier
//            } else if iPhoneMiniIdentifiers.contains(UIDevice.current.screenType) {
//                fontSize *= iPhoneMiniMultiplier
//            } else {
//                fontSize *= iPhoneMultiplier
//            }
            DispatchQueue.main.async {
                self.titleLabel?.font = UIFont(name: fontName, size: 16)
            }
        }
    }
}

class TextFieldSetting: UITextField {
    // Genereic Validation
    var validationLength = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkScreenSize()
        self.text = self.text?.localizeString()
        self.placeholder = self.placeholder?.localizeString()
        
        // auto apply validation on each textfield of this class
        applyLengthValidation(to: 40)
    }
    
    func checkScreenSize() {
        if var fontSize = self.font?.pointSize,
           let fontName = self.font?.fontName {
            
//            if IPAD {
//                fontSize *= iPadMultiplier
//            } else if iPhoneMiniIdentifiers.contains(UIDevice.current.screenType) {
//                fontSize *= iPhoneMiniMultiplier
//            } else {
//                fontSize *= iPhoneMultiplier
//            }
            
            self.font = UIFont(name: fontName, size: fontSize)
        }
    }
    
    // can call extenally if there is an extenal target added
    @objc
    public func validateLength() {
        guard var text = self.text else {
            return
        }
        
        if text.count > validationLength {
            text = String(text[..<text.index(text.startIndex, offsetBy: validationLength)])
            self.text = text
        }
    }
    
    // can call externally to set a custon validation length
    public func applyLengthValidation(to count: Int) {
        self.validationLength = count
        self.addTarget(self, action: #selector(validateLength), for: .editingChanged)
    }
    
    
    
    // not working somehow
    func emptyValidation() -> Bool {
        (self.superview as? ViewSettingCornorRadius)?.setErrorBorder()
        
        if let text = text, text.isEmpty {
            (self.superview as? ViewSettingCornorRadius)?.setErrorBorder()
            return false
        }
        
        return true
    }
    
    @objc private func validateNumberOnly(_ textField: TextFieldSetting) {
        textField.validateLength()
        
        if var text = textField.text, let last = text.last {
            if !last.isNumber {
                text.removeLast()
                textField.text = text
            }
        }
    }
}

class TextFieldSettingCenter: TextFieldSetting {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textAlignment = .center
    }
}



class ViewSettingCornorRadius: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if haveTextField() {
            setHeight(to: 60, when: 45)
        }
    }
    
    private func haveTextField() -> Bool {
        for v in subviews {
            if v is TextFieldSetting {
                return true
            }
        }
        return false
    }
    
    private func setHeight(to: CGFloat, when: CGFloat) {
        for c in constraints {
            if c.firstAttribute == .height || c.secondAttribute == .height{
                if c.constant == when {
                    c.constant = to
                    print("set to 60")
                }
            }
        }
    }
    
    private func haveHeightOf(_ height: CGFloat) -> Bool {
        for c in constraints {
            if (c.firstAttribute == .height || c.secondAttribute == .height) {
                print("{}{}{}{} \(c.firstItem as Any), \(c.secondItem as Any), \(c.constant)")
                return true
            }
        }
        return false
    }
    
    override func layoutSubviews() {
        setCornorRadius()
        setNormalBorder()
    }
    
    func setCornorRadius() {
//        self.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 4)
//        self.clipsToBounds = true
        
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    func setNormalBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
    }
    
    func setErrorBorder() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2.0
    }
}

class DashBorderedView: ViewSettingCornorRadius {
    private lazy var border: CAShapeLayer = {
        let border = CAShapeLayer()
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [4, 4]
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(rect: self.bounds).cgPath
        return border
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addSublayer(border)
    }
    
    override func setNormalBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func setErrorBorder() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2.0
    }
}



//class CustomPageControl: UIPageControl {
//    
//    @IBInspectable var currentPageImage: UIImage?
//
//    @IBInspectable var otherPagesImage: UIImage?
//
//    override var numberOfPages: Int {
//        didSet {
//            updateDots()
//        }
//    }
//
//    override var currentPage: Int {
//        didSet {
//            updateDots()
//        }
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        if #available(iOS 14.0, *) {
//            defaultConfigurationForiOS14AndAbove()
//        } else {
//            pageIndicatorTintColor = .clear
//            currentPageIndicatorTintColor = .clear
//            clipsToBounds = false
//        }
//        
//        self.currentPageImage = UIImage(named: "fillRectangle")
//        self.otherPagesImage = UIImage(named: "unfillRectangle")
//        self.tintColor = .clrWalkThroughDefault
//        self.currentPageIndicatorTintColor = . clrWalkThroughSelected
//
//        self.backgroundColor = .red
//        print(self)
//    }
//
//    private func defaultConfigurationForiOS14AndAbove() {
//        if #available(iOS 14.0, *) {
//            for index in 0..<numberOfPages {
//                let image = index == currentPage ? currentPageImage : otherPagesImage
//                setIndicatorImage(image, forPage: index)
//            }
//
//            // give the same color as "otherPagesImage" color.
//            //pageIndicatorTintColor = .gray
//            
//            // give the same color as "currentPageImage" color.
//           // currentPageIndicatorTintColor = .red
//            /*
//             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
//            */
//        }
//    }
//
//    private func updateDots() {
//        if #available(iOS 14.0, *) {
//            defaultConfigurationForiOS14AndAbove()
//        } else {
//            for (index, subview) in subviews.enumerated() {
//                let imageView: UIImageView
//                if let existingImageview = getImageView(forSubview: subview) {
//                    imageView = existingImageview
//                } else {
//                    imageView = UIImageView(image: otherPagesImage)
//                    imageView.frame.size.height = 10
//                    imageView.frame.size.width = 10
//                    imageView.contentMode = .scaleAspectFit
//                    
//                    imageView.center = subview.center
//                    subview.addSubview(imageView)
////                    subview.frame.size.height = 10
////                    subview.frame.size.width = 10
//
//                    subview.clipsToBounds = false
//                }
//                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
//            }
//        }
//    }
//
//    private func getImageView(forSubview view: UIView) -> UIImageView? {
//        if let imageView = view as? UIImageView {
//            return imageView
//        } else {
//            let view = view.subviews.first { (view) -> Bool in
//                return view is UIImageView
//            } as? UIImageView
//
//            return view
//        }
//    }
//    }




class LocalizedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.image = image?.imageFlippedForRightToLeftLayoutDirection()
    }
}
