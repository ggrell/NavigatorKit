/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

@resultBuilder
public struct NavDestinationsBuilder {
    @inlinable
    public static func buildBlock(_ screens: NavDestination...) -> [NavDestination] {
        screens
    }
}
