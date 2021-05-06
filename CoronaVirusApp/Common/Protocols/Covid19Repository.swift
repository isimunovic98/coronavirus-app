//
//  Covid19Repository.swift
//  CoronaVirusApp
//
//  Created by Tomislav Gelesic on 05.05.2021..
//

import Foundation
import Combine

protocol Covid19Repository {
    
    func getCountriesList() -> AnyPublisher<Result<[CountryListResponseItem], ErrorType>, Never>
    func getCountryStatsTotal(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>
    func getCountryStats(for countryName: String) -> AnyPublisher<Result<[CountryResponseItem], ErrorType>, Never>
    func getWorldwideData() -> AnyPublisher<Result<WorldwideResponseItem, ErrorType>, Never>
}
