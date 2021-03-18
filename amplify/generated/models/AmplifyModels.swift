// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "d4f818e63a10c4137b0f9426f13b130f"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: EmailModel.self)
    ModelRegistry.register(modelType: LikeModel.self)
    ModelRegistry.register(modelType: CommentModel.self)
    ModelRegistry.register(modelType: CreationModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}