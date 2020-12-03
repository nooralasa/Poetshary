//
//  PoemCollectionViewCell.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit

class PoemCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var poemTitle: UILabel!
  @IBOutlet weak var originalTitle: UILabel!
  @IBOutlet weak var poetName: UILabel!
  
  var poem: Poem? = nil {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    poemTitle.text = poem!.translatedTitle
    originalTitle.text = poem!.originalTitle
    poetName.text = poem!.author?.name
  }
  
}
