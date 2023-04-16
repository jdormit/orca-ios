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
    @ObservedObject var simulation: OrcaSimulation
    @State var currentPosition: Coordinate
    @FocusState var hiddenInputFocused: Bool

    public init(simulation: OrcaSimulation) {
        self.simulation = simulation
        currentPosition = (simulation.width / 2, simulation.height / 2)
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        let textBinding: Binding<String> = Binding(get: {""}, set: { input in
            if !input.isEmpty {
                let lastChar = input[input.index(before: input.endIndex)]
                simulation.setGlyph(glyph: lastChar, row: currentPosition.1, col: currentPosition.0)
            }
        })
        ZStack {
            TextField("", text: textBinding)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .opacity(0)
                .focused($hiddenInputFocused)
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
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
            }
            .padding()
            .ignoresSafeArea(.keyboard)
            VStack() {
                Spacer()
                HStack() {
                    Spacer()
                    Button(action: { hiddenInputFocused.toggle() }) {
                        Image(systemName: hiddenInputFocused ? "keyboard.chevron.compact.down" : "keyboard")
                            .font(.largeTitle)
                            .background(Color.white)
                    }
                    .padding(30)
                }
            }
        }
    }
}
