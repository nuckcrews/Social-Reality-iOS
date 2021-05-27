//
//  Remote.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

struct Remote {
    
    static var write = WriteRemoteMethods()
    static var get = ReadRemoteMethods()
    static var update = UpdateRemoteMethods()
    static var delete = DeleteRemoteMethods()
    static var subscribe = SubscribeRemoteMethods()
    
}
