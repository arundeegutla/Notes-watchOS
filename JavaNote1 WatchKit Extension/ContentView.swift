//
//  ContentView.swift
//  JavaNote1 WatchKit Extension
//
//  Created by Sathwika Deegutla on 2/5/21.
//

import SwiftUI

struct ContentView: View {
    // Properties
    @State  private var notes = [Note]()
    
    @State private var text = ""
    
    @AppStorage("lineCount") var lineCount = 1
    
    //Body
    var body: some View {
        VStack{
            
            
            HStack{
            TextField("Add New Note", text: $text)
                .foregroundColor(.orange)
            
            Button{
                guard  text.isEmpty == false else { return }
                let note = Note(id:  UUID(), text: text)
                notes.append(note)
                
                text  = ""
                save()
            } label: {
                Image(systemName: "plus")
                    .padding()
            }
            .fixedSize()
            .buttonStyle(BorderedButtonStyle(tint: .purple))
            }
            
            List{
            ForEach(0..<notes.count, id: \.self){ i in
                NavigationLink(destination: DetailView(index: 1, note: notes[i])) {
                    Text(notes[i].text)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                    
                    
                    
                    }
                }
            .onDelete(perform: delete)
            }
            
        }//vstack
    .navigationTitle("JavaNotes1")
        .onAppear(perform: load)
    }
    
    //functions
    func delete(offsets: IndexSet) {
        withAnimation{
        notes.remove(atOffsets: offsets)
            save()
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func save(){
        do {
            let data = try JSONEncoder().encode(notes)
            let url =
                getDocumentsDirectory()
                    .appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Save Failed")
        }
    }// save
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url =
                    getDocumentsDirectory().appendingPathComponent("notes")
                let data = try
                Data(contentsOf: url)
                notes = try
                    JSONDecoder().decode([Note].self, from: data)
            } catch {
                // do nothing
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
