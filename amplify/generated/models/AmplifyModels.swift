// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "be0c2afb072989f831806e91ad084606"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: EmailModel.self)
    ModelRegistry.register(modelType: LikeModel.self)
    ModelRegistry.register(modelType: CommentModel.self)
    ModelRegistry.register(modelType: CreationModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}