//
//  Recipe.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 29/12/2025.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let ingredients: [Ingredient]

    var containsMeat: Bool {
        let meatKeywords = ["chicken", "beef", "pork", "fish", "mutton", "lamb", "seafood"]
        return ingredients.contains { ingredient in
            meatKeywords.contains { keyword in
                ingredient.name.lowercased().contains(keyword)
            }
        }
    }
}

struct RecipeIngredient: Codable {
    var ingredient: Ingredient
    var quantity: Double // in grams or units
}
