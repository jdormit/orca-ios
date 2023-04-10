//
//  Orca_iOSExtensionAudioUnit.h
//  Orca iOSExtension
//
//  Created by Jeremy Dormitzer on 4/10/23.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Orca_iOSExtensionAudioUnit : AUAudioUnit
- (void)setupParameterTree:(AUParameterTree *)parameterTree;
@end
