//
//  HelloCoreData_DemoApp.swift
//  Shared
//
//  Created by Frederick Javalera on 9/28/21.
//

import SwiftUI

@main
struct HelloCoreData_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: Persistence())
        }
    }
}
