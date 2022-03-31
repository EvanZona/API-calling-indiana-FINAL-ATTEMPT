//
//  ContentView.swift
//  API calling indiana FINAL ATTEMPT
//
//  Created by Student on 2/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var singles = [Single]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(singles) {single in
                NavigationLink(
                    destination: VStack {
                        Text(single.rank)
                        Text(single.title)
                        Text(single.artist)
                        //Text("Last week: \(single.lastWeek)")
                        //Text("Peak position: \(single.peakPosition)")
                        //Text("Weeks on chart: \(single.weeksOnChart)")
                        //Text("Detail: \(single.detail)")
                    },
                    label: {
                        HStack {
                            Text(single.rank)
                            Text(single.title)
                            Text(single.artist)
                        }
                    })
            }
            .navigationTitle("Top 10 songs")
            
        }
        .onAppear(perform: {
            queryAPI()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    
    func queryAPI() {
        let apiKey = "&rapidapi-key=ccbe24b966msh00f19017580b48bp12c43fjsn104ce1c9f318"
        let query = "https://billboard-api2.p.rapidapi.com/hot-100?date=2021-02-20&range=1-10\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let content = json["content"].dictionaryValue
                for i in 1...10{
                    if let item = content[String(i)]?.dictionaryValue {
                        let rank = item["rank"]!.stringValue
                        let title = item["title"]!.stringValue
                        let artist = item["artist"]!.stringValue
                        //let lastWeek = item["Last week"].stringValue
                        //let peakPosition = item["peak position"].stringValue
                        //let detail = item["detail"].stringValue
                        let single = Single(rank: rank, title: title, artist: artist)
                        singles.append(single)
                    }
                }
            }
        }
    }
    
    struct Single: Identifiable {
        let id = UUID()
        var rank: String
        var title: String
        var artist: String
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
