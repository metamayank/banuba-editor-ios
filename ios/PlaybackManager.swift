//
//  PlaybackManager.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation
import BanubaUtilities
import VEPlaybackSDK
import VideoEditor
import VEEffectsSDK
import UIKit
import React
import AVFoundation

class PlaybackManager: VideoEditorPlayerDelegate {
  
  private(set) weak var playbackView: VideoPlayableView?
  
  // Player progress callback. You can use it to track player position
  var progressCallback: ((_ progress: Float) -> Void)?
  
  var player: VideoEditorPlayable? { playbackView?.videoEditorPlayer }
  
  var currentPlayerPostion: CMTime { playbackView?.videoEditorPlayer?.currentTime ?? .zero }
  
  var totalVideoDuration: CMTime { videoEditorService.videoAsset?.composition.duration ?? .zero }
  
  var isPlaying: Bool { player?.isPlaying ?? false}
  
  // Video editor service stores resulted video asset and applied effects
  private var videoEditorService: VideoEditorService!
   
  private var playbackSDK: VEPlayback!
  
  private let videoResolutionConfiguration: VideoResolutionConfiguration
  private var videoSequence: VideoSequence?
  
  
  init(videoEditorModule: VideoEditorModule) {
      self.videoEditorService = videoEditorModule.editor
      self.videoResolutionConfiguration = videoEditorModule.videoResolutionConfiguration
      self.playbackSDK = VEPlayback(videoEditorService: videoEditorService)
  }
  
  deinit {
    // Clear video editor service asset
    videoEditorService.setCurrentAsset(nil)
  }
  
  func addVideoContent(with videoUrls: [URL]) {
    let videoSequence = createVideoSequence(with: videoUrls)
    self.videoSequence = videoSequence
    
    // Create VideoEditorAsset from relevant sequence
    // VideoEditorAsset is entity of VideoEditor used for plaback
    let videoEditorAsset = VideoEditorAsset(
      sequence: videoSequence,
      isGalleryAssets: false,
      isSlideShow: false,
      fillAspectRatioRange: 0.5...2.0,
      videoResolutionConfiguration: videoResolutionConfiguration
    )
    
    
    if videoEditorService != nil  {
      print("editor service is not nill")
      // Set current video asset to video editor service
      self.videoEditorService?.setCurrentAsset(videoEditorAsset)
      
      // Setup preview render size
      self.setupRenderSize(videoSequence: videoSequence)
      print("totalVideoDuration==",totalVideoDuration.seconds)
    }
  }
  
  
  // Provides video player preview
  func setSurfaceView(playerContainerView: VideoPlayerView!) {
    DispatchQueue.main.async {
      let playbackView = self.playbackSDK.getPlayableView(delegate: self)
      self.playbackView = playbackView
      playerContainerView.addSubview(playbackView)
      self.player?.play(loop: true, fixedSpeed: true)
      print("isplaying status==", self.isPlaying)
    }
  
  }
  
  func setVideoVolume(_ volume: Float) {
    if let player {
      videoEditorService.setVideoVolume(volume, to: player)
    }
  }
  
  
  
  // MARK: - Private Helpers
  // Create video sequence with specific name and location
  private func createVideoSequence(with videoUrls: [URL]) -> VideoSequence {
    //  private func createVideoSequence(with videoUrl: [URL]) -> VideoSequence {
    let sequenceName = UUID().uuidString
    let folderURL = FileManager.default.temporaryDirectory.appendingPathComponent(sequenceName)
    
    // Create sequence at location
    let videoSequence = VideoSequence(folderURL: folderURL)
    
    // Fill up sequence with videos
    videoUrls.forEach { videoURL in
      videoSequence.addVideo(
        at: videoURL,
        isSlideShow: false,
        transition: .normal
      )
    }
    print("Video sequence videos==", videoSequence.videos.first)
    print("Video sequence COUNT==", videoSequence.videos.count)
    
    return videoSequence
  }
  
  // Configure render video size according to video aspect and videoResolutionConfiguration
  private func setupRenderSize(videoSequence: VideoSequence) {
    if let firstVideo = videoSequence.videos.first {
      let videoSize = videoSequence.videos.map { video in
        let resolution = firstVideo.videoInfo.resolution
        let urlAsset = AVURLAsset(url: video.url)
        let preferredTransform = urlAsset.tracks(withMediaType: .video).first?.preferredTransform ?? .identity
        let rotatedResolution = resolution.applying(preferredTransform)
        return CGSize(
          width: abs(rotatedResolution.width),
          height: abs(rotatedResolution.height)
        )
      }.first!
      
      let videoAspect = VideoAspectRatioCalculator.calculateVideoAspectRatio(withVideoSize: videoSize)
      
      videoEditorService.videoSize = VideoAspectRatioCalculator.adjustVideoSize(
        videoResolutionConfiguration.current.size,
        withAspectRatio: videoAspect
      )
    } else {
      print("There is not FIRST VIDEO PRESENT")
    }
    
    
  }
  
  // Apply original track rotation for each asset track
  //  private func adjustVideoEditorAssetTracksRotation(_ videoEditorAsset: VideoEditorAsset) {
  //      videoEditorAsset.tracksInfo.forEach { assetTrack in
  //          let rotation = VideoEditorTrackRotationCalculator.getTrackRotation(assetTrack)
  //
  //          effectApplicator.addTransformEffect(
  //              atStartTime: assetTrack.timeRangeInGlobal.start,
  //              end: assetTrack.timeRangeInGlobal.end,
  //              rotation: rotation,
  //              isVideoFitsAspect: false
  //          )
  //      }
  //  }
  
  
  // MARK: - VideoEditorPlayerDelegate
  func playerPlaysFrame(_ player: BanubaUtilities.VideoEditorPlayable, atTime time: CMTime) {
    let durationSeconds = totalVideoDuration.seconds
    if durationSeconds == 0 {
      progressCallback?(Float(0))
    } else {
      progressCallback?(Float(time.seconds / durationSeconds))
    }
  }
  
  func playerDidEndPlaying(_ player: BanubaUtilities.VideoEditorPlayable) {
    print("End of video content")
  }
  
  
}

