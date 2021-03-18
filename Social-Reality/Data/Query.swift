//
//  Query.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct Query {
    static var datastore = DataStore()
    static var api = API()
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


struct DataStore {
    func start() {
        Amplify.DataStore.start { result in
            switch result {
            case .success(let detail):
            print(detail)
            case .failure(let error):
                print(error)
            }
        }
    }
    var get = DataStoreReadMethods()
    var write = DataStoreWriteMethods()
    var update = DataStoreUpdateMethods()
    var delete = DataStoreDeleteMethods()
    var subscribe = DataStoreSubscribeMethods()
}

struct API {
    var get = APIReadMethods()
    var write = APIWriteMethods()
    var update = APIUpdateMethods()
    var delete = APIDeleteMethods()
    var subscribe = APISubscribeMethods()
}
