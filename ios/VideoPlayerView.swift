//
//  VideoPlayerView.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation
import UIKit

class VideoPlayerView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    print("subviews==", self.subviews)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
