//
//  MovieDetailsView.swift
//  HelloCoreData Demo
//
//  Created by Frederick Javalera on 9/28/21.
//

import SwiftUI

struct MovieDetailsView: View {
  
  let movie: Movie
  @State private var movieName: String = ""
  let coreDM: CoreDataManager
  @Binding var needsRefresh: Bool
  
  var body: some View {
    VStack {
      TextField(movie.title ?? "", text: $movieName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button("Update") {
        if !movieName.isEmpty {
          movie.title = movieName
          coreDM.updateMovie()
          needsRefresh.toggle()
        }
      }
    }
    .padding()
  }
}

struct MovieDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    let coreDM = CoreDataManager()
    let movie = Movie(context: coreDM.persistenceContainer.viewContext)
    
    MovieDetailsView(movie: movie, coreDM: CoreDataManager(), needsRefresh: .constant(false))
  }
}
