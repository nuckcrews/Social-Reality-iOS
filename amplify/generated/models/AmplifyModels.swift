// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "a458ddd6df1e48e3e29fc6606940917f"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: LikeModel.self)
    ModelRegistry.register(modelType: CommentModel.self)
    ModelRegistry.register(modelType: CreationModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}