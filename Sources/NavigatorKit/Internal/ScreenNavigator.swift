/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

struct ScreenNavigator: View {
    let destinationId: String

    @State var isActive = false

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        let _ = print("**** Computing ScreenNavigator (\(destinationId)) - isActive: \(isActive)")
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }

        if let screen = navigator.destinations[destinationId] {
            let destinationView = NavigationScreenWrapper(screen: screen)
            NavigationLink(
                isActive: $isActive,
                destination: { destinationView },
                label: { EmptyView() }
            )
            .onAppear {
                navigator.linkAppeared(id: destinationId, isActive: $isActive)
            }
            .onDisappear {
                navigator.linkDisappeared(id: destinationId)
            }
            .onChange(of: isActive) { active in
                guard !active else { return }
                // NavigationLink became inactive, so notify navigator to pop this view and anything after it
                navigator.pop(id: destinationId)
            }
        }
    }
}
