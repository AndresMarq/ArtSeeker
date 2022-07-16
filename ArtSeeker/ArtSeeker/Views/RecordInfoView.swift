//
//  RecordInfoView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-15.
//

import SwiftUI

struct RecordInfoView: View {
    let dated: String?
    let period: String?
    let people: [Result.Record.Person]?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
                
            VStack {
                HStack {
                    Text("Dated:")
                    Text(dated ?? "Not provided")
                        .italic()
                }
                .padding(.bottom, 5)
                    
                HStack {
                    Text("Period:")
                    Text(period ?? "Not provided")
                        .italic()
                }
            }
            .font(.caption)
            .frame(width: width * 0.4, height: height * 0.15, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.primary, lineWidth: 3)
            )
            .padding()
                
            VStack {
                Text("Artist(s)")
                    .bold()
                ForEach(people ?? [Result.Record.Person(birthplace: nil, name: "Unknown", personid: 0, role: nil, displayorder: nil, culture: nil, displayname: nil)], id: \.personid) { person in
                    Text(person.name)
                }
            }
            .font(.caption)
            .frame(width: width * 0.4, height: height * 0.15, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.primary, lineWidth: 3)
            )
            .padding()
                
            Spacer()
        }
    }
}

struct RecordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInfoView(dated: "2000", period: "Modern", people: ResultExample.records[0].people, width: 400, height: 600)
    }
}
