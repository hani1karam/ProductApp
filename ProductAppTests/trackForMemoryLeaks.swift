//
//  trackForMemoryLeaks.swift
//  ProductAppTests
//
//  Created by Mac on 09/06/2022.
//

import XCTest
extension XCTestCase {
    func trackForMemoryLeaks(instance: AnyObject,file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance ] in
            XCTAssertNil(instance ,"Instance should have been deallcated. potential memory leak ", file: file,line: line)
        }
    }
}
