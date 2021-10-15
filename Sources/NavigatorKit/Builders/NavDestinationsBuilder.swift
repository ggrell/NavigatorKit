import SwiftUI

@resultBuilder
public struct NavDestinationsBuilder {
    @inlinable
    public static func buildBlock(_ screens: NavDestination...) -> [NavDestination] {
        screens
    }
}
