//
//  WebViewViewModel.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 04.05.2021..
//

import Foundation

class WebViewViewModel {
    weak var coordinatorDeleagte: WebViewCoordinator?
    
    var screenData: URL
    
    init(screenData: URL) {
        self.screenData = screenData
    }
}
