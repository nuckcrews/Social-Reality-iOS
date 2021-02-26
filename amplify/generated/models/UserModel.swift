// swiftlint:disable all
import Amplify
import Foundation

public struct UserModel: Model {
  public let id: String
  public var userName: String
  public var status: String?
  public var first: String?
  public var last: String?
  public var lastActive: String?
  public var access: ProfileAccessibility
  
  public init(id: String = UUID().uuidString,
      userName: String,
      status: String? = nil,
      first: String? = nil,
      last: String? = nil,
      lastActive: String? = nil,
      access: ProfileAccessibility) {
      self.id = id
      self.userName = userName
      self.status = status
      self.first = first
      self.last = last
      self.lastActive = lastActive
      self.access = access
  }
}