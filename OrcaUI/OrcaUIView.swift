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
    let font = UIFont.monospacedSystemFont(ofSize: 17, weight: .regular)
    let fontSize: CGFloat

    public init(simulation: OrcaSimulation) {
        self.simulation = simulation
        let attrStr = NSAttributedString(string: "@", attributes: [NSAttributedString.Key.font: font])
        fontSize = attrStr.size().width
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
                let cols: [GridItem] = (0..<simulation.width).map { _ in GridItem(.fixed(fontSize)) }
                LazyVGrid(columns: cols) {
                    ForEach(0..<(simulation.height * simulation.width), id: \.self) { rawIdx in
                        let col = rawIdx % simulation.width
                        let row = rawIdx / simulation.width
                        let isCurrentPos = (col, row) == currentPosition
                        let glyph = simulation.getGlyph(row: row, col: col)
                        let text = glyph == "." && isCurrentPos ? "@" : String(glyph)
                        Text(text)
                            .font(Font(font))
                            .background(isCurrentPos ? .yellow : .white)
                            .monospaced()
                            .onTapGesture {
                                currentPosition = (col, row)
                            }
                    }
                }
                .padding()
            }
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
