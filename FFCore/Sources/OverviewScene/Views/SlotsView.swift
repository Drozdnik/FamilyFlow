import SwiftUI

struct SlotsView<Header: View, ListContent: View>: View {
    private enum Constants: Double {
        case bodySpacing = 20.0
    }

    @State private var selectedProgressIndex: Int = 0 {
        didSet {
            layoutType.viewModel.updateProgress(selectedProgress)
        }
    }

    private var selectedProgress: TaskProgress {
        TaskProgress.value(for: selectedProgressIndex)
    }

    private var progressDescription: String {
        TaskProgress.allCases.description
    }

    let layoutType: LayoutType
    let headerBuilder: () -> Header
    let listBuilder: () -> ListContent

    init(
        _ layoutType: LayoutType,
        selectedProgressIndex: Int = 0,
        @ViewBuilder headerBuilder: @escaping () -> Header,
        @ViewBuilder listBuilder: @escaping () -> ListContent
    ) {
        self.layoutType = layoutType
        self.selectedProgressIndex = selectedProgressIndex
        self.headerBuilder = headerBuilder
        self.listBuilder = listBuilder
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.bodySpacing.rawValue) {
            headerBuilder()
                .animation(.easeInOut, value: selectedProgressIndex)

            listBuilder()
        }
        .navigationTitle(layoutType.viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: layoutType.viewModel.createItem) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
