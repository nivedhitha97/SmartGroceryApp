//
//  JSONLoader.swift
//  SmartGroceryApp
//
//  Created by Nivedhitha on 30/12/2025.
//

import Foundation

class JSONLoader {
    static func load<T: Decodable>(_ filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Missing file: \(filename).json")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(filename): \(error)")
        }
    }
}
