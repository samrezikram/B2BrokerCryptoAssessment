//
//  B2BrokerCryptoAssessmentApp.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//

import SwiftUI

@main
struct B2BrokerCryptoAssessmentApp: App {
  
  @Environment(\.scenePhase) var scenePhase
  
  init() {
    // App Lunch tasks
  }
  
  var body: some Scene {
      WindowGroup {
          ContentView()
      }
      .onChange(of: scenePhase) { (newScenePhase) in
        switch newScenePhase {
          case .background:
          break;
          case .inactive:
          break;
          case .active:
          break;
          @unknown default:
          break;
        }
      }
  }
}
