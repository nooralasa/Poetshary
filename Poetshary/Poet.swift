//
//  Poet.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

class Poet: NSManagedObject {
  
  class func findOrCreatePoet(matching poetInfo: [String:String], in context: NSManagedObjectContext) throws -> Poet {
    let request: NSFetchRequest<Poet> = Poet.fetchRequest()
    request.predicate = NSPredicate(format: "name = %@", poetInfo["name"]!)
    
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        assert(matches.count == 1, "Poet.findOrCreatePoet --  database inconsistency")
        return matches[0]
      }
    } catch {
      throw error
    }
    
    let poet = Poet(context: context)
    poet.name = poetInfo["name"]
    poet.about = poetInfo["about"]
    return poet
  }
  
}
