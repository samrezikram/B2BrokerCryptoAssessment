//
//  Double + Extension.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
