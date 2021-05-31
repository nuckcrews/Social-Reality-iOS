//
//  CommentCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

final class CommentCacheModel {
    
    public var comment: CommentModel?
    
    init?(_ model: CommentModel?) {
        if let model = model {
            comment = model
        } else {
            return nil
        }
    }
    
}
