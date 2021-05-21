//
//  LoadingViewModelProtocol.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 26.04.2021..
//

import Foundation
import Combine

protocol LoaderViewModel {
    var loaderPublisher: CurrentValueSubject<Bool, Never> { get }
}
