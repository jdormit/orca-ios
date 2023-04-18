//
//  OrcaSimulation.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/11/23.
//

import Foundation
import Orca_Private.Simulation

public class OrcaSimulation: ObservableObject {
    var field: OrcaField
    var markBuffer: OrcaMarkBuffer
    var eventList: OrcaEventList
    var tickNumber = 0
    var randomSeed = 0

    public var height: Int {
        field.height
    }

    public var width: Int {
        field.width
    }

    public init(height: Int, width: Int) {
        field = OrcaField(height: height, width: width, fillGlyph: Int8(Character(".").asciiValue!))
        markBuffer = OrcaMarkBuffer(height: field.height, width: field.width)
        eventList = OrcaEventList()
    }

    public func getGlyph(row: Int, col: Int) -> Character {
        field.getGlyph(row: row, col: col)
    }

    public func setGlyph(glyph: Character, row: Int, col: Int) {
        field.setGlyph(glyph: glyph, row: row, col: col)
        self.publishChangeToMainThread()
    }

    public func simulateFrame() {
        markBuffer.clear(height: field.height, width: field.width)
        eventList.clear()
        orca_run(field.buffer, markBuffer.buffer, field.height, field.width, tickNumber, eventList.pointer, randomSeed)
        tickNumber += 1
        self.publishChangeToMainThread()
    }

    private func publishChangeToMainThread() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

