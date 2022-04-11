import SwiftUI

struct StepsView: View {
    @Environment(\.editMode) private var editMode
    @StateObject var viewModel: ViewModel

    init(recipe: Recipe, date: Date? = nil) {
        let viewModel = ViewModel(recipe: recipe, date: date)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }

    var body: some View {
        content
            .dismissKeyboard()
            .onAppear {
                viewModel.refresh()
            }
            .onChange(of: viewModel.date) { _ in
                viewModel.refresh()
            }
    }

    private var content: some View {
        VStack(spacing: 10) {
            header
            scrollableContent
            finish
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private var header: some View {
        ZStack {
            recipeNameField
            HStack {
                Button {

                } label: {
                    Image(systemName: "chevron.left")
                }
                .contentShape(Rectangle())
                Spacer()
                EditButton()
            }
        }
        .padding()
    }

    private var recipeNameField: some View {
        TextField("Recipe name", text: $viewModel.recipe.name)
            .disabled(!isEditing)
            .fixedSize()
            .padding(5)
            // need to extract this to a ViewModifier
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder()
                    .foregroundColor(.gray.opacity(0.25))
                    .if(!isEditing) {
                        $0.opacity(0)
                    }
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }

    private var scrollableContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach($viewModel.recipe.steps) { $step in
                    StepRow(step: $step) {
                        viewModel.refresh()
                    } onDelete: {
                        viewModel.recipe.steps.removeAll(where: { $0 == step })
                    }
                }
                StepRow(step: $viewModel.step) {
                    viewModel.add()
                } onDelete: {
                    print("onDelete!!")
                }
                .if(!isEditing) {
                    $0.opacity(0)
                }
            }
            .padding(.horizontal, 5)
        }
    }

    private var addButton: some View {
        Button {
            viewModel.add()
        } label: {
            Text("Add")
        }
        .buttonStyle(.bordered)
        .opacity(isEditing ? 1 : 0)
    }

    private var finish: some View {
        HStack {
            Text("Finish")
            Spacer()
            finishTimePickers
        }
        .padding(.horizontal)
    }

    private var finishTimePickers: some View {
        VStack(alignment: .trailing, spacing: 5) {
            DatePickerField(date: $viewModel.date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
            DatePickerField(date: $viewModel.date, displayedComponent: .date, alignment: .topTrailing)
                .font(.caption)
        }
        .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        var recipe: Recipe = .preview
        var date: Date = Date().withAdded(hours: 6)

        var body: some View {
            StepsView(recipe: recipe, date: date)
        }
    }
}
