import SwiftUI

public struct ModalSheet: NavDestination {
    public let route: String
    public let destinations: [String]
    public let content: (NavigationArgs) -> AnyView

    public init<Content: View>(
        route: String,
        destinations: [String] = [],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.route = route
        self.destinations = destinations
        self.content = { _ in AnyView(content()) }
    }

    public init<Content: View>(
        route: String,
        destinations: [String] = [],
        @ViewBuilder _ contentWithArgs: @escaping (NavigationArgs) -> Content
    ) {
        self.route = route
        self.destinations = destinations
        self.content = { args in AnyView(contentWithArgs(args)) }
    }
}
