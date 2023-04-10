//
//  Orca_iOSExtensionParameterAddresses.h
//  Orca iOSExtension
//
//  Created by Jeremy Dormitzer on 4/10/23.
//

#pragma once

#include <AudioToolbox/AUParameters.h>

#ifdef __cplusplus
namespace Orca_iOSExtensionParameterAddress {
#endif

typedef NS_ENUM(AUParameterAddress, Orca_iOSExtensionParameterAddress) {
    sendNote = 0,
    midiNoteNumber = 1
};

#ifdef __cplusplus
}
#endif
