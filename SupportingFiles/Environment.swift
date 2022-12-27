//
//  Environment.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//
import Foundation

public enum EnvironmentVar {
	// MARK: - Keys
	enum Keys {
		enum Plist {
			static let apiKey = "API_KEY"
		}
	}

	// MARK: - Plist
	private static let infoDictionary: [String: Any] = {
		guard let dict = Bundle.main.infoDictionary else {
			fatalError("Plist file not found")
		}
		return dict
	}()

	// MARK: - Plist values
  static let apiKey: String = {
    guard let config = EnvironmentVar.infoDictionary[Keys.Plist.apiKey] as? String else {
      fatalError("Coin Market API KEY not set in plist for this environment")
    }
    return config
  }()
  
}
