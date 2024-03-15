/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

/// Top level host view for navigation
public struct NavHost: View {
    @StateObject private var navigator: Navigator

    public init(
        navigator: Navigator,
        startDestination: String,
        @NavDestinationsBuilder _ destinations: () -> [NavDestination]
    ) {
        self._navigator = StateObject(wrappedValue: navigator)
        navigator.setDestinations(startDestination, destinations())
    }

    public var body: some View {
        let _ = print("**** Computing Navigation Wrapper")
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }

        switch navigator.rootDestination {
        case is StackScreen:
            NavigationHostContent(navigator: navigator, screen: navigator.rootDestination)
                .navigationViewStyle(.stack)

//        case is ColumnScreen:
//            NavigationHostContent(navigator: navigator, screen: navigator.rootDestination)
//                .navigationViewStyle(.columns)

        default:
            NavigationHostContent(navigator: navigator, screen: navigator.rootDestination)
                .navigationViewStyle(.automatic)
        }
    }
}

struct NavigationHostContent: View {
    @StateObject var navigator: Navigator
    let screen: NavDestination

    var body: some View {
        NavigationView {
            NavigationScreenWrapper(screen: navigator.rootDestination)
        }
        .environmentObject(navigator)
    }
}

