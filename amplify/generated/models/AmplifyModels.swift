// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "e8002408e5e1caba925b7ab1e9cfea33"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: LikeModel.self)
    ModelRegistry.register(modelType: CommentModel.self)
    ModelRegistry.register(modelType: CreationModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}