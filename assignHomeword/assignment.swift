//
//  item.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import Foundation
class Assignment: Codable
{
    var assignmentName: String
    var dueDate: String
    
    init(assignmentName: String, dueDate: String)
    {
        self.assignmentName = assignmentName
        self.dueDate = dueDate
    }
    enum CodingKeys: String, CodingKey
    {
        case dueDate
        case assignmentName
        
    }
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dueDate = try container.decode(String.self, forKey: .dueDate)
        assignmentName = try container.decode(String.self, forKey: .assignmentName)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(assignmentName, forKey: .assignmentName)
    }
}
