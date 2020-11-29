//
//  Searchbar.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/27/20.
//
 
import SwiftUI

struct Searchbar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    var onTextFieldCommit: () -> ()
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $text, onCommit:  {
                onTextFieldCommit()
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.isEditing = false
                    self.text = ""
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
            }
        }
    }
}

struct Searchbar_Previews: PreviewProvider {
    @State static var testText: String = "Test"
    static var previews: some View {
        Searchbar(text: $testText, onTextFieldCommit: { })
    }
}
