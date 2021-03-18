// swiftlint:disable all
import Amplify
import Foundation

public struct LikeModel: Model {
  public let id: String
  public var status: String?
  public var creationID: String?
  public var userID: String?
  public var userImage: String?
  public var userName: String?
  
  public init(id: String = UUID().uuidString,
      status: String? = nil,
      creationID: String? = nil,
      userID: String? = nil,
      userImage: String? = nil,
      userName: String? = nil) {
      self.id = id
      self.status = status
      self.creationID = creationID
      self.userID = userID
      self.userImage = userImage
      self.userName = userName
  }
}