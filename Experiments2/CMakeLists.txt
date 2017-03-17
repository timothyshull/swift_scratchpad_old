cmake_minimum_required(VERSION 3.5)
project(Experiments2)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES
    Experiments2/Assets.xcassets/AppIcon.appiconset/Contents.json
    Experiments2/Base.lproj/MainMenu.xib
    Experiments2/AppDelegate.swift
    Experiments2/file_watcher.py
    Experiments2/Info.plist
    Experiments2/MainWindowController.swift
    Experiments2/MainWindowController.xib
    Experiments2/MainWindowController_diff_1.txt
    Experiments2/MainWindowController_diff_2.txt
    Experiments2.xcodeproj/project.xcworkspace/xcuserdata/skull.xcuserdatad/UserInterfaceState.xcuserstate
    Experiments2.xcodeproj/project.xcworkspace/contents.xcworkspacedata
    Experiments2.xcodeproj/xcuserdata/skull.xcuserdatad/xcschemes/Experiments2.xcscheme
    Experiments2.xcodeproj/xcuserdata/skull.xcuserdatad/xcschemes/xcschememanagement.plist
    Experiments2.xcodeproj/project.pbxproj
    Experiments2Tests/Experiments2Tests.swift
    Experiments2Tests/Info.plist
    Experiments2UITests/Experiments2UITests.swift
    Experiments2UITests/Info.plist)

add_custom_target(Exp2
        COMMAND /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin/swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES ${SOURCE_FILES})