/*
 * Copyright (c) 2021, Gyuri Grell and NavigatorKit contributors. All rights reserved
 *
 * Licensed under BSD 3-Clause License.
 * https://opensource.org/licenses/BSD-3-Clause
 */

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NavigatorKitTests.allTests),
    ]
}
#endif
