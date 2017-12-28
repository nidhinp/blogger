//
//  Network.swift
//  Consumer
//
//  Created by Q8coders on 5/15/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Network {
    
    var sessionManager: SessionManager?
    
    static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static func returnHeader() -> HTTPHeaders? {
        guard let authToken = UserDefaults.standard.value(forKey: "authToken") else {
            return nil
        }
        let headers:HTTPHeaders = [
            "Authorization": "Token \(authToken)"
        ]
        return headers
    }
    
    static func makeRequest(view: UIView, url:String, method:HTTPMethod, parameters:[String: Any]?, completion: @escaping(_: [String: Any]) -> Void){
        
        let apiEndpoint = Constants.URL+url
        print(apiEndpoint)
        
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show()
        self.sharedInstance.request(apiEndpoint, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: self.returnHeader()).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    var jsonDict = response.result.value as! [String:Any]
                    let statusCode = response.response?.statusCode ?? 0
                    jsonDict["statusCode"] = statusCode
                    completion(jsonDict)
                }
                SVProgressHUD.dismiss()
                break
                
            case .failure(_):
                print(response.result.error ?? "error")
                SVProgressHUD.dismiss()
                break
            }
        }
    }
    
    static func multiPartRequest(view: UIView, url:String, method:HTTPMethod, parameters:[String: Any]?, imageArray:[UIImage], completion: @escaping(_: [String:Any]) -> Void) {
        
        let apiEndpoint = Constants.URL+url
        print(apiEndpoint)
        
        let url = try! URLRequest(url: url, method: method, headers: nil)
        
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if (imageArray.count > 0) {
                    for (index, image) in imageArray.enumerated() {
                        multipartFormData.append(UIImagePNGRepresentation(image)!, withName: "image[]", fileName: Helpers.imageNameFromTimeStamp(index: index), mimeType: "image/png")
                    }
                }
                if (parameters != nil) {
                    for (key, value) in parameters! {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
        },
            with: url,
            encodingCompletion: {
                encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        SVProgressHUD.showProgress(Float(progress.fractionCompleted), status: NSLocalizedString("Uploading...", comment: "Uploading...") + " " + progress.fractionCompleted.percentage())
                    })
                    upload.responseJSON { response in
                        var jsonDict = response.result.value as! [String:Any]
                        let statusCode = response.response?.statusCode ?? 0
                        jsonDict["statusCode"] = statusCode
                        SVProgressHUD.dismiss()
                        completion(jsonDict)
                    }
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    print("ERROR RESPONSE: \(encodingError)")
                }
        })
    }

}
