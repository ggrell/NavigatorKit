/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

public protocol NavDestination {
    var route: String { get }
    var destinations: [String] { get }
    var content: (NavigationArgs) -> AnyView { get }
    var presentationDetents: Set<PresentationDetent> { get }
    var presentationDragIndicator: Visibility { get }
    var completeOnDismiss: Bool { get }
}

extension NavDestination {
    public var presentationDetents: Set<PresentationDetent> { [] }
    public var presentationDragIndicator: Visibility { .hidden }
    public var completeOnDismiss: Bool { false }
}
