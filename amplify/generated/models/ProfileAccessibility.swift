// swiftlint:disable all
import Amplify
import Foundation

public enum ProfileAccessibility: String, EnumPersistable {
  case `public` = "PUBLIC"
  case `private` = "PRIVATE"
  case professional = "PROFESSIONAL"
}