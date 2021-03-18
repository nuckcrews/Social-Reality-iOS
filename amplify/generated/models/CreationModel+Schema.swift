// swiftlint:disable all
import Amplify
import Foundation

extension CreationModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case description
    case lastViewed
    case accessibility
    case status
    case date
    case userID
    case comments
    case likes
    case userName
    case userImage
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let creationModel = CreationModel.keys
    
    model.pluralName = "CreationModels"
    
    model.fields(
      .id(),
      .field(creationModel.title, is: .optional, ofType: .string),
      .field(creationModel.description, is: .optional, ofType: .string),
      .field(creationModel.lastViewed, is: .optional, ofType: .string),
      .field(creationModel.accessibility, is: .required, ofType: .enum(type: CreationAccessibility.self)),
      .field(creationModel.status, is: .optional, ofType: .string),
      .field(creationModel.date, is: .optional, ofType: .date),
      .field(creationModel.userID, is: .optional, ofType: .string),
      .hasMany(creationModel.comments, is: .optional, ofType: CommentModel.self, associatedWith: CommentModel.keys.creationID),
      .hasMany(creationModel.likes, is: .optional, ofType: LikeModel.self, associatedWith: LikeModel.keys.creationID),
      .field(creationModel.userName, is: .optional, ofType: .string),
      .field(creationModel.userImage, is: .optional, ofType: .string)
    )
    }
}