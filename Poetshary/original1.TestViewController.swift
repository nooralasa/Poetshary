//
//  TestViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/23/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TestViewController: UIViewController {
  
  @IBOutlet weak var sampleView: SelectionTableViewBackgroundView!
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    sampleView.action = playVideo
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let videoURL = URL(string: "https://nooralasa.github.io/images/dragAndDrop.mov")
//    let player = AVPlayer(url: videoURL!)
//    let playerViewController = AVPlayerViewController()
//    playerViewController.player = player
//    self.present(playerViewController, animated: true) {
//      playerViewController.player!.play()
//    }
  }
  
  @objc func playVideo() {
    print("hello")
    let videoURL = URL(string: "https://nooralasa.github.io/images/dragAndDrop.mov")
    let player = AVPlayer(url: videoURL!)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    self.present(playerViewController, animated: true) {
      playerViewController.player!.play()
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
