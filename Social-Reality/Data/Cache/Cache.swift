//
//  Cache.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct Cache {
    
    static let write = WriteCacheMethods()
    static let get = ReadCacheMethods()
    static let update = UpdateCacheMethods()
    static let delete = DeleteCacheMethods()
    static let subscribe = SubscribeCacheMethods()
    
}
