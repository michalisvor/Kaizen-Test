//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

protocol KaizenTimerDelegate: AnyObject {
    func didUpdateTimer()
}

final class KaizenTimer {
    static let shared: KaizenTimer = KaizenTimer()
        
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    private var timer: Timer?
    
    private init() {
        addTimer()
    }
    
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer),
                                     userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
        
        // I add Timer to a run loop so when the user scrolls but hold his finger in the screen the timer shouldn't stop
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func addDelegate(_ target: KaizenTimerDelegate) {
        delegates.add(target)
    }
    
    private func getAllDelegates() -> [KaizenTimerDelegate] {
        return delegates.allObjects.compactMap({ $0 as? KaizenTimerDelegate })
    }
    
    @objc private func updateTimer() {
        getAllDelegates().forEach { $0.didUpdateTimer() }
    }
}
