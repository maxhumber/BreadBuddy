import SwiftUI

struct Day: Identifiable {
    var id: UUID = .init()
    var date: Date
    var steps: [Step]
}

struct DisplayContent: View {
    var recipe: Recipe = .preview
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
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
        VStack(spacing: 20) {
            Text("Maggie's Baguette")
            ForEach(days) { day in
                Divider(day: day)
                ForEach(day.steps) { step in
                    DisplayRow(step: step)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct DisplayRow: View {
    var step: Step
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            time
            activity
            Spacer()
        }
    }
    
    private var time: some View {
        ZStack(alignment: .trailing) {
            SkeleText("12:59 am")
            Text(step.timeStartString)
        }
        .font(.body.bold())
    }
    
    private var activity: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(step.description)
                .font(.body)
            Text(step.durationString)
                .font(.caption.italic())
        }
    }
}

struct Divider: View {
    var day: Day
    
    var body: some View {
        HStack(spacing: 10) {
            line
            label
            line
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
    
    private var label: some View {
        Text(day.date.weekday())
            .font(.caption)
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .opacity(0.5)
    }
}

struct DisplayContent_Previews: PreviewProvider {
    static var previews: some View {
        DisplayContent()
    }
}
