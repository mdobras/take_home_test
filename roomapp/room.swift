//
//  room.swift
//  roomapp
//
//  Created by miko on 17.06.22.
//

import Foundation


// MARK: - WelcomeElement
struct WelcomeElement: Identifiable,Codable {
    let department: String
    let officeLevel: OfficeLevel
    let name: String
    let type: Typ?
    let roomNumber: RoomNumber
    let id: String
    let lovooFact: LovooFact?
    let typ: Typ?
}

// MARK: - LovooFact
struct LovooFact: Codable {
    let images: [String]
    let text, title: String
}

// MARK: - OFFICE-LEVEL
enum OfficeLevel: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(OfficeLevel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OfficeLevel"))
    }


}

// MARK: - ROOM NUMBER
enum RoomNumber: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(RoomNumber.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RoomNumber"))
    }

   
}


// MARK: - Typ
enum Typ: String, Codable {
    case meeting = "meeting"
    case team = "team"
    case typPublic = "public"
}

// MARK: - Alias Rename
typealias Welcome = [WelcomeElement]











// MARK: - ROOMS MODEL
@MainActor
class RoomsModel: ObservableObject{
    @Published var rooms :[WelcomeElement] = []
    
    func reload() async {
    let url = URL(string: "https://europe-west1-lv-trialwork.cloudfunctions.net/lovooOffice")! // URL
    let user="lovooTrialUser";// USER NAME
    let pw="lovoo#2021";      // PW
        
    let authData = (user + ":" + pw).data(using: .utf8)!.base64EncodedString() // Preparation baseAuth
    var request = URLRequest(url:url)
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization") // GENERATE HTTPHEADERFIELD
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            let decoder = JSONDecoder() // DECODER INITALIZED
            if let data = data { // GET DATA
                do {
                    self.rooms = try decoder.decode(Welcome.self, from:data) // DECODE TO STRUCT WELCOMELEMENT
                    //print("found \(self.rooms.count)" ) DEBUG HOW MUCH ITEMS WE HAVE
                }
                catch{
                    print(error)
                }
                
            }
           
        }
        task.resume()

}
}
