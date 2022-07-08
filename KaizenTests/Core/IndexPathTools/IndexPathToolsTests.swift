//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class IndexPathToolsTests: XCTestCase {
    
    var dataModel: IndexPathDataModel!
    
    override func setUp() {
        dataModel = IndexPathDataModel()
    }
    
    func testInitialisation() {
        let item = IndexPathItem(cellIdentifier: "cellId")
        let sectionItem = IndexPathSectionItem(identifier: "section")
        
        XCTAssertEqual(item.cellIdentifier, "cellId")
        XCTAssertEqual(item.nibName, "cellId")
        XCTAssertEqual(item.rowHeight, UITableView.automaticDimension)
        XCTAssertEqual(item.section, nil)
        XCTAssertNil(item.data)
        
        XCTAssertEqual(sectionItem.identifier, "section")
        XCTAssertEqual(sectionItem.isOpened, true)
    }
    
    func testInitialisationUniqueCellIdentifiers() {
        let item = IndexPathItem(cellIdentifier: "cellId", nibName: "some")
        
        XCTAssertEqual(item.cellIdentifier, "cellId")
        XCTAssertEqual(item.nibName, "some")
        XCTAssertEqual(item.rowHeight, UITableView.automaticDimension)
        XCTAssertEqual(item.section, nil)
        XCTAssertNil(item.data)
    }
    
    func testInitialisationIndexPathDataModel() {
        let dataModel = IndexPathDataModel(items: [])
        
        XCTAssertEqual(dataModel.items().count, 0)
        XCTAssertEqual(dataModel.sectionItems.count, 1)
    }
    
    func testInitialisationIndexPathDataModelWithSectionItems() {
        let dataModel = IndexPathDataModel(sectionItems: [])
        
        XCTAssertEqual(dataModel.items().count, 0)
        XCTAssertEqual(dataModel.sectionItems.count, 0)
    }
    
    func testAddItemsInDataModel() {
        let item = IndexPathItem(cellIdentifier: "cellId")

        let dataModel = IndexPathDataModel(items: [item])

        XCTAssertEqual(dataModel.items().count, 1)
        XCTAssertEqual(dataModel.sectionItems.count, 1)
    }
    
    func testAddSectionItemsInDataModel() {
        let item = IndexPathItem(cellIdentifier: "cellId")
        let sectionItem = IndexPathSectionItem(identifier: "section", children: [item, item])

        let dataModel = IndexPathDataModel(sectionItems: [sectionItem, sectionItem])

        XCTAssertEqual(dataModel.items().count, 4)
        XCTAssertEqual(dataModel.sectionItems.count, 2)
        XCTAssertEqual(dataModel.sectionItems.first?.children.count, 2)
    }
    
    func testEqualSignForIndexPathItem() {
        let item = IndexPathItem(cellIdentifier: "cellId")
        let item2 = IndexPathItem(cellIdentifier: "cellId2")

        XCTAssertTrue(item == item2)
        
        let item3 = IndexPathItem(cellIdentifier: "cellId", rowHeight: 10)
        let item4 = IndexPathItem(cellIdentifier: "cellId2", rowHeight: 5)

        XCTAssertTrue(item3 == item4)
    }
    
    func testEqualSignForIndexPathSectionItem() {
        let item = IndexPathSectionItem(identifier: "sectionId")
        let item2 = IndexPathSectionItem(identifier: "sectionId")

        XCTAssertTrue(item == item2)
        
        let item3 = IndexPathSectionItem(identifier: "sectionId")
        let item4 = IndexPathSectionItem(identifier: "sectionId2")

        XCTAssertTrue(item3 != item4)
    }
    
    func testClearAllSections() {
        let item = IndexPathItem(cellIdentifier: "cellId")
        let sectionItem = IndexPathSectionItem(identifier: "section", children: [item, item])

        let dataModel = IndexPathDataModel(sectionItems: [sectionItem, sectionItem])

        dataModel.clearAll()
        XCTAssertEqual(dataModel.items().count, 0)
    }
    
    func testNumberOfSections() {
        let item = IndexPathItem(cellIdentifier: "cellId")
        let sectionItem = IndexPathSectionItem(identifier: "section", children: [item, item, item])
        let sectionItem2 = IndexPathSectionItem(identifier: "section2", children: [item, item])

        let dataModel = IndexPathDataModel(sectionItems: [sectionItem, sectionItem2])

        let numberOfSections = dataModel.numberOfSections
        let numberOfRowsInSection1 = dataModel.numberOfRows(inSection: 0)
        let numberOfRowsInSection2 = dataModel.numberOfRows(inSection: 1)

        XCTAssertEqual(numberOfSections, 2)
        XCTAssertEqual(numberOfRowsInSection1, 3)
        XCTAssertEqual(numberOfRowsInSection2, 2)
    }

}
