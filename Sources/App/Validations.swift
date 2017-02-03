import Vapor

final class EmailSuite: ValidationSuite {
    
    static func validate(input value: String) throws {
        
        let suite = Email.self && Count.containedIn(low: 7, high: 66)
        try suite.validate(input: value)
        
    }
    
}


final class PasswordSuite: ValidationSuite {
    
    static func validate(input value: String) throws {
        _ = try Count.min(6).validate(input: value)
    }
    
}
