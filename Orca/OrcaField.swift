//
//  OrcaField.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/11/23.
//
// A wrapper around the Orca Field struct

import Foundation
import Orca_Private.Field

class OrcaField {
    private var field: Field

    var height: Int {
        Int(field.height)
    }

    var width: Int {
        Int(field.width)
    }

    var buffer: UnsafeMutablePointer<Glyph> {
        field.buffer
    }

    init(height: Int, width: Int, fillGlyph: Int8) {
        field = Field()
        field_init_fill(&field, height, width, fillGlyph)
    }

    deinit {
        field_deinit(&field)
    }

    func getGlyph(row: Int, col: Int) -> Character {
        precondition(row < height && col < width, "Invalid coordinate: (\(col), \(row)")
        return OrcaField.glyphToCharacter(buffer[row * width + col])
    }

    func setGlyph(glyph: Character, row: Int, col: Int) {
        precondition(row < height && col < width, "Invalid coordinate: (\(col), \(row)")
        gbuffer_poke(buffer, height, width, row, col, OrcaField.characterToGlyph(glyph))
    }

    private static func glyphToCharacter(_ glyph: Int8) -> Character {
        Character(UnicodeScalar(UInt8(glyph)))
    }

    private static func characterToGlyph(_ char: Character) -> Int8 {
        Int8(char.asciiValue!)
    }
}
