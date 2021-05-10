//
//  Segues.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/11/21.
//

import Foundation

enum Segue: String {
    
    case toSignInFromCover
    case toCreatePasswordFromSignIn
    case toPasswordFromSign
    case toNewUserFromSign
    case toHomeFromSignIn
    case toCreateUserFromPassword
    case toHomeFromPassword
    case toAvatarFromCreateUser
    case toHomeFromCreateUser
    case toHomeFromAvatar
    case toSettingsFromProfile
    case toCreateUserFromPasswordEnter
    case toConfirmUserFromCreatePassword
    case toConfirmUserFromPassword
    case toCreateUserFromConfirm
    case toEditProfileFromAccount
    case toHomeFromSettings
    case toCreationDetailFromAccount
    case toCreateUserFromCover
    case toCreationCollectionFromAccount
    case toMessageFromInbox
    case toMessageFromCover
    case toCreationTableFromProfile
    case toCreationTableFromExplore
    case toCreationTableFromMessage
    case toNewMessageFromInbox
    
}
