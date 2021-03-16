// swiftlint:disable all
import Amplify
import Foundation

extension EmailModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case email
    case provider
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let emailModel = EmailModel.keys
    
    model.pluralName = "EmailModels"
    
    model.fields(
      .id(),
      .field(emailModel.email, is: .required, ofType: .string),
      .field(emailModel.provider, is: .required, ofType: .enum(type: AuthenticationProvider.self))
    )
    }
}