//
//  AUGraphSineWave.h
//  Dice
//
//  Created by Timothy Shull on 7/8/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

#ifndef AUGraphSineWave_h
#define AUGraphSineWave_h

#include <AudioToolbox/AudioToolbox.h>

typedef struct CustomSineWavePlayer {
    AudioUnit outputUnit;
    double startingFrameCount;
} CustomSineWavePlayer;

OSStatus sineWaveRenderProc(void *inRefCon,
        AudioUnitRenderActionFlags *ioActionFlags,
        const AudioTimeStamp *inTimeStamp,
        UInt32 inBusNumber,
        UInt32 inNumberFrames,
        AudioBufferList *ioData);

static void checkError(OSStatus error, const char *operation);

void createAndConnectOutputUnit(CustomSineWavePlayer *player);

#endif /* AUGraphSineWave_h */
