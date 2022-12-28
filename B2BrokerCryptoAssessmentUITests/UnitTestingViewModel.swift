//
//  URLSessionDataTaskMock.swift
//  B2BrokerCryptoAssessmentTests
//
//  Created by Samrez Ikram on 28/12/2022.
//

import Foundation
import Combine

protocol NewDataServiceProtocol {
  func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
  func downlaodItemsWithCombine() -> AnyPublisher<[String], Error>

}

class NewMockDataService: NewDataServiceProtocol {
  
  let items: [String]
  
  init(items: [String]?) {
    self.items = items ?? ["One", "Two", "Three"]
  }
  
  func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      completion(self.items)
    }
  }
  
  func downlaodItemsWithCombine() -> AnyPublisher<[String], Error> {
    Just(items)
      .tryMap({ publishedItems in
        guard !publishedItems.isEmpty else {
          throw URLError(.badServerResponse)
        }
        return publishedItems
      })
      .eraseToAnyPublisher()
  }
}

enum NetworkEndpoint {

  static let baseURL =  URL(string: "https://pro-api.coinmarketcap.com/")!

  case live

  var url: URL {
    switch self {
    case .live:
      return NetworkEndpoint.baseURL.appendingPathComponent("v1/cryptocurrency/listings/latest") 
    }
  }
}

enum NetworkError: LocalizedError {

  case addressUnreachable(URL)
  case invalidResponse

  var errorDescription: String? {
    switch self {
    case .invalidResponse:
      return "The server response is invalid."
    case .addressUnreachable(let url):
      return "\(url.absoluteString) is unreachable."
    }
  }
}
