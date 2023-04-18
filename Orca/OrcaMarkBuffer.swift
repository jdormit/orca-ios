//
//  OrcaMarkBuffer.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/11/23.
//
// A wrapper around the Orca Mbuf_reusable struct

import Foundation
import Orca_Private.GlyphBuffer

class OrcaMarkBuffer {
    var mBuf: Mbuf_reusable

    var buffer: UnsafeMutablePointer<Mark> {
        mBuf.buffer!
    }

    init(height: Int, width: Int) {
        mBuf = Mbuf_reusable()
        mbuf_reusable_init(&mBuf)
        ensureSize(height: height, width: width)
    }

    deinit {
        mbuf_reusable_deinit(&mBuf)
    }

    func ensureSize(height: Int, width: Int) {
        mbuf_reusable_ensure_size(&mBuf, height, width)
    }

    func clear(height: Int, width: Int) {
        mbuffer_clear(mBuf.buffer, height, width)
    }
}
