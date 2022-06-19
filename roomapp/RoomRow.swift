//
//  RoomRow.swift
//  roomapp
//
//  Created by miko on 19.06.22.
//

import SwiftUI

struct RoomRow: View {
    let room: WelcomeElement
    var body: some View {
        
        // MARK: - VISUALIZE ROOMNAME
        Text("Raum:\(room.name)")
        // MARK: - VISUALIZE DEPARTMENT
        Text("department:\(room.department)")
        // MARK: - VISUALIZE Type AND HANDLING
        var type = String(describing: room.type?.rawValue)
            var str = type ?? String(describing: room.typ?.rawValue)
            
            // cases for type
            if str.contains("public"){
                Text("Type: public")
            }
            else{
                if str.contains("team"){
                    Text("Type: team")
                }
                else{
                    if str.contains("meeting"){
                        Text("Type: meeting")
                        }
                    }
            
            
            }
            
        // MARK: - VISUALIZE ROOM NUMBER AND HANDLING
            var test = String("\(room.roomNumber)")
            if(test.contains("double")){
                // Preparation baseAuth
                let result7 = String(test.dropFirst(7))
                let result8 = String(result7.dropLast(1))
                Text("Raumnummer: \(result8)")
            }
            else{
            let result8 = String(test.dropFirst(8))
            let result10 = String(result8.dropLast(2))
//                Text(test)
            Text("Raumnummer: \(result10)")
            if (result10.count == 0){
                Text("Raumnummer nicht vorhanden")
            }
            }
        }
        
    }




