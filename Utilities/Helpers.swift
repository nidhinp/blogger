//
//  Helpers.swift
//  Consumer
//
//  Created by Q8coders on 5/15/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit
import SVProgressHUD
import RNLoadingButton_Swift
import BRYXBanner

class Helpers: NSObject {
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func singleLineTextField(textfield: UITextField, color: UIColor) -> Void {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width:  textfield.frame.size.width, height: textfield.frame.size.height)
        
        border.borderWidth = width
        
        if textfield.layer.sublayers?.count == 1 {
            textfield.layer.addSublayer(border)
        }
        
        textfield.layer.masksToBounds = true
    }
    
    static func fullScreenLineTextField(textfield: UITextField, color: UIColor) -> Void {
        let screenRect:CGRect = UIScreen.main.bounds;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width:  screenRect.size.width, height: textfield.frame.size.height)
        
        border.borderWidth = width
        
        if textfield.layer.sublayers?.count == 1 {
            textfield.layer.addSublayer(border)
        }
        
        textfield.layer.masksToBounds = true
    }
    
    static func imageResize(image: UIImage) -> UIImage {
        let rect:CGRect = CGRect.init(x: 0, y: 0, width: 640, height: 640)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let picture:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let imageData:Data = UIImagePNGRepresentation(picture)!
        return UIImage.init(data: imageData)!
    }
    
    static func formatDateTimeString(string: String) -> String {
        let first:String = string.replacingOccurrences(of: "T", with: " ")
        let word = first.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = word.range(of: ".")?.lowerBound {
            return "\(word[..<lowerBound])"
        }
        return word
    }
    
    static func currentDateTime() -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    static func currentDate() -> String {
        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    static func getTimeFromDateTime(datetimeString: String) -> String {
        let stringsArray:Array<String> = datetimeString.components(separatedBy: " ")
        return stringsArray[1]
    }
    
    static func textViewBorder(textView: UITextView) -> Void {
        textView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10
    }
    
    static func autoResizingTableView(tableView: UITableView, rowHeight:Float) {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CGFloat(rowHeight)
    }
    
    static func selectedLanguage() -> String {
        if NSLocale.preferredLanguages.count > 0 {
            return NSLocale.preferredLanguages[0]
        }
        return "en"
    }
    
    static func isArabicVersion() -> Bool {
        return self.selectedLanguage() == "ar"
    }
    
    static func initializeRefreshControl(tableView: UITableView, action: Selector, viewController: UIViewController) -> UIRefreshControl {
        let refreshControl = UIRefreshControl.init()
        refreshControl.backgroundColor = UIColor.init(red: 0.153, green: 0.118, blue: 0.196, alpha: 1.0)
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(viewController, action: action, for: UIControlEvents
            .valueChanged)
        tableView.addSubview(refreshControl)
        return refreshControl
    }
    
    static func loadRefreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        tableView.reloadData()
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MMM d, h:mm a"
        
        let title = String(format: "Last update: %@", formatter.string(from: Date()))
        let attrsDictionary:[NSAttributedStringKey: UIColor] = [
            NSAttributedStringKey.foregroundColor: .white
        ]
        let attributedTitle = NSAttributedString.init(string: title, attributes: attrsDictionary)
        
        refreshControl.attributedTitle = attributedTitle
        refreshControl.endRefreshing()
    }
    
    static func setBackButtonImage() {
        UIBarButtonItem.appearance()
            .setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -600), for: .default)
    }
    
    static func transparentNavigationController(navController: UINavigationController) {
        navController.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage.init()
        navController.navigationBar.isTranslucent = true
        navController.view.backgroundColor = .clear
    }
    
    static func indexPathOfTextField(textField: UITextField, tableView: UITableView)   -> IndexPath {
        let origin = textField.frame.origin
        let point = textField.superview?.convert(origin, to: tableView)
        return tableView.indexPathForRow(at: point!)!
    }
    
    static func indexPathOfTextView(textView: UITextView, tableView: UITableView) -> IndexPath {
        let origin = textView.frame.origin
        let point = textView.superview?.convert(origin, to: tableView)
        return tableView.indexPathForRow(at: point!)!
    }
    
    static func imageNameFromTimeStamp(index: Int) -> String {
        let timeInterval = NSDate().timeIntervalSince1970
        let string = "\(timeInterval)".replacingOccurrences(of: ".", with: "")
        return "image\(string)\(index).png"
    }
    
    static func randomImageName() -> String {
        let timeInterval = NSDate().timeIntervalSince1970
        let string = "\(timeInterval)".replacingOccurrences(of: ".", with: "")
        return "image\(string).png"
    }
    
    static func fillTextField(tableView: UITableView, row:Int, section:Int, tag:Int, text:String) {
        let indexPath = IndexPath.init(row: row, section: section)
        let cell = tableView.cellForRow(at: indexPath)
        let textField = cell?.contentView.viewWithTag(tag) as! UITextField
        textField.text = text
    }
    
    static func indexPathForButton(button: UIButton, tableview: UITableView) -> IndexPath {
        let buttonRect = button.convert(button.bounds, to: tableview)
        return tableview.indexPathForRow(at: buttonRect.origin)!
    }
    
    static func urlSessionConfig() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        return config
    }
    
    static func getStringAttibutes() -> [NSAttributedStringKey: Any] {
        let customShadow = NSShadow()
        customShadow.shadowBlurRadius = 3
        customShadow.shadowOffset = CGSize(width: 3, height: 3)
        customShadow.shadowColor = UIColor.gray
        return [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.shadow: customShadow
        ]
    }
    
    static func setNavigationBarAppearance(navigationBar: UINavigationBar) {
        navigationBar.barTintColor = UIColor(red:1.00, green:0.75, blue:0.20, alpha:1.0)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }
    
    static func moveToScreen(storyboardId: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        appDelegate.window?.rootViewController = storyBoard.instantiateViewController(withIdentifier: storyboardId)
    }
    
    static func singleString(stringArray: [String]) -> String? {
        if stringArray.count == 0 {
            return nil
        }
        return stringArray.joined(separator: "\n")
    }
    
    static func toggleButton(sender: RNLoadingButton, view: UIView) {
        sender.isLoading = !sender.isLoading
        view.isUserInteractionEnabled = !view.isUserInteractionEnabled
    }
    
    static func showValidationError(error: String) {
        let banner = Banner(title: NSLocalizedString("Oops...", comment: ""), subtitle: error, image: nil, backgroundColor: Constants.VALIDATION_ERROR_RED, didTapBlock: nil)
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }
}
