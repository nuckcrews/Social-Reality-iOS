// swiftlint:disable all
import Amplify
import Foundation

public struct CreationModel: Model {
  public let id: String
  public var title: String?
  public var description: String?
  public var lastViewed: String?
  public var accessibility: CreationAccessibility
  public var status: String?
  public var date: Temporal.Date?
  public var userID: String?
  public var comments: List<CommentModel>?
  public var likes: List<LikeModel>?
  public var userName: String?
  public var userImage: String?
  
  public init(id: String = UUID().uuidString,
      title: String? = nil,
      description: String? = nil,
      lastViewed: String? = nil,
      accessibility: CreationAccessibility,
      status: String? = nil,
      date: Temporal.Date? = nil,
      userID: String? = nil,
      comments: List<CommentModel>? = [],
      likes: List<LikeModel>? = [],
      userName: String? = nil,
      userImage: String? = nil) {
      self.id = id
      self.title = title
      self.description = description
      self.lastViewed = lastViewed
      self.accessibility = accessibility
      self.status = status
      self.date = date
      self.userID = userID
      self.comments = comments
      self.likes = likes
      self.userName = userName
      self.userImage = userImage
  }
}