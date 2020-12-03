//
//  DatabaseSetup.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class DatabaseSetup {
  
  var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  
//  func updateDatabase() {
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
}
