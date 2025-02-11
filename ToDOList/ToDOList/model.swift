//
//  model.swift
//  ToDOList
//
//  Created by Guest User on 11/02/25.
//

import Foundation
struct ToDo: Identifiable,Codable
{
    var id=UUID()
    let title: String
    var isComplete=false
}
