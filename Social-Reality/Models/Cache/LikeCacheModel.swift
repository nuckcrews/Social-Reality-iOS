//
//  LikeCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

final class LikeCacheModel {
    
    public var like: LikeModel?
    
    init?(_ model: LikeModel?) {
        if let model = model {
            like = model
        } else {
            return nil
        }
    }
    
}
