// swiftlint:disable all
import Amplify
import Foundation

public struct EmailModel: Model {
  public let id: String
  public var email: String
  public var provider: AuthenticationProvider
  
  public init(id: String = UUID().uuidString,
      email: String,
      provider: AuthenticationProvider) {
      self.id = id
      self.email = email
      self.provider = provider
  }
}