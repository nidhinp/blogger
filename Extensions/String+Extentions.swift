//
//  String+Extentions.swift
//  Consumer
//
//  Created by Q8coders on 5/24/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import Foundation

extension String {
    
    func isEmptyString() -> Bool {
        return self == ""
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self.trim())
    }
    
    func isValidPhone() -> Bool {
        let phoneFormat = "^[\\d]+$"
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneFormat)
        return phonePredicate.evaluate(with: self.trim())
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isValidUrl() -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self.trim())
    }
    
    func dateTimeInHumanReadableFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        
        let humanFormatter = DateFormatter()
        humanFormatter.locale = Locale(identifier: Helpers.selectedLanguage())
        humanFormatter.dateFormat = "h:mm a dd MMMM, yyyy"
        humanFormatter.amSymbol = NSLocalizedString("am", comment: "nil")
        humanFormatter.pmSymbol = NSLocalizedString("pm", comment: "nil")
        
        return humanFormatter.string(from: date!)
    }
    
    func timeInHumanReadableFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: self)
        
        let humanFormatter = DateFormatter()
        humanFormatter.locale = Locale(identifier: Helpers.selectedLanguage())
        humanFormatter.dateFormat = "h:mm a"
        humanFormatter.amSymbol = NSLocalizedString("am", comment: "nil")
        humanFormatter.pmSymbol = NSLocalizedString("pm", comment: "nil")
        
        return humanFormatter.string(from: date!)
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func fromUTCToLocalDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return Helpers.formatDateTimeString(string: self)
        }

        dateFormatter.dateFormat = "EEE, d MMM yyyy, h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
