/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

public struct StackScreen: NavDestination {
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
