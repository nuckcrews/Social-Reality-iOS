// swiftlint:disable all
import Amplify
import Foundation

public enum CreationAccessibility: String, EnumPersistable {
  case `public` = "PUBLIC"
  case `private` = "PRIVATE"
  case personal = "PERSONAL"
}