//
//  Query.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation

struct Query {
    static var get = ReadMethods()
    static var write = WriteMethods()
    static var update = UpdateMethods()
    static var delete = DeleteMethods()
    static var subscribe = SubscribeMethods()
}

enum EventType {
    case create
    case update
    case delete
}

enum ResultType {
    case success
    case error
}
