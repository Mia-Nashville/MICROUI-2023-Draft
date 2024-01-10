//
//  ContentViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    // MARK: used for signout out user
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession // to avoid retaining cycle, add weak self
        }.store(in: &cancellables)
    }
}

