//
//  Social_RealityTests.swift
//  Social-RealityTests
//
//  Created by Nick Crews on 2/26/21.
//

import XCTest
@testable import Social_Reality

class Social_RealityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testReadMethods() throws {
        
        Query.get.user(id: "") { res in
            XCTAssert(res == nil)
        }
        
        Query.get.creation(id: "") { res in
            XCTAssert(res == nil)
        }
        
        Query.get.comment(id: "") { res in
            XCTAssert(res == nil)
        }
        
        Query.get.like(id: "") { res in
            XCTAssert(res == nil)
        }
        
        Query.get.message(conversationID: "", id: "") { res in
            XCTAssert(res == nil)
        }
        
        Query.get.conversation(id: "") { res in
            XCTAssert(res == nil)
        }
            
    }
    
    func testUpdateMethods() throws {
        
        Query.update.user(id: "", data: ["":""]) { res in
            XCTAssert(res == .error)
        }
            
    }
    

}
