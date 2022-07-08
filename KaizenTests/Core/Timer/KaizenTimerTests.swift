//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class TimerTestController: UIViewController, KaizenTimerDelegate {
    func didUpdateTimer() {}
}

class KaizenTimerTests: XCTestCase {
    
    func testTimer() {
        _ = KaizenTimer.shared
        XCTAssertNotNil(KaizenTimer.shared.getTimer())
        
        KaizenTimer.shared.stopTimer()
        XCTAssertNil(KaizenTimer.shared.getTimer())
    }
    
    func testDelegates() {
        let countOfDelegates = KaizenTimer.shared.getDelegatesCount()
        
        let controller = TimerTestController()
        KaizenTimer.shared.addDelegate(controller)
        
        let controller2 = TimerTestController()
        KaizenTimer.shared.addDelegate(controller2)
        
        XCTAssertEqual(KaizenTimer.shared.getDelegatesCount(), countOfDelegates + 2)
    }
    
}
