//
//  MoistureCalculation.swift
//  Komposku
//
//  Created by Ahmad Zaky on 30/07/21.
//

import Foundation

class MoistureCalculation {
    
    static func getMoisturePercentage(materials: [Material]) -> Double {
        let amount = getTotalAmount(materials: materials)
        if amount == 0 {
            return 0
        } else {
            let percentage = getAllMoisture(materials: materials) / getTotalAmount(materials: materials)
            return percentage
        }
    }
    
    static func getAllMoisture(materials: [Material]) -> Double {
        var totalMoisture:Double = 0
        for material in materials {
            totalMoisture += calculateMoisture(materials: material.detail)
        }
        return totalMoisture
    }
    
    static func getTotalAmount(materials: [Material]) -> Double {
        var amount: Double = 0
        for material in materials {
            amount += calculateAmount(materials: material.detail)
        }
        return amount
    }
    static func calculateMoisture(materials: [MaterialDetail]) -> Double {
        var totalMoisture:Double = 0
        for material in materials {
            totalMoisture += Double(material.quantity) * Double(material.moistureLevel)
        }
        let moisture = Double(totalMoisture)
        return moisture
    }
    
    static func calculateAmount(materials: [MaterialDetail]) -> Double {
        var totalAmount:Double = 0
        for material in materials {
            totalAmount += Double(material.quantity)
        }
        return totalAmount
    }
    
}
