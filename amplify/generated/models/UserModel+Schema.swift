// swiftlint:disable all
import Amplify
import Foundation

extension UserModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case userName
    case status
    case first
    case last
    case lastActive
    case access
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userModel = UserModel.keys
    
    model.pluralName = "UserModels"
    
    model.fields(
      .id(),
      .field(userModel.userName, is: .required, ofType: .string),
      .field(userModel.status, is: .optional, ofType: .string),
      .field(userModel.first, is: .optional, ofType: .string),
      .field(userModel.last, is: .optional, ofType: .string),
      .field(userModel.lastActive, is: .optional, ofType: .string),
      .field(userModel.access, is: .required, ofType: .enum(type: ProfileAccessibility.self))
    )
    }
}