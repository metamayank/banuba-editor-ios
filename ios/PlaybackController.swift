//
//  PlaybackController.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation
import React
import UIKit


@objc(PlaybackController)
class PlaybackController: NSObject, RCTBridgeModule {
  static func moduleName() -> String {
    return "PlaybackController"
  }
  
  let editor = VideoEditorModule()
  var playbackManager: PlaybackManager!
  let playerContainerView = VideoPlayerView()
  
  // Override the designated initializer from NSObject
  override init() {
    super.init()
    
  }
  
  func initializePlayback()  {
    editor.editor.getLicenseState(completion: { isValid in
      print("license is valid here")
        self.playbackManager = PlaybackManager(videoEditorModule: self.editor)
        self.playbackManager.addVideoContent(with: self.editor.selectedVideoContent)
        self.playbackManager.setSurfaceView(playerContainerView: self.playerContainerView)
    })
  }
  
  @objc func sendUIViewToReact(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    initializePlayback()
  }
  
  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
}


