//
//  Note.swift
//  JavaNote1 WatchKit Extension
//
//  Created by Sathwika Deegutla on 2/5/21.
//

import Foundation

struct Note: Identifiable,  Codable{
    let id: UUID
    let text: String
}
