//
//  Query.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

struct Query {
    
    static var write = WriteMethods()
    static var get = ReadMethods()
    static var update = UpdateMethods()
    static var delete = DeleteMethods()
    static var subscribe = SubscribeMethods()
    
}
