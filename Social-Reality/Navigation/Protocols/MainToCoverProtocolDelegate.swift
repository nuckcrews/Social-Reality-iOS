//
//  MainToCoverProtocolDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

protocol MainToCoverProtocolDelegate: AnyObject {
    func tappedComments(creation: CreationModel?)
    func tappedSendCreation(creation: CreationModel?)
    func segueToMessage(recipientID: String, conversationID: String?)
}
