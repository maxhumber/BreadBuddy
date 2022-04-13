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

extension View {
    func aligned() -> some View {
        self.modifier(Aligned())
    }
}

fileprivate struct Aligned: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Image(systemName: "square")
                .opacity(0)
            content
        }
        .contentShape(Rectangle())
    }
}

struct EditRow: View {
    @Binding var step: Step
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            actionButton
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    startTime
                    activity
                }
                duration
                timeUnitMenu
            }
        }
        .padding(.trailing)
    }
    
    private var actionButton: some View {
        Image(systemName: "ellipsis")
            .rotationEffect(.degrees(90))
            .aligned()
            .font(.title3)
            .foregroundColor(.gray)
            .padding(.horizontal, 10)
    }
    
    private var startTime: some View {
        Text("Wed • 8:00pm")
            .foregroundColor(.gray)
            .font(.caption2.italic())
    }
    
    private var activity: some View {
        TextField("Description", text: $step.description)
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lined()
    }
    
    private var duration: some View {
        ZStack {
            SkeleText("XXX")
            TextField("", value: $step.timeValue, formatter: .number)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .opacity(step.timeValue == 0 ? 0.5 : 1)
        }
        .lined()
        .fixedSize(horizontal: true, vertical: true)
        .font(.title3)
    }
    
    private var timeUnitMenu: some View {
        Menu {
            timeUnitMenuOptions
        } label: {
            timeUnitMenuLabel
        }
    }
    
    @ViewBuilder private var timeUnitMenuOptions: some View {
        ForEach(TimeUnit.allCases) { unit in
            Button {
                step.timeUnit = unit
            } label: {
                Text(unit.rawValue)
            }
        }
    }
    
    private var timeUnitMenuLabel: some View {
        ZStack(alignment: .center) {
            SkeleText("XXXX")
            Text(step.timeUnitString)
                .animation(nil, value: UUID())
        }
        .foregroundColor(.black)
        .font(.title3)
        .lined()
        .fixedSize()
    }
}

struct EditView: View {
    @State var recipe: Recipe = .preview
    
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
            ForEach($recipe.steps) { $step in
                EditRow(step: $step)
            }
            EditRow(step: .constant(.init()))
            Spacer()
        }
    }
}

struct NewViews_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
        EditView()
    }
}
