//
//  Poem.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

//struct PoemInfo {
//  let originalTitle: String
//  let translatedTitle: String
//  let original: String
//  let translation: String
//  let author: String
//}

enum DatabaseErrors: Error {
  case itemNotFound
}

class Poem: NSManagedObject {
  
  class func findOrCreatePoem(matching poemInfo: [String], in context: NSManagedObjectContext) throws -> Poem {
    let request: NSFetchRequest<Poem> = Poem.fetchRequest()
    request.predicate = NSPredicate(format: "translatedTitle = %@", poemInfo[1])
    
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        assert(matches.count == 1, "Poem.findOrCreatePoem --  database inconsistency")
        return matches[0]
      }
    } catch {
      throw error
    }
    
    let poem = Poem(context: context)
    poem.originalTitle = poemInfo[0]
    poem.translatedTitle = poemInfo[1]
    let poetInfo = [
      "name": poemInfo[2],
      "about": poemInfo[4]
    ]
    poem.author = try? Poet.findOrCreatePoet(matching: poetInfo, in: context)
    poem.translation = poemInfo[5]
    poem.original = poemInfo[6]
    return poem
  }
  
//  class func findPoem(with id: String, in context: NSManagedObjectContext) throws -> Poem {
//    let request: NSFetchRequest<Poem> = Poem.fetchRequest()
//    request.predicate = NSPredicate(format: "objectID = %@", id)
//    
//    do {
//      let matches = try context.fetch(request)
//      if matches.count > 0 {
//        assert(matches.count == 1, "Poem.findOrCreatePoem --  database inconsistency")
//        return matches[0]
//      }
//    } catch {
//      throw error
//    }
//    
//    throw DatabaseErrors.itemNotFound
//  }
  
}
