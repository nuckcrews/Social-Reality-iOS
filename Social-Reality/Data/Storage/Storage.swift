//
//  Storage.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation

struct Storage0 {
    static var local = LocalStorage()
    static var remote = RemoteStorage()
}

struct LocalStorage {
    var upload = LocalUploadMethods()
    var download = LocalDownloadMethods()
    var remove = LocalRemoveMethods()
    var list = LocalListMethods()
}

struct RemoteStorage {
    var upload = UploadMethods()
    var download = DownloadMethods()
    var remove = RemoveMethods()
    var list = ListMethods()
}
