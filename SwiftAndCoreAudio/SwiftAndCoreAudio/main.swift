//
//  main.swift
//  SwiftAndCoreAudio
//
//  Created by Tim Shull on 9/19/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Foundation
import AudioToolbox
import CoreAudio
import CoreFoundation

let inputFile: CFString = "/Users/skull/Desktop/test.wav" as CFString
//let stderr = NSFileHandle.fileHandleWithStandardError()

struct CustomAUGraphPlayer {
    var inputFormat: AudioStreamBasicDescription
    var inputFile: AudioFileID
    var graph: AUGraph
    var fileAU: AudioUnit
}

func checkSystemErrors<ErrorType>(error:ErrorType, operation:String) -> Void {
    if let osStatusError = error as? OSStatus {
        if osStatusError == noErr {
            return
        }
    }
    print("Error: \(operation) (\(error))", stderr)
    exit(1)
    // if let charError = error as FourCharCode
}

func createCustomAUGraph(player:UnsafeMutablePointer<CustomAUGraphPlayer>) -> Void {
    var error: OSStatus!
    var graph = player.pointee.graph as AUGraph?
    error = NewAUGraph(&graph)
    checkSystemErrors(error: error, operation: "AUGraph creation from NewAUGraph failed")


}

func prepareFileAU(player:UnsafeMutablePointer<CustomAUGraphPlayer>) -> Double {

}

func main() -> Void {
    if CommandLine.argc < 2 {
        print("Error: the program must be called with a path to an audio file", stderr)
        exit(1)
    }
//    for argument in Process.arguments {
//        switch argument {
//    let inputFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, CommandLine.arguments[1] as CFString!, CFURLPathStyle.cfurlposixPathStyle, false)
    var inputFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, CommandLine.arguments[1] as CFString, CFURLPathStyle.cfurlposixPathStyle, false)
    let player = UnsafeMutablePointer<CustomAUGraphPlayer>.allocate(capacity: MemoryLayout<CustomAUGraphPlayer>.stride)
    var error: OSStatus
    var inputFile = player.pointee.inputFile as AudioFileID?
    error = AudioFileOpenURL(inputFileURL!, AudioFilePermissions.readPermission, 0, &inputFile)
    checkSystemErrors(error: error, operation: "AudioFileOpenURL failed")
    var propSize = MemoryLayout.stride(ofValue: player.pointee.inputFormat)
    error = AudioFileGetProperty(inputFile!, kAudioFilePropertyDataFormat, &UInt32(propSize), &player.inputFormat)
    checkSystemErrors(error: error, operation: "Unable to get the data format of \"\(inputFileURL)\"")
    createCustomAUGraph(player: player)
    var fileDuration = prepareFileAU(player: player)
    error = AUGraphStart(player.pointee.graph)
    checkSystemErrors(error: error, operation: "AUGraphStart failed")
    sleep(fileDuration * 1000.0 * 1000.0)
    AUGraphStop(player.pointee.graph)
    AUGraphUninitialize(player.pointee.graph)
    AUGraphClose(player.pointee.graph)
    AudioFileClose(player.pointee.inputFile)
}

main()


