//
//  CurrentUserViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Combine

class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    
    private var cancellabes = Set<AnyCancellable>()
    
    init() {
        setUpSubscribers()
    }
    
    private func setUpSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellabes)
    }
}

