// swiftlint:disable all
import Amplify
import Foundation

extension LikeModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case status
    case creationID
    case userID
    case userImage
    case userName
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let likeModel = LikeModel.keys
    
    model.pluralName = "LikeModels"
    
    model.fields(
      .id(),
      .field(likeModel.status, is: .optional, ofType: .string),
      .field(likeModel.creationID, is: .optional, ofType: .string),
      .field(likeModel.userID, is: .optional, ofType: .string),
      .field(likeModel.userImage, is: .optional, ofType: .string),
      .field(likeModel.userName, is: .optional, ofType: .string)
    )
    }
}