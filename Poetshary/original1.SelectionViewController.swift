//
//  SelectionViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/19/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class SelectionViewController: UIViewController {
  
  var container: NSPersistentContainer? = AppDelegate.persistentContainer
  
  @IBOutlet weak var selectionTextView: UITextView!
  
  var selection: Selection? {
    didSet {
      updateUI()
    }
  }
  
  private func updateUI() {
    selectionTextView?.text = selection?.text
    if selection?.language == "Arabic" {
      selectionTextView?.textAlignment = NSTextAlignment.right
    } else {
      selectionTextView?.textAlignment = NSTextAlignment.left
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  @IBAction func share(_ sender: UIButton) {
    let shareScreen = UIActivityViewController(activityItems: [selection?.text as Any], applicationActivities: nil)
    shareScreen.title = "Share Selection"
    shareScreen.excludedActivityTypes = []
    
    let popoverPresentationController = shareScreen.popoverPresentationController
    popoverPresentationController?.sourceView = self.view
    popoverPresentationController?.sourceRect = sender.frame
    popoverPresentationController?.permittedArrowDirections = .any
    present(shareScreen, animated: true, completion: nil)
  }
  
  @IBAction func deleteSelection(_ sender: UIButton) {
    if let context = container?.viewContext, selection != nil {
      _ = try? Selection.deleteSelection(with: selection!.objectID, in: context)
      try? context.save()
    }
    _ = navigationController?.popToRootViewController(animated: true)
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
