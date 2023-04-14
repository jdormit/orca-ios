//
//  OrcaEvent.swift
//  Orca iOS
//
//  Created by Jeremy Dormitzer on 4/11/23.
//

import Foundation
import Orca_Private.Events

class OrcaEventList {
    private var eventList: Oevent_list
    var pointer: UnsafeMutablePointer<Oevent_list>

    init() {
        eventList = Oevent_list()
        oevent_list_init(&eventList)
        pointer = UnsafeMutablePointer<Oevent_list>(&eventList)
    }

    deinit {
        oevent_list_deinit(&eventList)
        pointer.deallocate()
    }

    func clear() {
        oevent_list_clear(&eventList)
    }
}
