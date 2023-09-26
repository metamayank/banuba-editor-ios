//
//  VideoPlayerViewManager.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation

@objc(VideoPlayerViewManager)
class VideoPlayerViewManager: RCTViewManager {
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  override func view() -> UIView! {
    let playerView = VideoPlayerView()
    return playerView
  }
  
}
