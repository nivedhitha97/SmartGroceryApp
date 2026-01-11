//
//  UserPreferences.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 29/12/2025.
//

import Foundation

struct UserPreferences: Codable {
    var dietType: String // e.g., Veg, Non-Veg, High Protein
    var cuisines: [String]
    var dislikes: [String]
    var allergies: [String]
    var budgetWeekly: Double
}
