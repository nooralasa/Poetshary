//
//  SelectionTableViewCell.swift
//  Poetshary
//
//  Created by Noor Amer on 10/20/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
  
  var selection: Selection? {
    didSet {
      updateUI()
    }
  }

  @IBOutlet weak var poemTitle: UILabel!
  @IBOutlet weak var selectionText: UILabel!
  
  private func updateUI() {
    poemTitle?.text = selection?.language=="Arabic" ? selection?.poem?.originalTitle : selection?.poem?.translatedTitle
    selectionText?.text = selection?.text
  }
  
}
