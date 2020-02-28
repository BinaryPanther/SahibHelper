//
//  Design Helper.swift
//  Sahib Helper
//
//  Created by sahib hussain on 05/02/20.
//  Copyright © 2020 sahib hussain. All rights reserved.
//

import UIKit

public class DesignHelper {
    
    public static let shared = DesignHelper()
    public typealias completion = (_ success: Bool) -> Void
    public let color = ColorHelper.shared
    
    private init () {}
    
    
    public func dropShadow(view : UIView, radius : CGFloat) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.16
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = radius
    }
    
    public func setButtonFontAwesome(btn: UIButton, size: CGFloat, style: FontAwesomeStyle, icon: FontAwesome) {
        btn.titleLabel?.font = UIFont.fontAwesome(ofSize: size, style: style)
        btn.setTitle(String.fontAwesomeIcon(name: icon), for: .normal)
    }
    
    public func setFontAwesomeInFrontAttributedButton(_ btn: UIButton, string: String, iconColor: UIColor, textColor: UIColor, size: CGFloat, style: FontAwesomeStyle, icon: FontAwesome) {
        let attr = [NSAttributedString.Key.foregroundColor : textColor]
        
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage.fontAwesomeIcon(name: icon, style: style, textColor: iconColor, size: .init(width: size, height: size))
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        let passAttStr = NSMutableAttributedString(string: "")
        passAttStr.append(image1String)
        passAttStr.append(NSAttributedString(string: " \(string)", attributes: attr))
        btn.setAttributedTitle(passAttStr, for: .normal)
    }
    
    public func createImagefromFontAwesome(size: CGSize, style: FontAwesomeStyle, icon: FontAwesome, color: UIColor) -> UIImage {
        let img = UIImage.fontAwesomeIcon(name: icon, style: style, textColor: color, size: size)
        return img
    }
    
    public func radioButton(_ button: UIButton, checked: Bool, label: String, color: UIColor = .black) {
        let attr = [NSAttributedString.Key.foregroundColor : color]
        
        let image1Attachment = NSTextAttachment()
        if checked {
            image1Attachment.image = UIImage.fontAwesomeIcon(name: .dotCircle, style: .regular, textColor: color, size: .init(width: 50, height: 50))
        }else {
            image1Attachment.image = UIImage.fontAwesomeIcon(name: .circle, style: .regular, textColor: color, size: .init(width: 50, height: 50))
        }
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        let passAttStr = NSMutableAttributedString(string: "")
        passAttStr.append(image1String)
        passAttStr.append(NSAttributedString(string: " \(label)", attributes: attr))
        button.setAttributedTitle(passAttStr, for: .normal)
    }
    
    public func checkboxButton(_ button: UIButton, checked: Bool, label: String) {
        
    }
    
    public func statusView(viewWidth: CGFloat, color: String) -> UIView {
        let statView = UIView()
        
        if UIDevice.current.hasNotch {
            statView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 44)
            statView.backgroundColor = ColorHelper.shared.hexStringToColor(hexStr: color, alpha: 1)
            return statView
        }else {
            statView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 20)
            statView.backgroundColor = ColorHelper.shared.hexStringToColor(hexStr: color, alpha: 1)
            return statView
        }
        
    }
    
    public func toast(message: String, position: ToastPosition, duration: TimeInterval, view: UIView) {
        
        var style = ToastStyle()
        style.messageAlignment = .center
        
        view.makeToast(message, duration: duration, position: position, style: style)
    }
    
    public func completionToast(message: String, position: ToastPosition, duration: TimeInterval, view: UIView, comp: @escaping completion) {
        var style = ToastStyle()
        style.messageAlignment = .center
        
        view.makeToast(message, duration: duration, position: position, title: nil, image: nil, style: style) { (succ) in
            comp(succ)
        }
        
    }
    
    public func openImageViewer(_ viewController: UIViewController, urls: [String], presentationStyle: UIModalPresentationStyle) {
        let vc = ImageViewer(nibName: "ImageViewer", bundle: nil)
        vc.imageUrls = urls
        vc.modalPresentationStyle = presentationStyle
        viewController.present(vc, animated: true, completion: nil)
    }
    
}

public class ColorHelper {
    
    public enum colorCode: String {
        case primary = "D32F2F"
        case buttonBlue = "007AFF"
        case darkView = "252529"
        case lightView = "F5F5F5"
        case darkText = "000000"
        case lightText = "FFFFFF"
    }
    
    public static let shared = ColorHelper()
    private init () {}
    
    public func hexStringToColor(hexStr: String, alpha: CGFloat) -> UIColor{
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    public func hexStringToColor(hexCode: colorCode, alpha: CGFloat) -> UIColor{
        var cString:String = hexCode.rawValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}

extension String {
    
    public static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
}

extension UITextField {
    
    public func leftPadding(_ padding: CGFloat) {
        let vw = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.size.height))
        vw.backgroundColor = .white
        
        self.leftView = vw
        self.leftViewMode = .always
    }
    
    public func rightPadding(_ padding: CGFloat) {
        let vw = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.size.height))
        vw.backgroundColor = .white
        
        self.rightView = vw
        self.rightViewMode = .always
    }
    
}

extension UIImage {
    
    public func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    public func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension Bundle {
    
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var bundleIdentifier: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
    }
    
}

extension UIDevice {
    
    public var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
             return bottom > 0
        } else {
            return false
        }
    }
    
}
