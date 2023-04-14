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
    var simulation: OrcaSimulation
    @State var currentPosition: Coordinate = (0, 0)

    public init(simulation: OrcaSimulation) {
        self.simulation = simulation
    }
    
    public var body: some View {
        VStack() {
            ForEach(0..<simulation.height, id: \.self) { row in
                HStack() {
                    ForEach(0..<simulation.width, id: \.self) { col in
                        let text = (col, row) == currentPosition ? "@" : String(simulation.getGlyph(row: row, col: col))
                        Text(text)
                            .monospaced()
                            .onTapGesture {
                                currentPosition = (col, row)
                            }
                    }
                }
            }
        }
    }
}
