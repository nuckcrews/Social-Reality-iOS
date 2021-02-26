// swiftlint:disable all
import Amplify
import Foundation

extension CommentModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case content
    case status
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let commentModel = CommentModel.keys
    
    model.pluralName = "CommentModels"
    
    model.fields(
      .id(),
      .field(commentModel.content, is: .required, ofType: .string),
      .field(commentModel.status, is: .optional, ofType: .string)
    )
    }
}