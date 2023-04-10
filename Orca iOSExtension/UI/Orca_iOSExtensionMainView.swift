//
//  Orca_iOSExtensionMainView.swift
//  Orca iOSExtension
//
//  Created by Jeremy Dormitzer on 4/10/23.
//

import SwiftUI

struct Orca_iOSExtensionMainView: View {
    var parameterTree: ObservableAUParameterGroup
    
    var body: some View {
        VStack {
            ParameterSlider(param: parameterTree.global.midiNoteNumber)
                .padding()
            MomentaryButton(
                "Play note",
                param: parameterTree.global.sendNote
            )
        }
    }
}
