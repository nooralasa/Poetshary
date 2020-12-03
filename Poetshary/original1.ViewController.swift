//
//  ViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  
  var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
//    updateDatabase()
//    _ = retrievePoem(from: "A Body")?.tr/anslation
  }
  
//  private func updateDatabase() {
//    container?.performBackgroundTask { [weak self] context in
//      for (_, poemInfo) in data {
//        _ = try? Poem.findOrCreatePoem(matching: poemInfo, in: context)
//      }
//      try? context.save()
//      self?.printDatabaseStatistics()
//    }
//  }
  
  private func printDatabaseStatistics() {
    if let context = container?.viewContext {
      context.perform {
        let request: NSFetchRequest<Poem> = Poem.fetchRequest()
        if let poemCount = (try? context.fetch(request))?.count {
          print("\(poemCount) poems")
        }
        if let poetCount = try? context.count(for: Poet.fetchRequest()) {
          print("\(poetCount) poets")
        }
      }
    }
  }
  
//  private func retrievePoem(from title: String) -> Poem? {
//    var poem: Poem? = nil
//    container?.performBackgroundTask {[weak self] context in
//      poem = try? Poem.findOrCreatePoem(matching: [title], in: context)
//      
//      if let context2 = self?.container?.viewContext, poem != nil {
//        context2.perform {
//            self?.textView?.text = poem?.translation
//        }
//      }
//      try? context.save()
//    }
//    
//    return poem
//  }

}

