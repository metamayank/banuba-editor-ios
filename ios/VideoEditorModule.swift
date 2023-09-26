//
//  VideoEditorModule.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation
import BanubaUtilities
import VideoEditor

class VideoEditorModule {
  var editor: VideoEditorService
  var selectedVideoContent: [URL] = []
  
  let videoResolutionConfiguration = VideoResolutionConfiguration(
      default: .hd1280x720,
      resolutions: [:],
      thumbnailHeights: [:],
      defaultThumbnailHeight: 400.0
  )
  
  init () {
    print("token==", AppDelegate.licenseToken)
    guard let editor = VideoEditorService(token: AppDelegate.licenseToken)  else {
        fatalError("The token is invalid. Please check if token contains all characters.")
    }
    
    if let videoUrl = Bundle.main.url(forResource: "video", withExtension: "mp4") {
      self.selectedVideoContent.append(videoUrl)
    }

    print(selectedVideoContent)
    
    self.editor = editor
  }

}
