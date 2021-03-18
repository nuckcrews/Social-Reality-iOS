// swiftlint:disable all
import Amplify
import Foundation

extension UserModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case username
    case status
    case first
    case last
    case lastActive
    case access
    case email
    case image
    case provider
    case creations
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userModel = UserModel.keys
    
    model.pluralName = "UserModels"
    
    model.fields(
      .id(),
      .field(userModel.username, is: .required, ofType: .string),
      .field(userModel.status, is: .optional, ofType: .string),
      .field(userModel.first, is: .optional, ofType: .string),
      .field(userModel.last, is: .optional, ofType: .string),
      .field(userModel.lastActive, is: .optional, ofType: .string),
      .field(userModel.access, is: .required, ofType: .enum(type: ProfileAccessibility.self)),
      .field(userModel.email, is: .required, ofType: .string),
      .field(userModel.image, is: .optional, ofType: .string),
      .field(userModel.provider, is: .required, ofType: .enum(type: AuthenticationProvider.self)),
      .hasMany(userModel.creations, is: .optional, ofType: CreationModel.self, associatedWith: CreationModel.keys.userID)
    )
    }
}