//
//  CryptoModels.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//


import Foundation

enum HTTPError: LocalizedError {
  
  case statusCode
  case post
}

// MARK: - DTOs
struct CoinMarketData: Codable {
    let id: Int
    let name, symbol, slug: String
    let quote: [String: Quote]

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case quote
    }
}

struct Quote: Codable {
    let price: Double
    let volume24H: Double
    let volumeChange24H, percentChange1H, percentChange24H, percentChange7D: Double
    let marketCap: Double
    let marketCapDominance: Double
    let fullyDilutedMarketCap: Double


    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case volumeChange24H = "volume_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case fullyDilutedMarketCap = "fully_diluted_market_cap"
    }
}



// MARK: - Welcome
struct CoinMarket<T: Codable>: Codable {
    let status: CoinMarketStatus
    let data: [T]
}

struct CoinMarketStatus: Codable {
    let timestamp: String?
    let errorCode: Int?
    let errorMessage: String?
    let creditCount: Int?
  }





