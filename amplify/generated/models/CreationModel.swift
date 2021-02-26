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
  
  public init(id: String = UUID().uuidString,
      title: String? = nil,
      description: String? = nil,
      lastViewed: String? = nil,
      accessibility: CreationAccessibility,
      status: String? = nil) {
      self.id = id
      self.title = title
      self.description = description
      self.lastViewed = lastViewed
      self.accessibility = accessibility
      self.status = status
  }
}