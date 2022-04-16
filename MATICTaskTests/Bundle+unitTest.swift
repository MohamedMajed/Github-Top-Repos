//
//  Bundle+unitTest.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 16/04/2022.
//

import Foundation

extension Bundle {
    static var unitTest: Bundle {
        return Bundle(for: APISeviceTests.self)
    }
}
