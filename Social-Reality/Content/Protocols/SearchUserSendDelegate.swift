//
//  SearchUserSendDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

protocol SearchUserSendDelegate: AnyObject {
    func selectUsers(models: [UserModel])
    func dismissSearchUserSendView()
}
