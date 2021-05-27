//
//  Query.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation


struct Query {
    
    static var write = WriteMethods()
    static var get = ReadMethods()
    static var update = UpdateMethods()
    static var delete = DeleteMethods()
    static var subscribe = SubscribeMethods()
    
}
