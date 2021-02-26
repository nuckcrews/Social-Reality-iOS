// swiftlint:disable all
import Amplify
import Foundation

public struct CommentModel: Model {
  public let id: String
  public var content: String
  public var status: String?
  
  public init(id: String = UUID().uuidString,
      content: String,
      status: String? = nil) {
      self.id = id
      self.content = content
      self.status = status
  }
}