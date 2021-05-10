
import Foundation

class UserDefaultsService {
    
    static func update(_ item: UserDefaultsDomainItem) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(item.usecase, forKey: "usecase")
        do { try userDefaults.setCustomObject(item.details, forKey: "usecaseDetails") }
        catch (let error) { print(error.localizedDescription) }
    }
    
    static func getSavedData() -> UserDefaultsDomainItem? {
        var result = UserDefaultsDomainItem()
        let userDefaults = UserDefaults.standard
        guard let usecase = userDefaults.value(forKey: "usecase") as? String else { return nil }
        result.usecase = usecase
        do { result.details = try userDefaults.getCustomObject(forKey: "usecaseDetails") }
        catch (_) { }
        return result
    }
    
    static func getUsecase() -> UseCaseSelection? {
        guard let data = UserDefaultsService.getSavedData() else { return nil }
        switch data.usecase {
        case "worldwide": return .worldwide
        default: return .country(data.usecase)
        }
    }
//    static func updateUseCase(_ usecase: UseCaseSelection) {
//        let userDefaults = UserDefaults.standard
//        switch usecase {
//        case .country(let name):
//            userDefaults.setValue("country", forKey: "usecase")
//            userDefaults.setValue(name, forKey: "countryName")
//        case .worldwide:
//            userDefaults.setValue("worldwide", forKey: "usecase")
//        }
//    }
//    
//    static func getUseCase() -> UseCaseSelection? {
//        let userDefaults = UserDefaults.standard
//        guard let usecase = userDefaults.value(forKey: "usecase") as? String else { return nil }
//        switch usecase {
//        case "worldwide": return .worldwide
//        default:
//            if let name = userDefaults.value(forKey: "countryName") as? String { return .country(name) }
//            else { return nil }
//        }
//    }
}
