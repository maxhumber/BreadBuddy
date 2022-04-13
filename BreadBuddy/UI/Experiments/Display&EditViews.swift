import SwiftUI

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

struct Day: Identifiable {
    var id: UUID = .init()
    var date: Date
    var steps: [Step]
}

struct DayDivider: View {
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

struct DisplayView: View {
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
                DayDivider(day: day)
                ForEach(day.steps) { step in
                    DisplayRow(step: step)
                }
            }
            Spacer()
        }
        .padding()
    }
}

extension View {
    func lined() -> some View {
        self.modifier(Lined())
    }
}

fileprivate struct Lined: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 1) {
            content
            Rectangle()
                .frame(height: 1)
                .opacity(0.25)
        }
    }
}

struct EditRow: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack {
                Image(systemName: "square")
                    .opacity(0)
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
            .contentShape(Rectangle())
            .font(.title3)
            .foregroundColor(.gray)
            .padding(.horizontal, 10)
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Wed • 8:00pm")
                        .foregroundColor(.gray)
                        .font(.caption2.italic())
                    Text("Mix Ingredients")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lined()
                }
                ZStack {
                    SkeleText("XXX")
                    Text("10")
                }
                .font(.title3)
                .lined()
                .fixedSize()
                ZStack {
                    SkeleText("XXXX")
                    Text("mins")
                }
                .font(.title3)
                .lined()
                .fixedSize()
            }
        }
        .padding(.trailing)
    }
}

struct EditView: View {
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                SkeleText("XXXXXXXXXXXXXX")
                Text("Maggie's Baguette")
            }
            .font(.body)
            .lined()
            .fixedSize()
            .padding(.top)
            EditRow()
            EditRow()
            EditRow()
            Spacer()
        }
        .environment(\.editMode, .constant(.active))
    }
}

struct NewViews_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
        EditView()
    }
}
