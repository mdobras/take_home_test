//
//  LovooDetails.swift
//  roomapp
//
//  Created by miko on 19.06.22.
//
//

import SwiftUI

struct LovooDetails: View{
    let room: WelcomeElement
    
    var body: some View{
        ScrollView{
        VStack{
        Text(room.lovooFact!.title)
        
        let size = room.lovooFact!.images.count
//        Text("\(room.lovooFact!.images.count)")
        ForEach(0..<size){ nr in
            AsyncImage(url: URL(string: room.lovooFact!.images[nr])) { phase in
                switch phase {
                case .empty:
                               ProgressView()
                           case .success(let image):
                               image
                                   .resizable()
                                   .transition(.scale(scale: 0.1, anchor: .center))
                                   .frame(width: 300 ,height: 200, alignment: .center)
                           case .failure:
                    Text("NULL")
                           @unknown default:
                    Text("NULL")
                }
             
            }
        }
        
        
      
        Text(room.lovooFact!.text)
        }
        }
    }
}
