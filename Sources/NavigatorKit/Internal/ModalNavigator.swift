/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

struct ModalNavigator: View {
    let destinationId: String

    @State var isPresented = false

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        let _ = print("**** Computing ModalOverlay (\(destinationId)) - isPresented: \(isPresented)")
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }

        if let screen = navigator.destinations[destinationId] {
            let destinationView = NavigationScreenWrapper(screen: screen)
            // Needed a view to attach the .fullScreenCover to that has no UI but appears and disappears
            NavigationLink(isActive: .constant(false), destination: { EmptyView() }, label: { EmptyView() })
                .sheet(isPresented: $isPresented, onDismiss: { navigator.linkDisappeared(id: destinationId) }) {
                    NavigationView {
                        destinationView
                    }
                    .navigationViewStyle(.stack)
                    .presentationDetents(destinationView.screen.presentationDetents)
                    .presentationDragIndicator(destinationView.screen.presentationDragIndicator)
                }
                .onAppear {
                    navigator.linkAppeared(id: destinationId, isActive: $isPresented)
                }
                .onDisappear {
                    navigator.linkDisappeared(id: destinationId)
                }
                .onChange(of: isPresented) { active in
                    guard !active else { return }
                    // NavigationLink became inactive, so notify navigator to pop this view and anything after it
                    if destinationView.screen.completeOnDismiss {
                        navigator.complete(id: destinationId)
                    }
                    navigator.pop(id: destinationId)
                }
        }
    }
}

