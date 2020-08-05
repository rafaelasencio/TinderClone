//
//  SettingsViewModel.swift
//  TinderClone
//
//  Created by Usuario on 04/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit


enum SettingsSections: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {
            
        case .name: return "Name"
        case .profession: return "Profession"
        case .age: return "Age"
        case .bio: return "Bio"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct SettingsViewModel {
    
    private let user: User
    private let section: SettingsSections
    
    var shouldHideInputField: Bool {
        return section == .ageRange
    }
    
    var shouldHideSlider: Bool {
        return section != .ageRange
    }
    
    init(user: User, section: SettingsSections) {
        self.user = user
        self.section = section
    }
}
