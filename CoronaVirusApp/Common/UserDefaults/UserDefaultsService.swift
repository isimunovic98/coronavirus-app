
import Foundation

class UserDefaultsService {
    
    static func update(_ item: UserDefaultsDomainItem) {
        #warning("delete print")
        print("Updating userdefaults:: -usecase: \(item.usecase)")
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(item.usecase, forKey: "usecase")
        do { try userDefaults.setCustomObject(item.details, forKey: "usecaseDetails") }
        catch (let error) { print(error.localizedDescription) }
    }
    
    static func getSavedData() -> UserDefaultsDomainItem? {
        var result = UserDefaultsDomainItem()
        let userDefaults = UserDefaults.standard
        guard let savedUsecase = userDefaults.value(forKey: "usecase") as? String else { return nil }
        result.usecase = savedUsecase
        do { result.details = try userDefaults.getCustomObject(forKey: "usecaseDetails") }
        catch (_) { }
        #warning("delete print")
        print("Retrieveing userdefaults:: -usecase: \(savedUsecase)")
        return result
    }
    
    static func getUsecase() -> UseCaseSelection? {
        guard let data = UserDefaultsService.getSavedData() else { return nil }
        switch data.usecase {
        case "worldwide": return .worldwide
        default: return .country(data.usecase)
        }
    }
}
