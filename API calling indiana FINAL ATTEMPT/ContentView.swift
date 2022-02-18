//
//  ContentView.swift
//  API calling indiana FINAL ATTEMPT
//
//  Created by Student on 2/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var info = [content]()
    var body: some View {
        NavigationView {
            List(info) { content in
                NavigationLink(
                    destination: Text(content.artist)
                        .padding(),
                    label: {
                        Text(content.title)
                    })
            }
            .navigationTitle("Billboard Hot 100")
            
        }
        .onAppear(perform: {
            getinfo()
        })
    }
    func getinfo() {
        let apiKey = "ccbe24b966msh00f19017580b48bp12c43fjsn104ce1c9f318"
    }
}
struct content: Identifiable {
    let id = UUID()
    var title: String
    var artist: String
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
}
