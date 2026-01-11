//
//  MealPlanner.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 02/01/2026.
//

import Foundation

class MealPlanner {
    
    func generateMealPlan(
        recipes: [Recipe],
        preferences: UserPreferences,
        routine: MealRoutine
    ) -> MealPlan {
        
        let filteredRecipes = filterRecipes(recipes, preferences)
        
        let breakfast = selectMeal(
            type: routine.breakfastType,
            from: filteredRecipes
        )
        
        let lunch = selectMeal(
            type: routine.lunchType,
            from: filteredRecipes
        )
        
        let dinner = selectMeal(
            type: routine.dinnerType,
            from: filteredRecipes
        )
        
        return MealPlan(
            breakfast: breakfast,
            lunch: lunch,
            dinner: dinner
        )
    }
    
    // MARK: - Filtering Logic
    
    private func filterRecipes(
        _ recipes: [Recipe],
        _ preferences: UserPreferences
    ) -> [Recipe] {
        
        recipes.filter { recipe in
            
            // Diet filter
            if preferences.dietType == "Vegetarian" &&
                recipe.containsMeat {
                return false
            }
            
            // Allergies
            for allergy in preferences.allergies {
                if recipe.ingredients.contains(where: {
                    $0.name.lowercased().contains(allergy.lowercased())
                }) {
                    return false
                }
            }
            
            return true
        }
    }
    
    // MARK: - Meal Type Logic
    
    private func selectMeal(
        type: MealType,
        from recipes: [Recipe]
    ) -> Recipe? {
        
        switch type {
        case .fixed:
            return recipes.first
        case .homeCooked:
            return recipes.randomElement()
        case .outside:
            return nil   // user eats out
        case .flexible:
            return recipes.randomElement()
        }
    }
}
