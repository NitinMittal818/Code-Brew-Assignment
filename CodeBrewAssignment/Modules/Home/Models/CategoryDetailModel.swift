//
//  CategoryDetailModel.swift
//  CodeBrewAssignment
//
//  Created by Nitin Mittal on 09/01/22.
//

import Foundation
struct CategoryDetailModel : Codable {
    let message : String?
    let dataMain : DataMain?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case dataMain = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        dataMain = try values.decodeIfPresent(DataMain.self, forKey: .dataMain)
    }

}

struct DataMain : Codable {
    let current_page : Int?
    let data : [Data]?

    enum CodingKeys: String, CodingKey {

        case current_page = "current_page"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        data = try values.decodeIfPresent([Data].self, forKey: .data)
    }

}

struct Data : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let deadline : String?
    let hoursAssigned : String?
    let hoursCompletedTillNow : String?
    let created_by : Int?
    let assigned_to : Int?
    let created_at : String?
    let reopen_count : Int?
    let approved : String?
    let completed : String?
    let completed_on : String?
    let assigned : Assigned?
    let creator : Creator?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case deadline = "deadline"
        case hoursAssigned = "hoursAssigned"
        case hoursCompletedTillNow = "hoursCompletedTillNow"
        case created_by = "created_by"
        case assigned_to = "assigned_to"
        case created_at = "created_at"
        case reopen_count = "reopen_count"
        case approved = "approved"
        case completed = "completed"
        case completed_on = "completed_on"
        case assigned = "assigned"
        case creator = "creator"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        deadline = try values.decodeIfPresent(String.self, forKey: .deadline)
        hoursAssigned = try values.decodeIfPresent(String.self, forKey: .hoursAssigned)
        hoursCompletedTillNow = try values.decodeIfPresent(String.self, forKey: .hoursCompletedTillNow)
        created_by = try values.decodeIfPresent(Int.self, forKey: .created_by)
        assigned_to = try values.decodeIfPresent(Int.self, forKey: .assigned_to)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        reopen_count = try values.decodeIfPresent(Int.self, forKey: .reopen_count)
        approved = try values.decodeIfPresent(String.self, forKey: .approved)
        completed = try values.decodeIfPresent(String.self, forKey: .completed)
        completed_on = try values.decodeIfPresent(String.self, forKey: .completed_on)
        assigned = try values.decodeIfPresent(Assigned.self, forKey: .assigned)
        creator = try values.decodeIfPresent(Creator.self, forKey: .creator)
    }

}


struct Creator : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct Assigned : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
