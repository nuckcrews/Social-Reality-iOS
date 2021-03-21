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
        dateFormatter.dateFormat = ""
        return dateFormatter.string(from: self)
    }
    
}


