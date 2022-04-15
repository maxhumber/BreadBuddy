import SwiftUI

extension DisplayContent {
    final class ViewModel: ObservableObject {
        @Published var recipe: Recipe
        
        init(_ recipe: Recipe) {
            self.recipe = recipe
        }
        
        var lastStep: Step {
            Step(description: "Ready", timeValue: 0, timeStart: recipe.timeEnd)
        }
        
        var days: [Day] {
            let grouped = Dictionary(grouping: recipe.steps) { (step: Step) -> String in
                if let date = step.timeStart {
                    return dateFormatter.string(from: date)
                } else {
                    return ""
                }
            }
            return grouped
                .map { Day(date: $0.value[0].timeStart!, steps: $0.value) }
                .sorted { $0.date < $1.date }
        }
        
        private let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter
        }()
    }
}

struct DisplayContent: View {
    @StateObject var viewModel: ViewModel
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: .init(recipe))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(viewModel.days) { day in
                    Divider(day: day)
                    ForEach(day.steps) { step in
                        DisplayRow(step: step)
                    }
                    DisplayRow(step: viewModel.lastStep)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct DisplayContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty())
    }
}
