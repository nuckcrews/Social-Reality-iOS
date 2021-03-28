//
//  Date.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/20/21.
//

import Foundation

extension Date {
    
    var rawDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.raw.rawValue
        return dateFormatter.string(from: self)
    }
    
    func formattedString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func currentDistance(to: Date) -> String {
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: self, to: to)
        let seconds = Double(dateComponents.second ?? 0)
        let m = round(seconds / 60.0)
        let mins = Int(m)
        var result = ""
        if mins < 0 {
            result = "Upcoming"
        } else if mins == 1 {
            result = "\(mins) min"
        } else if mins == 0 {
             result = "now"
        } else if mins < 60 {
            result = "\(mins) mins"
        } else if mins > 60 && mins < 1440 {
            let h = round(m / 60)
            let hrs = Int(h)
            if hrs == 1 {
                result = "\(hrs) hr"
            } else {
                result = "\(hrs) hrs"
            }
        } else {
            let d = round(m / 1440)
            let days = Int(d)
            if days < 1 {
                result = "Past Due"
            } else if days == 1 {
                result = "\(days) day"
            } else {
                result = "\(days) days"
            }
        }
        
        return result
    }
    
}


enum DateFormat: String {
    case raw = "yyyy-MM-dd'T'HH:mm:ssZ"
    case shortMonthDate = "MMM d"
    case shortDayMonthDate = "E, MMM d"
    case longMonthDate = "MMMM d"
    case time = "h:mm a"
}
