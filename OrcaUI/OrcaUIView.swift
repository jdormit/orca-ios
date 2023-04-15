//
//  OrcaUIView.swift
//  OrcaUI
//
//  Created by Jeremy Dormitzer on 4/14/23.
//
import Foundation
import SwiftUI
import Orca

typealias Coordinate = (Int, Int)

public struct OrcaUIView: View {
    @State var simulation: OrcaSimulation
    @State var currentPosition: Coordinate = (0, 0)
    @State var hiddenTextInput: String = ""
    @FocusState var hiddenInputFocused: Bool

    public init(simulation: OrcaSimulation) {
        self.simulation = simulation
    }
    
    public var body: some View {
        let textBinding: Binding<String> = Binding(get: {
            hiddenTextInput
        }, set: { input in
            if !input.isEmpty {
                let lastChar = input[input.index(before: input.endIndex)]
                simulation.setGlyph(glyph: lastChar, row: currentPosition.1, col: currentPosition.0)
                hiddenTextInput = String(lastChar)
            }
        })
        VStack() {
            VStack() {
                ForEach(0..<simulation.height, id: \.self) { row in
                    HStack() {
                        ForEach(0..<simulation.width, id: \.self) { col in
                            let isCurrentPos = (col, row) == currentPosition
                            let glyph = simulation.getGlyph(row: row, col: col)
                            let text = glyph == "." && isCurrentPos ? "@" : String(glyph)
                            Text(text)
                                .background(isCurrentPos ? .yellow : .white)
                                .monospaced()
                                .onTapGesture {
                                    currentPosition = (col, row)
                                }
                        }
                    }
                }
            }
            .padding()
            Spacer()
            HStack() {
                Spacer()
                Button(action: { hiddenInputFocused.toggle() }) {
                    Image(systemName: "keyboard").font(.largeTitle)
                }
                .padding()
            }
            TextField("", text: textBinding)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .opacity(0)
                .focused($hiddenInputFocused)
        }
    }
}
