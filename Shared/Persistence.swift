//
//  Persistence.swift
//  HelloCoreData Demo
//
//  Created by Frederick Javalera on 9/28/21.
//

import CoreData
import Foundation

class Persistence {
  
  let persistenceContainer: NSPersistentContainer
  
  init() {
    persistenceContainer = NSPersistentContainer(name: "HelloCoreDataModel")
    persistenceContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Core Data store failed to initialize: \(error.localizedDescription)")
      }
    }
  }
  
  func saveMovie(title: String) {
    let movie = Movie(context: persistenceContainer.viewContext)
    movie.title = title
    
    do {
      try persistenceContainer.viewContext.save()
      print("Movie saved!")
    } catch {
      print("Failed to save movie: \(error)")
    }
    
  }
  
}
