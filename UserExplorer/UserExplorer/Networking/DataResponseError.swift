import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  
  var reason: String {
    switch self {
    case .network:
      return NSLocalizedString("An error occurred while fetching data ", comment: "ResponseError reason")
    case .decoding:
      return NSLocalizedString("An error occurred while decoding data", comment: "ResponseError reason")
    }
  }
}
