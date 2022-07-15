//
//  InspectionProperties.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 05/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation

enum PropertyStatus : Int{
    case noStatus
    case working
    case notWorking
}

class InspectionProperties : Codable {
    var parameters : [ParameterInfo]?
}

class ParameterInfo : Codable{
    var propertyName : String?
    var status : Bool?
    var subPropertyName : String?
    var subPropertyValue : String?
}


class taskPictures : Codable{
    var taskName : String?
    var taskImage : String?
    var timeStamp : String?
//    var taskdummyImage : String?
}


struct jobCoordinates: Codable {
    let lat: Double
    let lng: Double
}
