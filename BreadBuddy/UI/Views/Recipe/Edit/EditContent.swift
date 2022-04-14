import SwiftUI

struct EditContent: View {
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

struct EditRow: View {
    @Binding var step: Step
    
    var startTimeString: String {
        let day = step.timeStart?.weekday()
        let time = step.timeStart?.time().lowercased()
        if let day = day, let time = time {
            return "\(day) • \(time)"
        }
        return ""
    }
    
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
        Text(startTimeString)
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

struct EditContent_Previews: PreviewProvider {
    static var previews: some View {
        DisplayContent()
        EditContent()
    }
}
