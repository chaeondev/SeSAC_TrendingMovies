//
//  ProfileSetting.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/09/03.
//

import Foundation

struct Setting {
    let title: String
    var detail: String
}

enum SettingType: String, CaseIterable {
    case name = "Name"
    case username = "Username"
    case pronouns = "Pronouns"
    case bio = "Bio"
    case links = "Links"
    case gender = "Gender"
}

struct SettingList {
    var list: [Setting] = [
        Setting(title: SettingType.name.rawValue, detail: ""),
        Setting(title: SettingType.username.rawValue, detail: ""),
        Setting(title: SettingType.pronouns.rawValue, detail: ""),
        Setting(title: SettingType.bio.rawValue, detail: ""),
        Setting(title: SettingType.links.rawValue, detail: ""),
        Setting(title: SettingType.gender.rawValue, detail: "")
    ]
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case custom = "Custom"
    case preferNotToSay = "Prefer Not to Say"
}

