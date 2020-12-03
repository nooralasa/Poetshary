//
//  PoemViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/19/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class PoemViewController: UIViewController {

  var container: NSPersistentContainer? = AppDelegate.persistentContainer
  @IBOutlet weak var poemTitle: UILabel!
  @IBOutlet weak var poemText: UITextView!
  @IBOutlet weak var dropView: UIView! {
    didSet {
      dropView.layer.borderWidth = 2
      dropView.layer.cornerRadius = 5
      dropView.layer.borderColor = UIColor(patternImage: UIImage(named: "dash")!).cgColor
    }
  }

  
  var poem: Poem?
  var currentView: String? {
    didSet {
      updateView(for: currentView!)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    poemText?.scrollRangeToVisible(NSMakeRange(0, 1))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    poemText.textDragDelegate = self
    let dropInteraction = UIDropInteraction(delegate: self)
    dropView.addInteraction(dropInteraction)
    dropView.isUserInteractionEnabled = true
    updateView(for: "English")
  }
  
  func updateView(for currentView: String) {
    if poem != nil {
      switch currentView {
      case "English":
        poemTitle?.text = poem!.translatedTitle
        poemText?.text = poem!.translation
        poemText?.textAlignment = NSTextAlignment.left
      case "Original":
        poemTitle?.text = poem!.originalTitle
        poemText?.text = poem!.original
        poemText?.textAlignment = NSTextAlignment.right
      case "Poet":
        poemTitle?.text = poem!.author?.name
        poemText?.text = poem!.author?.about
        poemText?.textAlignment = NSTextAlignment.left
      default:
        break
      }
    }
  }

  @IBAction func changeView(_ sender: UISegmentedControl) {
    currentView = sender.titleForSegment(at: sender.selectedSegmentIndex)
  }

}

extension PoemViewController: UITextDragDelegate {
  func textDraggableView(_ textDraggableView: UIView & UITextDraggable, dragPreviewForLiftingItem item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
    
    let imageView = UIImageView(image: UIImage(named:"drag"))
    imageView.backgroundColor = UIColor.clear
    let dragView = textDraggableView
    let dragPoint = session.location(in: dragView)
    let target = UIDragPreviewTarget(container: dragView, center: dragPoint)
    
    return UITargetedDragPreview(view: imageView, parameters: UIDragPreviewParameters(), target: target)
  }
  
  func textDraggableView(_ textDraggableView: UIView & UITextDraggable, itemsForDrag dragRequest: UITextDragRequest) -> [UIDragItem] {
    
    if let draggedText = poemText.text(in: dragRequest.dragRange) {
      let itemProvider = NSItemProvider(object: draggedText as NSString)
      return [UIDragItem(itemProvider: itemProvider)]
    } else {
      return []
    }
  }
}

extension PoemViewController: UIDropInteractionDelegate {
  
  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    return session.items.count == 1
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    return UIDropProposal(operation: .copy)
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    session.loadObjects(ofClass: NSString.self) { items in
      guard let selectionText = items[0] as? String else { return }
      
      if let context = self.container?.viewContext {
        _ = try? Selection.findOrCreateSelection(matching: [
          selectionText,
          self.currentView=="Original" ? "Arabic" : "English",
          self.poem!.translatedTitle!
          ], in: context)
        try? context.save()
      }
    }
  }
  
}
