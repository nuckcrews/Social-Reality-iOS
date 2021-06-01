//
//  Cache.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct Cache {
    
    let write = WriteCacheMethods()
    let get = ReadCacheMethods()
    let update = UpdateCacheMethods()
    let delete = DeleteCacheMethods()
    
}
