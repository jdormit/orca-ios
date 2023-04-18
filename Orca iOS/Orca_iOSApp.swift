//
//  Orca_iOSApp.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/10/23.
//

import CoreMIDI
import SwiftUI
import OrcaUI
import Orca

@main
class Orca_iOSApp: App {
    @ObservedObject private var hostModel = AudioUnitHostModel()
    let timer: RepeatingTimer
    let simulation: OrcaSimulation

    required init() {
        var bpm = 120.0
        let sim = OrcaSimulation(height: 60, width: 80)
        self.simulation = sim
        timer = RepeatingTimer(ticksPerMinute: bpm * 4) {
            sim.simulateFrame()
        }
    }

    var body: some Scene {
        WindowGroup {
//            ContentView(hostModel: hostModel)
            OrcaUIView(simulation: simulation)
        }
    }
}
