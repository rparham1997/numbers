//
//  NumberFactModel.swift
//  Numbers2
//
//  
//
//
// In the models folder, you want to have models (classes, structures, etc.) that hold, manipulate, or control data.
// Should NOT HAVE anything to do with UI objects.

// How to use Decodable, introduced in Swift 4
// 1. Conform to the protocol Decodable
class NumberFactModel: Decodable {
    var type: String = ""
    var number: Int = 0
    var description: String = ""
    
    // 2. Make a new enum with the case names that match the dictionary.
    // Conform the enum to the CodingKey protocol.
    enum CodingKeys: String, CodingKey {
        case type
        case number
        case description = "text"
    }
    
    // You can also add your own decodable initializer to do custom data mapping and manipulation like below.
    // This WILL OVERRIDE the automatic data assignment and you will have to do it yourself.
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        number = try container.decode(Int.self, forKey: CodingKeys.number)
//    }
}


