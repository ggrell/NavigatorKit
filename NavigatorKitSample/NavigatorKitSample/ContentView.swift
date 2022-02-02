/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI
import NavigatorKit

struct ContentView: View {

    var body: some View {
        DemoNavigation()
//        NavigationView {
//            List(0..<10) { index in
//                NavigationLink {
//                    Text("This is navigation to item \(index)")
//                        .padding()
//
//                    NavigationLink {
//                        Text("This is also navigation")
//                    } label: {
//                        Text("Click me")
//                    }
//                } label: {
//                    Text("Click me for item \(index)")
//                }
//                    .padding()
//                    .frame(alignment: .leading)
//            }
//
//            VStack {
//                Text("Second column")
//            }
//        }
//        .navigationViewStyle(.columns)
    }
}

struct DemoNavigation: View {
    let navigator = Navigator()

    var body: some View {
        NavHost(navigator: navigator, startDestination: "green") {
            StackScreen(
                route: "green",
                destinations: ["yellow", "modal_yellow"]
            ) {
                GreenScreen()
            }

//            ColumnScreen(
//                route: "green_columns",
//                destinations: ["yellow", "modal_yellow"]
//            ) {
//                GreenScreen()
//                YellowScreen()
//            }

            ModalSheet(
                route: "modal_green",
                destinations: ["yellow", "modal_yellow"]
            ) {
                GreenScreen(isModal: true)
            }

            StackScreen(
                route: "yellow",
                destinations: ["gray", "modal_gray"]
            ) {
                YellowScreen()
            }

            ModalSheet(
                route: "modal_yellow",
                destinations: ["gray", "modal_gray"]
            ) {
                YellowScreen(isModal: true)
            }

            StackScreen(
                route: "gray",
                destinations: ["green", "modal_green"]
            ) {
                GrayScreen()
            }

            ModalSheet(
                route: "modal_gray",
                destinations: ["green", "modal_green"]
            ) {
                GrayScreen(isModal: true)
            }
        }
    }
}

struct GreenScreen: View {
    var isModal = false
    @EnvironmentObject private var navigator: Navigator
    @State private var returnedText: String? = nil

    var body: some View {
        VStack {
            ScrollView {
                Text("Push Yellow")
                    .padding()
                    .onTapGesture {
                        navigator.navigate(destination: "yellow")
                    }
                Text("Present Yellow")
                    .padding()
                    .onTapGesture {
                        navigator.navigate(destination: "modal_yellow") { args in
                            if let yellowText = args["text"] as? String {
                                returnedText = yellowText
                            }
                        }
                    }

                if let actualText = returnedText {
                    Text("Returned text from modal Yellow:\n\(actualText)")
                        .padding()
                }
            }
        }
        .navigationTitle("Green screen")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green, alignment: .center)
        .ignoresSafeArea(.container, edges: [.bottom])
    }
}

struct YellowScreen: View {
    var isModal = false
    @EnvironmentObject var navigator: Navigator
    @State private var textToPassBack: String = ""
    @State private var returnedText: String? = nil

    var body: some View {
        VStack(alignment: .center) {
            Text("Push Gray")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "gray")
                }
            Text("Present Gray")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "modal_gray") { args in
                        if let grayText = args["text"] as? String {
                            returnedText = grayText
                        }
                    }
                }

            if let actualText = returnedText {
                Text("Returned text from modal Gray:\n\(actualText)")
                    .padding()
            }

            TextField("Text to return on dismiss", text: $textToPassBack)
                .padding()
        }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.dismiss(to: .previous(args: ["text": textToPassBack]))
                    }, label: {
                        Text(isModal ? "Dismiss" : "Pop")
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Yellow Screen")
            .background(Color.yellow, alignment: .center)
            .ignoresSafeArea(.container, edges: [.bottom])
    }
}

struct GrayScreen: View {
    var isModal = false
    @EnvironmentObject var navigator: Navigator
    @State private var textToPassBack: String = ""

    var body: some View {
        VStack {
            Text("Push Green")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "green")
                }

            TextField("Text to return on dismiss", text: $textToPassBack)
                .padding()
        }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.dismiss(to: .root)
                    }, label: {
                        Text("Root")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.dismiss(to: .previous(args: ["text": textToPassBack]))
                    }, label: {
                        Text(isModal ? "Dismiss" : "Pop")
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Gray screen")
            .background(Color.gray, alignment: .center)
            .ignoresSafeArea(.container, edges: [.bottom])
    }
}
