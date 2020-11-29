//
//  IMVDbApp.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI

@main
struct IMVDbApp: App {
    var body: some Scene {
        WindowGroup {
            SearchList()
        }
    }
}

struct IMVDbApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
