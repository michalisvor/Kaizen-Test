//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class IndexPathSectionItem {
    
    var identifier: String
    var rowHeight: CGFloat
    var data: Any?
    var children: [IndexPathItem]
    var isOpened: Bool
    
    init(identifier: String, rowHeight: CGFloat = 0.0, data: Any? = nil, children: [IndexPathItem] = [], isOpened: Bool = true) {
        self.identifier = identifier
        self.rowHeight = rowHeight
        self.data = data
        self.children = children
        self.isOpened = isOpened
    }
}

class IndexPathItem {
    
    internal var section: IndexPathSectionItem?
    var identifier: String
    var cellIdentifier: String
    var nibName: String
    var rowHeight: CGFloat
    var data: Any?
    
    init(cellIdentifier: String, nibName: String? = nil, rowHeight: CGFloat = UITableView.automaticDimension, section: IndexPathSectionItem? = nil, data: Any? = nil) {
        self.identifier = ""
        self.cellIdentifier = cellIdentifier
        self.rowHeight = rowHeight
        self.section = section
        self.data = data
        if let itemNibName = nibName {
            self.nibName = itemNibName
        } else {
            self.nibName = cellIdentifier
        }
    }
}

class IndexPathDataModel {
    
    private let IndexPathItemNilSectionIdentifier = "IndexPathItemNilSectionNameIdentifier"
    var sectionItems = [IndexPathSectionItem]()
    lazy var numberOfSections = { return self.sectionItems.count }()
    
    convenience init() {
        self.init(items: [])
    }
    
    /// Initializes an IndexPathDataModel with IndexPathSectionItems. Each section item can have IndexPathItems as its children.
    /// Each child must have section = nil in its parameter to avoid retain cycles
    ///
    /// - Parameters:
    ///   - sectionItems: The IndexPathSectionItems we need
    init(sectionItems: [IndexPathSectionItem]) {
        for (index, item) in sectionItems.enumerated() {
            item.identifier = "\(index)"
        }
        self.sectionItems = sectionItems
    }
    
    /// Initializes an IndexPathDataModel with one default IndexPathSectionItem. All items are included as children of that section.
    /// Each item must have section = nil in its parameter
    ///
    /// - Parameters:
    ///   - itemsArray: The IndexPathItems we need
    init(itemsForSingleSection itemsArray: [IndexPathItem]) {
        let nilSection = IndexPathSectionItem(identifier: IndexPathItemNilSectionIdentifier, rowHeight: 0, data: nil, children: [])
        nilSection.children.append(contentsOf: itemsArray)
        self.sectionItems = [nilSection]
    }
    
    /// Initializes an IndexPathDataModel with an array of IndexPathItems. All items are included as children of that section.
    /// IndexPathSectionItems are created and the items are grouped into children of each SectionItem
    ///
    /// - Parameters:
    ///   - itemsArray: The IndexPathItems we need
    init(items: [IndexPathItem]) {
        for (index, item) in items.enumerated() {
            item.identifier = "\(index)"
        }
        self.sectionItems = groupedItemsToSections(items: items)
    }
    
    private func groupedItemsToSections(items: [IndexPathItem]) -> [IndexPathSectionItem] {
        let nilSection = IndexPathSectionItem(identifier: IndexPathItemNilSectionIdentifier, rowHeight: 0, data: nil, children: [])
        var allSectionsArray = [nilSection]
        for item in items {
            if let sectionItem = item.section {
                if let index = sectionItemExistsAtIndex(sectionItem: sectionItem, array: allSectionsArray) {
                    allSectionsArray[index].children.append(item)
                } else {
                    sectionItem.children.removeAll()
                    let newSection = sectionItem
                    newSection.children.append(item)
                    allSectionsArray.append(newSection)
                }
            } else {
                nilSection.children.append(item)
            }
        }
        
        if nilSection.children.isEmpty && allSectionsArray.count > 1 {
            allSectionsArray.removeFirst()
        }
        
        return allSectionsArray
    }
    
    private func sectionItemExistsAtIndex(sectionItem: IndexPathSectionItem, array: [IndexPathSectionItem]) -> Int? {
        for (index, item) in array.enumerated() where item == sectionItem {
            return index
        }
        return nil
    }
    
    func items() -> [IndexPathItem] {
        var arrayToReturn: [IndexPathItem] = []
        for item in sectionItems {
            arrayToReturn.append(contentsOf: item.children)
        }
        return arrayToReturn
    }
    
    func item(forIdentifier identifier: String) -> IndexPathItem? {
        var matchesFoundArray = [IndexPathItem]()
        for sectionItem in sectionItems {
            let results = sectionItem.children.filter { $0.identifier == identifier }
            matchesFoundArray.append(contentsOf: results)
        }
        if matchesFoundArray.count > 1 {
            return nil
        }
        return matchesFoundArray.first
    }
    
    func item(at indexPath: IndexPath) -> IndexPathItem? {
        let section = sectionItems[indexPath.section]
        return section.children[indexPath.row]
    }
    
    func items(forCellIdentifier cellIdentifier: String) -> [IndexPathItem] {
        var itemsToReturn = [IndexPathItem]()
        for sectionItem in sectionItems {
            let results = sectionItem.children.filter { $0.cellIdentifier == cellIdentifier }
            itemsToReturn.append(contentsOf: results)
        }
        return itemsToReturn
    }
    
    func items(forSection section: Int) -> [IndexPathItem] {
        return sectionItems[section].children
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sectionItems[section].children.count
    }
    
    func section(atSectionIndex sectionIndex: Int) -> IndexPathSectionItem {
        return sectionItems[sectionIndex]
    }
    
    func section(ofIndexPathItem item: IndexPathItem) -> Int {
        for i in 0..<sectionItems.count {
            for j in 0..<sectionItems[i].children.count {
                if item == sectionItems[i].children[j] {
                    return i
                }
            }
        }
        return 0
    }
    
    func indexOfItemInSection(ofIndexPathItem item: IndexPathItem) -> Int? {
        for i in 0..<sectionItems.count {
            for j in 0..<sectionItems[i].children.count {
                if item == sectionItems[i].children[j] {
                    return j
                }
            }
        }
        return nil
    }
    
    func indexPath(ofItem item: IndexPathItem) -> IndexPath? {
        for i in 0..<sectionItems.count {
            for j in 0..<sectionItems[i].children.count {
                if item == sectionItems[i].children[j] {
                    return IndexPath(row: j, section: i)
                }
            }
        }
        return nil
    }
    
    func removeDuplicateSections() {
        sectionItems = sectionItems.withoutDuplicates()
    }
    
    func clearAll() {
        self.sectionItems.removeAll()
        let nilSection = IndexPathSectionItem(identifier: IndexPathItemNilSectionIdentifier, rowHeight: 0, data: nil, children: [])
        self.sectionItems = [nilSection]
    }
    
    func lastChildIndex(of section: Int) -> Int {
        return sectionItems[section].children.count - 1
    }
}

extension IndexPathSectionItem: Equatable {
    static func == (lhs: IndexPathSectionItem, rhs: IndexPathSectionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
extension IndexPathItem: Equatable {
    static func == (lhs: IndexPathItem, rhs: IndexPathItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Array where Element: Equatable {
    
    func withoutDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}
