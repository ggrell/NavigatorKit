import SwiftUI

public protocol NavDestination {
    var route: String { get }
    var destinations: [String] { get }
    var content: (NavigationArgs) -> AnyView { get }
}
