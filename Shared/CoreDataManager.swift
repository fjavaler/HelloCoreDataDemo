//
//  Persistence.swift
//  HelloCoreData Demo
//
//  Created by Frederick Javalera on 9/28/21.
//

import CoreData
import Foundation

class CoreDataManager {
  
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
  
  func getAllMovies() -> [Movie] {
    
    let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
    var movies = [Movie]()
    
    do {
      movies = try persistenceContainer.viewContext.fetch(fetchRequest)
    } catch {
      movies = []
    }
    
    return movies
  }
  
  func deleteMovie(movie: Movie) {
    
    persistenceContainer.viewContext.delete(movie)
    
    do {
      print("Movie deleted!")
      return try persistenceContainer.viewContext.save()
    } catch {
      persistenceContainer.viewContext.rollback()
      print("Failed to save context: \(error.localizedDescription).")
    }
  }
  
  func updateMovie() {
    do {
      try persistenceContainer.viewContext.save()
    } catch {
      print("Update movie failed.")
      persistenceContainer.viewContext.rollback()
    }
  }
}
