//
//  SearchUserDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

protocol SearchUserDelegate: AnyObject {
    func selectUsers(models: [UserModel])
    func dismissSearchView()
}
