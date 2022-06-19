//
//  ContentView.swift
//  roomapp
//
//  Created by miko on 16.06.22.
//

import SwiftUI

struct ContentView: View {

    
    @StateObject var roomsModel = RoomsModel()
    @State private var searchText: String = ""
    @State private var isSelected = true
    @State private var isSelected2 = false
    
    
    // filtered list
    var filteredrooms: Welcome {
        if searchText.count == 0 { // no typing
            return roomsModel.rooms
        } else {
            return roomsModel.rooms.filter {
                var temp = String("")
                if isSelected { // department only filter
                    temp = String(describing:$0.department)
               return temp.lowercased().contains(searchText.lowercased())
                }
                else{
                if isSelected2 { // type only filter
                    temp = String(describing:$0.type)
               return temp.lowercased().contains(searchText.lowercased())
                }
                    return false
                }
               
                
            }
        }
    }
    
    var body: some View {
        NavigationView{
        // Listing filtered items
        List(filteredrooms){room in
            // name
        
            VStack(alignment:.leading){
                let checkValue = String(describing: room.lovooFact)
                if checkValue.contains("nil"){
//                    Text("kein Fact") // no LOVOO FACTS
                }
                else{ // has LOVOO FACTS
//                    Text("Fact")
                    NavigationLink(destination: LovooDetails(room: room)) {  Text("Details")}
                    // GENERATE DETAIL VIEW
                    }
                RoomRow(room: room)
                // GENERATE LINE
                }
          
        }
            
        //Navigation PART 
        .navigationTitle("Find Your Room")
        .toolbar {
                           ToolbarItem(placement: .navigationBarLeading) {
                               SelectButton(
                                   isSelected: $isSelected,
                                   color: .blue,
                                   text: "Departmend")
                                   .onTapGesture {
                                       isSelected.toggle()
                                       
                                       if isSelected {
                                           isSelected2 = false
                                       }
                                   }}
            ToolbarItem(placement: .navigationBarLeading) {
                               SelectButton(
                                   isSelected: $isSelected2,
                                   color: .blue,
                                   text: "type")
                                   .onTapGesture {
                                       isSelected2.toggle()
                                       
                                       if isSelected2 {
                                           isSelected = false
                                           
                                       }
                                   }

            
                           }}
        .searchable(text: $searchText)
     
        // INIT DATA
        .task {
            await self.roomsModel.reload()
        }
        //RELOAD DATA
        .refreshable {
            await self.roomsModel.reload()
        }
        
        
        }}
}




