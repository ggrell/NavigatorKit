/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import SwiftUI

public typealias NavigationArgs = [String: Any?]

struct StackElement: CustomDebugStringConvertible {
    let id: String
    var links: [String: Binding<Bool>] = [:]
    var args: [String: NavigationArgs] = [:]
    var completion: ((NavigationArgs) -> Void)? = nil

    var debugDescription: String {
        "StackElement(id: \(id), links: \(links.map { "(id: \($0.key), active: \($0.value.wrappedValue))" })"
    }
}

public enum DismissDestination {
    /// Navigate to the previous screen
    /// - Parameter args: Optional set of `NavigationArgs` to pass to the previous screen
    case previous(args: NavigationArgs? = nil)

    /// Navigate back to a screen already in the stack but not necessarily the previous one
    case screen(route: String)

    /// Navigate back to the root screen
    case root
}

/// Handles all the destinations and the current state for a [NavigationWrapper]
public class Navigator: ObservableObject {
    var rootDestination: NavDestination!
    var destinations = [String: NavDestination]()

    var stack = [StackElement]()

    public init() {}
    
    /// Navigate to the destination with the given `id`. Can optionally provide `args` to pass to the destination.
    /// - Parameters:
    ///   - destination: the id of the destination to navigate to
    ///   - args: the optional arguments to pass to the destination
    ///   - completion: called if the navigated screen attempts to return a set of `NavigationArgs`. Defaults to `nil` if not passed.
    public func navigate(
        destination: String, args: NavigationArgs = .init(), completion: ((NavigationArgs) -> Void)? = nil
    ) {
        print("------------\nNavigator(\(rootDestination.route)) - Navigate to: \(destination), args: \(args)")
        guard !stack.isEmpty else {
            print("stack is empty, cannot navigate")
            return
        }
        guard let lastDestination = stack.last, lastDestination.links.keys.contains(destination) else {
            print("Destination \"\(stack.last?.id ?? "Unknown")\" hasn't registered destination \"\(destination)\"")
            return
        }

        stack[stack.count - 1].links[destination]?.wrappedValue = true
        stack[stack.count - 1].args[destination] = args
        stack[stack.count - 1].completion = completion
        print("STACK (\(rootDestination.route)): \(stack)")
    }

    /// Dismiss the current destination on the stack (like going back to the previous screen)
    public func dismiss(to destination: DismissDestination = .previous()) {
        print("Navigator(\(rootDestination.route)) - dismiss to: \(destination)")
        guard stack.count >= 2 else {
            print("There's nothing to dismiss")
            return
        }

        switch destination {
        case .previous(let args):
            stack[stack.count - 2].links.forEach { $0.value.wrappedValue = false }
            if let navArgs = args {
                if let completion = stack[stack.count - 2].completion {
                    completion(navArgs)
                } else {
                    print("args passed on dismissing screen, but previous screen didn't set a completion closure")
                }
            }

        case .screen(let id):
            if let lastIndex = stack.lastIndex(where: { $0.id == id }) {
                for index in (lastIndex..<stack.count).reversed() {
                    pop(id: stack[index].id)
                }
            }

        case .root:
            for index in (0..<stack.count).reversed() {
                pop(id: stack[index].id)
            }
        }
        print("STACK (\(rootDestination.route)): \(stack)")
    }

    func getNavigationArgs(id: String) -> NavigationArgs {
        guard stack.count > 0 else { return .init() }
        return stack[stack.count - 1].args[id] ?? .init()
    }

    func linkAppeared(id: String, isActive: Binding<Bool>) {
        print("Navigator(\(rootDestination.route)) - NavLink Appeared: \(id)")
        stack[stack.count - 1].links[id] = isActive
        print("STACK (\(rootDestination.route)): \(stack)")
    }

    func linkDisappeared(id: String) {
        print("Navigator(\(rootDestination.route)) - NavLink Disappeared: \(id)")
    }

    func destinationAppeared(id: String) {
        print("Navigator(\(rootDestination.route)) - NavDestination Appeared: \(id)")
        if stack.last?.id != id {
            stack.append(StackElement(id: id))
            print("STACK (\(rootDestination.route)): \(stack)")
        }
    }

    func destinationDisappeared(id: String) {
        print("Navigator(\(rootDestination.route)) - NavDestination Disappeared: \(id)")
    }

    func pop(id: String) {
        print("Navigator(\(rootDestination.route)) - pop: \(id) from: \(stack)")
        if let lastIndex = stack.lastIndex(where: { $0.id == id }) {
            for index in (lastIndex..<stack.count).reversed() {
                stack[index].links.forEach { $0.value.wrappedValue = false }
            }
            stack = Array(stack.dropLast(stack.count - lastIndex))
        }
        print("STACK (\(rootDestination.route)): \(stack)")
    }

    func complete(id: String) {
        if let lastIndex = stack.lastIndex(where: { $0.id == id }) {
            stack[stack.count - lastIndex].completion?([:])
        }
    }

    func filterStackNavigation(destinationIds: [String]) -> [String] {
        destinationIds.filter { destinations[$0] is StackScreen }
    }

    func filterModalNavigation(destinationIds: [String]) -> [String] {
        destinationIds.filter { destinations[$0] is ModalSheet }
    }

    func setDestinations(_ rootId: String, _ destinations: [NavDestination]) {
        self.destinations = Dictionary(uniqueKeysWithValues: destinations.map { ($0.route, $0) })
        guard let screen = destinations.first(where: { $0.route == rootId }) else { return }
        rootDestination = screen
    }
}
