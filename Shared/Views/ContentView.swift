//
//  ContentView.swift
//  Shared
//
//  Created by Frederick Javalera on 9/28/21.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: Properties
  @State private var movieName: String = ""
  @State private var movies: [Movie] = [Movie]()
  @State private var needsRefresh: Bool = false
  let coreDM: CoreDataManager
  
  private func populateMovies() {
    movies = coreDM.getAllMovies()
    print(movies[0].title!)
  }
  
  var body: some View {
    
    NavigationView {
      VStack {
        
        TextField("Enter movie name", text: $movieName)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button("Save") {
          coreDM.saveMovie(title: movieName)
          populateMovies()
        }
        
        List {
          ForEach(movies, id: \.self) {movie in
            NavigationLink {
              MovieDetailsView(movie: movie, coreDM: coreDM, needsRefresh: $needsRefresh)
            } label: {
              Text(movie.title ?? "")
            }
          }
          .onDelete { indexSet in
            indexSet.forEach { index in
              let movie = movies[index]
              coreDM.deleteMovie(movie: movie)
              populateMovies()
            }
          }
        }
        .listStyle(PlainListStyle())
        .accentColor(needsRefresh ? .white : .black)
        
        Spacer()
      }
      .padding()
      .onAppear {
        populateMovies()
      }
    }
  }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(coreDM: CoreDataManager())
  }
}
