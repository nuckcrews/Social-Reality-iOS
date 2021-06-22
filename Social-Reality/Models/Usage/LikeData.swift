//
//  LikeData.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Combine

class LikeData {
    
    @Published var like: LikeModel?
    @Published var creation: CreationModel?
    @Published var user: UserModel?
    
    init(like: LikeModel?, creation: CreationModel?, user: UserModel?) {
        self.like = like
        self.creation = creation
        self.user = user
    }
    
}
