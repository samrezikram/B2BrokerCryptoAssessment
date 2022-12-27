//
//  CryptoService.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//


import Foundation
import Combine

enum CryptoService {
  static let base = URL(string: "https://pro-api.coinmarketcap.com/")!
  private static let apiKey = "25485627-a053-43f3-9a44-47cc82bb7375"
  static let agent = CryptoHttpAgent()
}

extension CryptoService {
  
    static func currencies() -> AnyPublisher<CoinMarket<CoinMarketData>, Error> {
      var request = URLRequest(url: base.appendingPathComponent("v1/cryptocurrency/listings/latest"))
      request.setValue(apiKey, forHTTPHeaderField: Environment.apiKey)
      return agent.run(request)
    }
}

private extension URLComponents {
    func addingApiKey(_ apiKey: String) -> URLComponents {
        var copy = self
        copy.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return copy
    }
    
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}

