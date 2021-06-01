//
//  Query.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation


struct Query {
    
    static let write = WriteMethods()
    static let get = ReadMethods()
    static let update = UpdateMethods()
    static let delete = DeleteMethods()
    static let subscribe = SubscribeMethods()
    
    static let cache = Cache()
    static let remote = Remote()
    static let defaults = Defaults()
    
}
