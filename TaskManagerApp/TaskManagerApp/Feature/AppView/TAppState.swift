//
//  TAppState.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import Foundation

class TAppState: ObservableObject {
    @Published private(set) var showHome: Bool {
        didSet {
            UserDefaults.showHome = showHome
        }
    }
    init(showHome: Bool = UserDefaults.showHome) {
        self.showHome = showHome
    }

    func updateViewState(showHome: Bool) {
        self.showHome = showHome
    }
}
