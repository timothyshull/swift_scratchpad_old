#include "AUGraphSineWave.h"

double sineWaveFrequency = 440.0;

OSStatus sineWaveRenderProc(void *inRefCon,
        AudioUnitRenderActionFlags *ioActionFlags,
        const AudioTimeStamp *inTimeStamp,
        UInt32 inBusNumber,
        UInt32 inNumberFrames,
        AudioBufferList *ioData) {
    //	printf ("sineWaveRenderProc needs %ld frames at %f\n", inNumberFrames, CFAbsoluteTimeGetCurrent());

    CustomSineWavePlayer *player = (CustomSineWavePlayer *) inRefCon;

    double j = player->startingFrameCount;
    //	double cycleLength = 44100. / 2200./*frequency*/;
    double cycleLength = 44100. / sineWaveFrequency;
    int frame = 0;
    for (frame = 0; frame < inNumberFrames; ++frame) {
        Float32 *data = (Float32 *) ioData->mBuffers[0].mData;
        (data)[frame] = (Float32) sin(2 * M_PI * (j / cycleLength));

        // copy to right channel too
        data = (Float32 *) ioData->mBuffers[1].mData;
        (data)[frame] = (Float32) sin(2 * M_PI * (j / cycleLength));

        j += 1.0;
        if (j > cycleLength)
            j -= cycleLength;
    }

    player->startingFrameCount = j;
    return noErr;
}

// generic error handler - if err is nonzero, prints error message and exits program.
static void checkError(OSStatus error, const char *operation) {
    if (error == noErr) return;

    char str[20];
    // see if it appears to be a 4-char-code
    *(UInt32 *) (str + 1) = CFSwapInt32HostToBig(error);
    if (isprint(str[1]) && isprint(str[2]) && isprint(str[3]) && isprint(str[4])) {
        str[0] = str[5] = '\'';
        str[6] = '\0';
    } else
        // no, format it as an integer
        sprintf(str, "%d", (int) error);

    fprintf(stderr, "Error: %s (%s)\n", operation, str);

    exit(1);
}


void createAndConnectOutputUnit(CustomSineWavePlayer *player) {

    //  10.6 and later: generate description that will match out output device (speakers)
    AudioComponentDescription outputcd = {0}; // 10.6 version
    outputcd.componentType = kAudioUnitType_Output;
    outputcd.componentSubType = kAudioUnitSubType_DefaultOutput;
    outputcd.componentManufacturer = kAudioUnitManufacturer_Apple;

    AudioComponent comp = AudioComponentFindNext(NULL, &outputcd);
    if (comp == NULL) {
        printf("can't get output unit");
        exit(-1);
    }
    checkError(AudioComponentInstanceNew(comp, &player->outputUnit),
            "Couldn't open component for outputUnit");

    // register render callback
    AURenderCallbackStruct input;
    input.inputProc = sineWaveRenderProc;
    input.inputProcRefCon = player;
    checkError(AudioUnitSetProperty(player->outputUnit,
            kAudioUnitProperty_SetRenderCallback,
            kAudioUnitScope_Input,
            0,
            &input,
            sizeof(input)),
            "AudioUnitSetProperty failed");

    // initialize unit
    checkError(AudioUnitInitialize(player->outputUnit),
            "Couldn't initialize output unit");

}

#pragma mark main

//int main(int argc, const char *argv[]) {
//    CustomSineWavePlayer player = {0};
//
//    // set up unit and callback
//    createAndConnectOutputUnit(&player);
//
//    // start playing
//    checkError(AudioOutputUnitStart(player.outputUnit), "Couldn't start output unit");
//
//    printf("playing\n");
//    // play for 5 seconds
//    sleep(5);
//    cleanup:
//    AudioOutputUnitStop(player.outputUnit);
//    AudioUnitUninitialize(player.outputUnit);
//    AudioComponentInstanceDispose(player.outputUnit);
//
//    return 0;
//}
