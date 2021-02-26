// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "02a155fa81a2a392320031e4fa26c18b"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: LikeModel.self)
    ModelRegistry.register(modelType: CommentModel.self)
    ModelRegistry.register(modelType: CreationModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}