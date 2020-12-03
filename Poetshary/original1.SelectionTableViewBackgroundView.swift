//
//  SelectionTableViewBackgroundView.swift
//  Poetshary
//
//  Created by Noor Amer on 10/23/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SelectionTableViewBackgroundView: UIView {
  
  var label: UILabel = UILabel() { didSet { setNeedsDisplay() }}
  var btn: UIButton = UIButton() { didSet { setNeedsDisplay() }}
  var playVideo: (() -> Void)?
  
  
  @objc func allowPlayingVideo() {
    if (playVideo != nil) {
      playVideo!()
    }
  }

  func addCustomView(_ frame: CGRect) {
    label.frame = CGRect(x: frame.minX, y: frame.minY+(frame.height*3/8), width: frame.width, height: frame.height/8)
    label.text = "Drag and drop a selection from a poem to view favorite selections"
    label.numberOfLines = 0
    label.font = label.font.withSize(30)
    label.textColor = UIColor.gray
    label.textAlignment = NSTextAlignment.center
    label.adjustsFontSizeToFitWidth = true
    label.alpha = 0.5
    self.addSubview(label)
    
    
    btn.frame = CGRect(x: frame.minX, y: frame.minY+(frame.height/2), width: frame.width, height: frame.height/8)
    btn.setTitleColor(UIColor.blue, for: .normal)
    btn.setTitle("See how it's done", for: .normal)
    btn.addTarget(self, action: #selector(allowPlayingVideo), for: .touchUpInside)
    self.addSubview(btn)
  }
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.backgroundColor = UIColor.white
    self.addCustomView(rect)
  }
  
}
