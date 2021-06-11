//
//  CreationData.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Combine

struct CreationData {
    
    public var creation: CreationModel?
    public var user: UserModel?
    public var comments: [CommentModel]?
    public var likes: [LikeModel]?
    public var userLiked: Bool = false
    
//    init(creation: CreationModel, completion: @escaping () -> Void?) {
//
//        let queue = OperationQueue()
//
//        let creationSubscription = BlockOperation {
//            Query.remote.subscribe.creation(creation.id) { [weak self] model, lstn in
//                self?.creation = model
//            }
//        }
//
//        let userSubscription = BlockOperation {
//            Query.remote.subscribe.user(creation.userID ?? "") { [weak self] model, lstn in
//                self?.user = model
//            }
//        }
//
//        let commentsSubscription = BlockOperation {
//            Query.remote.subscribe.commentsWithPredicate(field: Fields.comment.creationID.rawValue,
//                                                         value: creation.id) { [weak self] models, lstn in
//                self?.comments = models
//            }
//        }
//
//        let likesSubscription = BlockOperation {
//            Query.remote.subscribe.likesWithPredicate(field: Fields.like.creationID.rawValue,
//                                                      value: creation.id) { [weak self] models, lstn in
//                self?.likes = models
//            }
//        }
//
//        let userLikedSubscription = BlockOperation {
//            Query.remote.subscribe.userLikedWithPredicate(userID: creation.userID ?? "",
//                                                          field: Fields.like.creationID.rawValue,
//                                                          value: creation.id) { [weak self] models, lstn in
//                self?.userLiked = models != nil
//            }
//        }
//
//        queue.addOperations([creationSubscription,
//                             userSubscription,
//                             commentsSubscription,
//                             likesSubscription,
//                            userLikedSubscription],
//                            waitUntilFinished: true)
//
//        completion()
//
//    }
}
