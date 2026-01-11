//
//  DailyMealLog.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 29/12/2025.
//

import Foundation
//
//struct MealPlan: Codable, Identifiable {
//    let id: UUID
//    var weekStartDate: Date
//    var meals: [DailyMealLog]
//
//    init(id: UUID = UUID(), weekStartDate: Date, meals: [DailyMealLog]) {
//        self.id = id
//        self.weekStartDate = weekStartDate
//        self.meals = meals
//    }
//}

struct DailyMealLog: Codable {
    var date: Date
    var breakfast: Recipe?
    var lunch: Recipe?
    var dinner: Recipe?
    
    private var allMeals: [Recipe] {
        var meals: [Recipe] = []
        if let breakfast { meals.append(breakfast) }
        if let lunch { meals.append(lunch) }
        if let dinner { meals.append(dinner) }
        return meals
    }

    private func nutritionTotal(
        value: (Ingredient) -> Double
    ) -> Double {
        var total: Double = 0.0

        for recipe in allMeals {
            for ingredient in recipe.ingredients {
                total += value(ingredient)
            }
        }

        return total
    }

    var totalCalories: Double {
        nutritionTotal { $0.calories }
    }

    var totalProtein: Double {
        nutritionTotal { $0.protein }
    }

    var totalCarbs: Double {
        nutritionTotal { $0.carbs }
    }

    var totalFiber: Double {
        nutritionTotal { $0.fiber ?? 0.0 }
    }

    var totalFat: Double {
        nutritionTotal { $0.fat }
    }
    
}
