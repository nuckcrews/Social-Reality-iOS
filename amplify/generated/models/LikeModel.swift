// swiftlint:disable all
import Amplify
import Foundation

public struct LikeModel: Model {
  public let id: String
  public var status: String?
  
  public init(id: String = UUID().uuidString,
      status: String? = nil) {
      self.id = id
      self.status = status
  }
}