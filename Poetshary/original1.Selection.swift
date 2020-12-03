//
//  Selection.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class Selection: NSManagedObject {
  
  class func findOrCreateSelection(matching selectionInfo: [String], in context: NSManagedObjectContext) throws -> Selection {
    let request: NSFetchRequest<Selection> = Selection.fetchRequest()
    request.predicate = NSPredicate(format: "text = %@", selectionInfo[0])
    
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        assert(matches.count == 1, "Selection.findOrCreateSelection --  database inconsistency")
        return matches[0]
      }
    } catch {
      throw error
    }
    
    let selection = Selection(context: context)
    selection.text = selectionInfo[0]
    selection.language = selectionInfo[1]
    selection.createdAt = NSDate().timeIntervalSince1970
    selection.poem = try? Poem.findOrCreatePoem(matching: ["", selectionInfo[2]], in: context)
    return selection
  }
  
  class func deleteSelection(with id: NSManagedObjectID, in context: NSManagedObjectContext) throws -> Bool {
    let request: NSFetchRequest<Selection> = Selection.fetchRequest()
    request.predicate = NSPredicate(format: "self IN %@", [id])
    
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        assert(matches.count == 1, "Selection.findOrCreateSelection --  database inconsistency")
        context.delete(matches[0])
        return true
      }
    } catch {
      throw error
    }
    
    return false
  }
  
}
