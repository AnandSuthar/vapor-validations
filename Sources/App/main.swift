import Vapor

let drop = Droplet()

drop.get("alpha") { request in
    
    let rowInput: Valid<OnlyAlphanumeric> = try request.data["input"].validated()
    
    return "Valid"
    
}

drop.get("email") { request in
    
    let email: Valid<Email> = try request.data["input"].validated()
    
    return "Valid email"
    
}

drop.get("unique") { request in
    
    guard let rawInput = request.data["input"]?.string?.components(separatedBy: ",") else {
        throw Abort.badRequest
    }
    
    let uniqueArray: Valid<Unique<Array<String>>> = try rawInput.validated()
    
    return "all are unique"
    
}

drop.get("match") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }
    
    let matchString: Valid<Matches<String>> = try rawInput.validated(by: Matches("Anand"))
    
    return "Valid match"
    
}

drop.get("in") { request in
    
    guard let rawInput = request.data["name"]?.string else {
        throw Abort.badRequest
    }
    
    let names = Set(["anand", "aman"])
    
    let validIn: Valid<In<String>> =  try rawInput.validated(by: In(names))
    
    return "valid"
    
}

drop.get("contains") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }
    
    let isValid: Valid<Contains<Array<String>>> = try rawInput.components(separatedBy: " ").validated(by: Contains("anand"))
    
    return "valid"
    
}

drop.get("countInt") { request in
    
    guard let rawInput = request.data["input"]?.int else {
        throw Abort.badRequest
    }
    
    let isValid: Valid<Count<Int>> = try rawInput.validated(by: Count.min(5))
    
    return "Valid"
    
}

drop.get("countString") { request in

    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }

    let isValidMin: Valid<Count<String>> = try rawInput.validated(by: Count.min(5))
    let isValidMax: Valid<Count<String>> = try rawInput.validated(by: Count.max(10))
    
    
    // Contains
    let isValidContainedIn: Valid<Count<String>> = try rawInput.validated(by: Count.containedIn(low: 5, high: 10))
    
    
    // Euqal
    let isValidEqual: Valid<Count<String>> = try rawInput.validated(by: Count.equals(6))
    
    return "valid"
}


drop.get("customEmailValidation") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }

    
    let isValidEmail: Valid<EmailSuite> = try rawInput.validated()
    
    return "valid"
    
}

drop.get("passwordValidation") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }
    
    let isValid: Valid<PasswordSuite> = try rawInput.validated()
    
    return "Valid"
    
}



drop.get("passes") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }
    
    let isPasses = rawInput.passes(PasswordSuite.self)
    
    return "\(isPasses)"
    
}

drop.get("tested") { request in
    
    guard let rawInput = request.data["input"]?.string else {
        throw Abort.badRequest
    }
    
    do {
        let letTest = try rawInput.tested(by: PasswordSuite.self)
    } catch {
        throw Abort.custom(status: .conflict, message: "Password length should be more then 5 character")
    }
    
    return "Valid"
    
}



drop.run()














