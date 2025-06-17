/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

public struct ModalSheet: NavDestination {
    public let route: String
    public let destinations: [String]
    public let content: (NavigationArgs) -> AnyView
    public var presentationDetents: Set<PresentationDetent>
    public var presentationDragIndicator: Visibility
    public var completeOnDismiss: Bool

    public init<Content: View>(
        route: String,
        destinations: [String] = [],
        presentationDetents : Set<PresentationDetent> = [],
        presentationDragIndicator : Visibility = .hidden,
        completeOnDismiss: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.route = route
        self.destinations = destinations
        self.presentationDetents = presentationDetents
        self.presentationDragIndicator = presentationDragIndicator
        self.completeOnDismiss = completeOnDismiss
        self.content = { _ in AnyView(content()) }
    }

    public init<Content: View>(
        route: String,
        destinations: [String] = [],
        presentationDetents : Set<PresentationDetent> = [],
        presentationDragIndicator : Visibility = .hidden,
        completeOnDismiss: Bool = false,
        @ViewBuilder _ contentWithArgs: @escaping (NavigationArgs) -> Content
    ) {
        self.route = route
        self.destinations = destinations
        self.presentationDetents = presentationDetents
        self.presentationDragIndicator = presentationDragIndicator
        self.completeOnDismiss = completeOnDismiss
        self.content = { args in AnyView(contentWithArgs(args)) }
    }
}
