import SwiftUI

struct NavigationScreenWrapper: View {
    let screen: NavDestination

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        let args = navigator.getNavigationArgs(id: screen.route)
        let stackNavigationDestinations = navigator.filterStackNavigation(destinationIds: screen.destinations)
        let modalNavigationDestinations = navigator.filterModalNavigation(destinationIds: screen.destinations)
        VStack {
            screen.content(args)
            ForEach(stackNavigationDestinations, id: \.self) { destinationId in
                ScreenNavigator(destinationId: destinationId)
            }
            ForEach(modalNavigationDestinations, id: \.self) { destinationId in
                ModalNavigator(destinationId: destinationId)
            }
        }
        .onAppear {
            navigator.destinationAppeared(id: screen.route)
        }
        .onDisappear {
            navigator.destinationDisappeared(id: screen.route)
        }
    }
}
