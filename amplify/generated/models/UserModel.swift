// swiftlint:disable all
import Amplify
import Foundation

public struct UserModel: Model {
  public let id: String
  public var username: String
  public var status: String?
  public var first: String?
  public var last: String?
  public var lastActive: String?
  public var access: ProfileAccessibility
  public var email: String
  public var image: String?
  
  public init(id: String = UUID().uuidString,
      username: String,
      status: String? = nil,
      first: String? = nil,
      last: String? = nil,
      lastActive: String? = nil,
      access: ProfileAccessibility,
      email: String,
      image: String? = nil) {
      self.id = id
      self.username = username
      self.status = status
      self.first = first
      self.last = last
      self.lastActive = lastActive
      self.access = access
      self.email = email
      self.image = image
  }
}