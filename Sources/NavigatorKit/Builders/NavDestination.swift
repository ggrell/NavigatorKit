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
}

extension NavDestination {
    public var presentationDetents: Set<PresentationDetent> { [] }
}
