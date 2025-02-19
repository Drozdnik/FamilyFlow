import SwiftUI

enum LayoutType {
    case task(TasksViewModel)
    case room(RoomsViewModel)

    var viewModel: any SlotsBaseViewModel {
        switch self {
        case let .task(viewModel):
            return viewModel
        case let .room(viewModel):
            return viewModel
        }
    }
}

@MainActor
enum SlotsViewFactory {
    private enum Constants: Double {
        case headerViewSpacing = 5.0
        case padding = 10.0
    }

    @ViewBuilder
    static func makeSlotsView(for layoutType: LayoutType) -> some View {
        switch layoutType {
        case .task(let viewModel):
            SlotsView(
                .task(viewModel),
                headerBuilder: {
                    TaskHeaderView(viewModel: viewModel)
                },
                listBuilder: {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.items) { item in
                                Self.build(for: item)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, Constants.headerViewSpacing.rawValue)
                            }
                        }
                        .padding([.leading, .trailing], Constants.padding.rawValue)
                    }
                }
            )

        case .room(let viewModel):
            SlotsView(
                .room(viewModel),
                headerBuilder: {
                    EmptyView() // У комнат нет заголовка
                },
                listBuilder: {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.items) { item in
                                Self.build(for: item)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, Constants.headerViewSpacing.rawValue)
                            }
                        }
                        .padding([.leading, .trailing], Constants.padding.rawValue)
                    }
                }
            )
        }
    }

    @ViewBuilder
    static func build(for item: SlotsItem) -> some View {
        switch item {
        case .room(let item):
            CardView(item: RoomCardView(room: item))
        case .task(let item):
            CardView(item: TaskCardView(task: item))
        }
    }
}
