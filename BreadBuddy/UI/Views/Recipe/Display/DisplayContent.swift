import SwiftUI

#warning("extract view model from here")
struct DisplayContent: View {
    var recipe: Recipe
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    #warning("get rid of all the force unwraps!!")
    var days: [Day] {
        let grouped = Dictionary(grouping: recipe.steps) { (step: Step) -> String in
            dateFormatter.string(from: step.timeStart!)
        }
        return grouped
            .map {
                Day(date: $0.value[0].timeStart!, steps: $0.value)
            }
            .sorted {
                $0.date < $1.date
            }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(days) { day in
                    Divider(day: day)
                    ForEach(day.steps) { step in
                        DisplayRow(step: step)
                    }
                    DisplayRow(step: Step(description: "Ready", timeValue: 0, timeUnit: .minutes, timeStart: recipe.timeEnd))
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct DisplayContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, database: .empty())
    }
}
