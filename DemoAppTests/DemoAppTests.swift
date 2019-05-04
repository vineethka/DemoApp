//
//  DemoAppTests.swift
//  DemoAppTests
//
//  Created by Vineeth Aranvindan on 4/22/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import XCTest
@testable import DemoApp

class DemoAppTests: XCTestCase {

    var currentViewController:ViewController!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let aBundle = Bundle(for: ViewController.self)
        currentViewController = UIStoryboard(name: "Main", bundle: aBundle).instantiateViewController(withIdentifier: "ListView") as? ViewController
        let _ = currentViewController.view
        currentViewController.viewWillAppear(false)
        
    }
    func testView() {
        // Before loading the view, view should be nil.
        XCTAssertNotNil(currentViewController.view, "View shouldn't be nil")
    }
    
    func testOutletsAndActions() {
        XCTAssertNotNil(currentViewController.listTableView,"table is nil")
        XCTAssertNotNil(currentViewController.fetchingView,"fetching view is nil")
    }
    
    func testTableView() {
        //Testing if our view controller adheres to UITableView protocols.
        XCTAssertNotNil(currentViewController.listTableView.delegate,"Delegate is nil")
        XCTAssertNotNil(currentViewController.listTableView.dataSource,"DataSource is nil")
        
    }
    override func tearDown() {
        currentViewController = nil
        super.tearDown()
    }
}
