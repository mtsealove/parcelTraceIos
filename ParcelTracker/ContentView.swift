//
//  ContentView.swift
//  ParcelTracker
//
//  Created by Hash on 2022/08/25.
//

import SwiftUI
import CoreData
import SwiftSoup

struct ContentView: View {
    @State var search = "649431275512"
    @State var list: [TrackingModel] = []
    
    private func getItemsByHtml() {
        print(search)
        let urlStr = "http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=\(search)"
        print("url", urlStr)
        guard let url = URL(string: urlStr) else {return}
        do {
            let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
            let html = try String(contentsOf: url, encoding: encoding)
            let doc: Document = try SwiftSoup.parse(html)
//            print(doc)
            let table = try doc.body()!.select("center").select("table")[6].select("tbody").first()!
            let trs = try table.select("tr")
            
            for i in 0..<trs.count {
                let tr = trs[i]
                if i != 0 {
                    let tds = try tr.select("td")
                    if tds.count == 6 {
                        let date = try tds[0].text()
                        let time = try tds[1].text()
                        let state = try tds[5].text()
                        
                        let location = try tds[3].text()
                        let data = TrackingModel(datetime: "\(date) \(time)", location: location, state: state)
                        list.append(data)
                    }
                }
            }
//            print(list)
            list.reverse()
//            print(table)
        } catch let error {
            print("error", error)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                TextField("송장번호 입력", text: $search)
                Button(action: {
                    getItemsByHtml()
                }) {
                    Text("검색")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal, 20)
                }.background(Color.blue)
                    .cornerRadius(10)
            }.padding()
            ForEach(list) { tracking in
                TrackingView(model: tracking)
            }
            Spacer()
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
