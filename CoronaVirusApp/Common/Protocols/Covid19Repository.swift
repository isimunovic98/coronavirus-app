//
//  Covid19Repository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 20.04.2021..
//

import Foundation
import Combine

protocol Covid19Repository {
    
    func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>
    func getCountryStatsTotal(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>
    func getCountryStats(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>
    func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>
}
