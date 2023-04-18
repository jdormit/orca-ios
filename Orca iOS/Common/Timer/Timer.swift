//
//  Timer.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/16/23.
//

import Foundation

public class RepeatingTimer {
    var ticksPerMinute: Double
    let timer: DispatchSourceTimer
    let queue: DispatchQueue
    let callback: () -> Void
    private var lastTickTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()

    init(ticksPerMinute: Double, callback: @escaping () -> Void) {
        self.ticksPerMinute = ticksPerMinute
        self.callback = callback
        queue = DispatchQueue(label: "BPMTimer", qos: .userInitiated)
        timer = DispatchSource.makeTimerSource(flags: [.strict])
        timer.activate()
        timer.schedule(deadline: .now(), repeating: .milliseconds(scheduleIntervalMillis()))
        timer.setEventHandler {
            self.handleTimerEvent()
        }
    }

    private func scheduleIntervalMillis() -> Int {
        let ticksPerSecond = ticksPerMinute / 60
        let millisPerTick = 1000 / ticksPerSecond
        return Int((millisPerTick / 50).rounded())
    }

    private func handleTimerEvent() {
        let elapsedTime = CFAbsoluteTimeGetCurrent() - lastTickTime
        let targetTime = 60 / ticksPerMinute
        if (elapsedTime > targetTime) || abs(elapsedTime - targetTime) < 0.003 {
            lastTickTime = CFAbsoluteTimeGetCurrent()
            callback()
        }
    }
}
