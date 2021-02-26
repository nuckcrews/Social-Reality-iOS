// swiftlint:disable all
import Amplify
import Foundation

extension LikeModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case status
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let likeModel = LikeModel.keys
    
    model.pluralName = "LikeModels"
    
    model.fields(
      .id(),
      .field(likeModel.status, is: .optional, ofType: .string)
    )
    }
}