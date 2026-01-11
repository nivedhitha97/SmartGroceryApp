//
//  MealPlan.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 02/01/2026.
//

import Foundation

struct MealPlan: Identifiable {
    let id = UUID()
    let breakfast: Recipe?
    let lunch: Recipe?
    let dinner: Recipe?
}
