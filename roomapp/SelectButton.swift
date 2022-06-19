//
//  SelectButton.swift
//  roomapp
//
//  Created by miko on 18.06.22.
//
import SwiftUI

// BUTTON ERSTELLT FÜR DIE WHICH WILL BE FILTERED
struct SelectButton: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .frame( width:100, height: 30 )
                .foregroundColor(isSelected ? color : .gray)
            Text(text)
                .foregroundColor(.white)
        }
    }
}
