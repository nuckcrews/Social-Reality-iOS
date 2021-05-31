//
//  Remote.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

struct Remote {
    
    let write = WriteRemoteMethods()
    let get = ReadRemoteMethods()
    let update = UpdateRemoteMethods()
    let delete = DeleteRemoteMethods()
    let subscribe = SubscribeRemoteMethods()
    
}
