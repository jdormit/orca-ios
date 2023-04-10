//
//  Orca_iOSApp.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/10/23.
//

import CoreMIDI
import SwiftUI

@main
class Orca_iOSApp: App {
    @ObservedObject private var hostModel = AudioUnitHostModel()

    required init() {}

    var body: some Scene {
        WindowGroup {
            ContentView(hostModel: hostModel)
        }
    }
}
