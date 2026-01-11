import SwiftUI

struct ContentView: View {
    
    @State private var dietType: String = "Vegetarian"
    @State private var selectedCuisines: Set<String> = []
    @State private var dislikes: String = ""
    @State private var allergies: String = ""
    @State private var weeklyBudget: Double = 50
    
    let cuisines = ["Indian", "Italian", "Dutch", "Asian", "Mexican"]
    let dietOptions = ["Vegetarian", "Non-Vegetarian", "Vegan", "High Protein"]
    
    var body: some View {
        NavigationView {
            Form {
                
                // MARK: Diet Type
                Section(header: Text("Diet Type")) {
                    Picker("Select Diet", selection: $dietType) {
                        ForEach(dietOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                // MARK: Cuisine Preferences
                Section(header: Text("Preferred Cuisines")) {
                    ForEach(cuisines, id: \.self) { cuisine in
                        Toggle(cuisine, isOn: Binding(
                            get: { selectedCuisines.contains(cuisine) },
                            set: { isSelected in
                                if isSelected {
                                    selectedCuisines.insert(cuisine)
                                } else {
                                    selectedCuisines.remove(cuisine)
                                }
                            }
                        ))
                    }
                }
                
                // MARK: Dislikes
                Section(header: Text("Disliked Ingredients")) {
                    TextField("e.g. mushrooms, olives", text: $dislikes)
                }
                
                // MARK: Allergies
                Section(header: Text("Allergies")) {
                    TextField("e.g. peanuts, lactose", text: $allergies)
                }
                
                // MARK: Budget
                Section(header: Text("Weekly Budget (€)")) {
                    Slider(value: $weeklyBudget, in: 20...150, step: 5)
                    Text("€\(Int(weeklyBudget))")
                        .font(.headline)
                }
                
                NavigationLink("Set Meal Routine") {
                    MealRoutineView()
                }
                
                // MARK: Save Button
                Section {
                    Button(action: savePreferences) {
                        Text("Save Preferences")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .navigationTitle("Your Preferences")
        }
    }
    
    func savePreferences() {
        let preferences = UserPreferences(
            dietType: dietType,
            cuisines: Array(selectedCuisines),
            dislikes: dislikes.components(separatedBy: ","),
            allergies: allergies.components(separatedBy: ","),
            budgetWeekly: weeklyBudget
        )
        
        if let encoded = try? JSONEncoder().encode(preferences) {
            UserDefaults.standard.set(encoded, forKey: "userPreferences")
        }
        
        print("Preferences saved:", preferences)
    }
}

#Preview {
    ContentView()
}
