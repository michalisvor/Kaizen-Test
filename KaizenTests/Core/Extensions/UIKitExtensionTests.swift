//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class UIViewControllerExtensionTests: XCTestCase {
     
    func testNameOfController() {
        let splashController = SplashViewController.id
        
        XCTAssertEqual(splashController, "SplashViewController")
    }
    
    func testHideLoadingView() {
        let splashController = SplashViewController.instance()
        
        splashController.showLoadingView()
        XCTAssertTrue(splashController.view.subviews.contains(where: { $0 is UIActivityIndicatorView }) )

        splashController.hideLoadingView()
        XCTAssertTrue(!splashController.view.subviews.contains(where: { $0 is UIActivityIndicatorView }) )
    }
    
    func testPrepareNavigationTitle() {
        let splashController = SplashViewController.instance()
        
        splashController.prepareNavigationTitle("Title")
        
        let titleView = splashController.navigationItem.titleView as? UILabel
        XCTAssertNotNil(titleView)
        
        XCTAssertEqual(titleView?.text, "Title")
    }
    
    func testEmptyPrepareNavigationTitle() {
        let splashController = SplashViewController.instance()
        
        splashController.prepareNavigationTitle("")
        
        let titleView = splashController.navigationItem.titleView as? UILabel
        XCTAssertNotNil(titleView)
        
        XCTAssertEqual(titleView?.text, "")
    }
    
    func testNilPrepareNavigationTitle() {
        let splashController = SplashViewController.instance()
        
        splashController.prepareNavigationTitle()
        
        let titleView = splashController.navigationItem.titleView as? UILabel
        XCTAssertNil(titleView)
        
        XCTAssertEqual(titleView?.text, nil)
    }
}

// MARK: CollectionView + TableView Tests

class UICollectionViewTableViewExtensionTests: XCTestCase {

    func testNameOfCollectionViewCell() {
        let splashController = SportEventCollectionViewCell.id
        
        XCTAssertEqual(splashController, "SportEventCollectionViewCell")
    }
    
    func testNameOfTableViewCell() {
        let splashController = CollectionViewTableViewCell.id
        
        XCTAssertEqual(splashController, "CollectionViewTableViewCell")
    }
    
}
