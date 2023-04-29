//
//  ContentView.swift
//  SwiftUI-Birthday-Input
//
//  Created by Eason on 2023/4/29.
//
import SwiftUI

struct BirthdayTextField: View {
    @Binding var birthday: String
    
    var body: some View {
        TextField("example：1999-09-09", text: $birthday)
            .keyboardType(.numberPad)
            .frame(height: 30)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .submitLabel(.next)
    }
}

struct ContentView: View {
    @State private var birthday: String = ""
    private var cleanBirthday: String {
        var clean = birthday.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if clean.count > 8 {
            clean = String(clean.prefix(8))
        }
        if clean.count > 4 {
            clean.insert("-", at: clean.index(clean.startIndex, offsetBy: 4))
        }
        if clean.count > 7 {
            clean.insert("-", at: clean.index(clean.startIndex, offsetBy: 7))
        }
        return clean
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Input Birthday")
                    .font(.headline)
                Spacer()
            }
            BirthdayTextField(birthday: $birthday)
            .onChange(of: birthday) { _ in
                self.birthday = cleanBirthday
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
