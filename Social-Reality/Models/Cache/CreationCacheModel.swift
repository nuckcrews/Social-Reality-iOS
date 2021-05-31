//
//  CreationCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

final class CreationCacheModel {
    
    public var creation: CreationModel?
    
    init?(_ model: CreationModel?) {
        if let model = model {
            creation = model
        } else {
            return nil
        }
    }
    
}
