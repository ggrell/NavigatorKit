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

    var body: some View {
        VStack {
            ScrollView {
                Text("Push a view")
                    .padding()
                    .onTapGesture {
                        navigator.navigate(destination: "yellow")
                    }
                Text("Present a view")
                    .padding()
                    .onTapGesture {
                        navigator.navigate(destination: "modal_yellow")
                    }

//                ForEach(0..<50) { index in
//                    Text("Item \(index)")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
//                }
            }
        }
        .navigationTitle("Green screen")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    }
}

struct YellowScreen: View {
    var isModal = false
    @EnvironmentObject var navigator: Navigator

    var body: some View {
        VStack {
            Text("Push a view")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "gray")
                }
            Text("Present a view")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "modal_gray")
                }
        }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.dismiss()
                    }, label: {
                        Text(isModal ? "Dismiss" : "Pop")
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Yellow Screen")
            .background(.yellow)
    }
}

struct GrayScreen: View {
    var isModal = false
    @EnvironmentObject var navigator: Navigator

    var body: some View {
        VStack {
            Text("Push a view")
                .padding()
                .onTapGesture {
                    navigator.navigate(destination: "green")
                }
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
                        navigator.dismiss()
                    }, label: {
                        Text(isModal ? "Dismiss" : "Pop")
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Gray screen")
            .background(.gray)
    }
}
