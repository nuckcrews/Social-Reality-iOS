// swiftlint:disable all
import Amplify
import Foundation

public enum AuthenticationProvider: String, EnumPersistable {
  case google = "GOOGLE"
  case facebook = "FACEBOOK"
  case apple = "APPLE"
  case email = "EMAIL"
}