//
//  DetailView.swift
//  JavaNote1 WatchKit Extension
//
//  Created by Sathwika Deegutla on 2/5/21.
//

import SwiftUI

struct DetailView: View {
    //Properties
    let index: Int
    let note: Note
    
    //Body
    var body: some View {
        Text(note.text)
            .foregroundColor(.red)
            .navigationTitle("Note \(index + 1)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 1, note: Note(id: UUID(),text: "Hello Java Class"))
    }
}
