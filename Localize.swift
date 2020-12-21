#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

// WHAT
// 1. Find Missing keys in other Localisation files
// 2. Find potentially untranslated keys
// 3. Find Duplicate keys
// 4. Find Unused keys and generate script to delete them all at once

// MARK: Start Of Configurable Section

/*
 You can enable or disable the script whenever you want
 */
let enabled = true

/*
 Put your path here, example ->  Resources/Localizations/Languages
 */
let relativeLocalizableFolders = "/Resources/Languages"

/*
 This is the path of your source folder which will be used in searching
 for the localization keys you actually use in your project
 */
let relativeSourceFolder = "/Sources"

/*
 Those are the regex patterns to recognize localizations.
 */
let patterns = [
    "NSLocalized(Format)?String\\(\\s*@?\"([\\w\\.]+)\"", // Swift and Objc Native
    "Localizations\\.((?:[A-Z]{1}[a-z]*[A-z]*)*(?:\\.[A-Z]{1}[a-z]*[A-z]*)*)", // Laurine Calls
    "L10n.tr\\(key: \"(\\w+)\"", // SwiftGen generation
    "ypLocalized\\(\"(.*)\"\\)",
    "\"(.*)\".localized", // "key".localized pattern
    "Localizable\\.((?:[a-z]*[A-z]*)*)\\.localized"
]

/*
 Those are the keys you don't want to be recognized as "unused"
 For instance, Keys that you concatenate will not be detected by the parsing
 so you want to add them here in order not to create false positives :)
 */
let ignoredFromUnusedKeys: [String] = []
/* example
let ignoredFromUnusedKeys = [
    "NotificationNoOne",
    "NotificationCommentPhoto",
    "NotificationCommentHisPhoto",
    "NotificationCommentHerPhoto"
]
*/

let masterLanguage = "en"

/*
 Sanitizing files will remove comments, empty lines and order your keys alphabetically.
 */
let sanitizeFiles = false

/*
 Determines if there are multiple localizations or not.
 */
let singleLanguage = false

/*
 Determines if we should show errors if there's a key within the app
 that does not appear in master translations.
*/
let checkForUntranslated = true

// MARK: End Of Configurable Section
// MARK: -











if enabled == false {
    print("Localization check cancelled")
    exit(000)
}

// Detect list of supported languages automatically
func listSupportedLanguages() -> [String] {
    var sl: [String] = []
    let path = FileManager.default.currentDirectoryPath + relativeLocalizableFolders
    if !FileManager.default.fileExists(atPath: path) {
        print("Invalid configuration: \(path) does not exist.")
        exit(1)
    }
    let enumerator = FileManager.default.enumerator(atPath: path)
    let extensionName = "lproj"
    print("Found these languages:")
    while let element = enumerator?.nextObject() as? String {
        if element.hasSuffix(extensionName) {
            print(element)
            let name = element.replacingOccurrences(of: ".\(extensionName)", with: "")
            sl.append(name)
        }
    }
    return sl
}

let supportedLanguages = listSupportedLanguages()
var ignoredFromSameTranslation: [String: [String]] = [:]
let path = FileManager.default.currentDirectoryPath + relativeLocalizableFolders
var numberOfWarnings = 0
var numberOfErrors = 0

struct LocalizationFiles {
    var name = ""
    var keyValue: [String: String] = [:]
    var linesNumbers: [String: Int] = [:]

    init(name: String) {
        self.name = name
        process()
    }

    mutating func process() {
        if sanitizeFiles {
            removeCommentsFromFile()
            removeEmptyLinesFromFile()
            sortLinesAlphabetically()
        }
        let location = singleLanguage ? "\(path)/Localizable.strings" : "\(path)/\(name).lproj/Localizable.strings"
        guard let string = try? String(contentsOfFile: location, encoding: .utf8) else {
            return
        }

        let lines = string.components(separatedBy: .newlines)
        keyValue = [:]

        let pattern = "\"(.*)\" = \"(.+)\";"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        var ignoredTranslation: [String] = []

        for (lineNumber, line) in lines.enumerated() {
            let range = NSRange(location: 0, length: (line as NSString).length)

            // Ignored pattern
            let ignoredPattern = "\"(.*)\" = \"(.+)\"; *\\/\\/ *ignore-same-translation-warning"
            let ignoredRegex = try? NSRegularExpression(pattern: ignoredPattern, options: [])
            if let ignoredMatch = ignoredRegex?.firstMatch(in: line,
                                                           options: [],
                                                           range: range) {
                let key = (line as NSString).substring(with: ignoredMatch.range(at: 1))
                ignoredTranslation.append(key)
            }

            if let firstMatch = regex?.firstMatch(in: line, options: [], range: range) {
                let key = (line as NSString).substring(with: firstMatch.range(at: 1))
                let value = (line as NSString).substring(with: firstMatch.range(at: 2))

                if keyValue[key] != nil {
                    let str = "\(path)/\(name).lproj"
                        + "/Localizable.strings:\(linesNumbers[key]!): "
                        + "error: [Duplication] \"\(key)\" "
                        + "is duplicated in \(name.uppercased()) file"
                    print(str)
                    numberOfErrors += 1
                } else {
                    keyValue[key] = value
                    linesNumbers[key] = lineNumber + 1
                }
            }
        }
        print(ignoredFromSameTranslation)
        ignoredFromSameTranslation[name] = ignoredTranslation
    }

    func rebuildFileString(from lines: [String]) -> String {
        return lines.reduce("") { (r: String, s: String) -> String in
            (r == "") ? (r + s) : (r + "\n" + s)
        }
    }

    func removeEmptyLinesFromFile() {
        let location = "\(path)/\(name).lproj/Localizable.strings"
        if let string = try? String(contentsOfFile: location, encoding: .utf8) {
            var lines = string.components(separatedBy: .newlines)
            lines = lines.filter { $0.trimmingCharacters(in: .whitespaces) != "" }
            let s = rebuildFileString(from: lines)
            try? s.write(toFile: location, atomically: false, encoding: .utf8)
        }
    }

    func removeCommentsFromFile() {
        let location = "\(path)/\(name).lproj/Localizable.strings"
        if let string = try? String(contentsOfFile: location, encoding: .utf8) {
            var lines = string.components(separatedBy: .newlines)
            lines = lines.filter { !$0.hasPrefix("//") }
            let s = rebuildFileString(from: lines)
            try? s.write(toFile: location, atomically: false, encoding: .utf8)
        }
    }

    func sortLinesAlphabetically() {
        let location = "\(path)/\(name).lproj/Localizable.strings"
        if let string = try? String(contentsOfFile: location, encoding: .utf8) {
            let lines = string.components(separatedBy: .newlines)

            var s = ""
            for (i, l) in sortAlphabetically(lines).enumerated() {
                s += l
                if i != lines.count - 1 {
                    s += "\n"
                }
            }
            try? s.write(toFile: location, atomically: false, encoding: .utf8)
        }
    }

    func removeEmptyLinesFromLines(_ lines: [String]) -> [String] {
        return lines.filter { $0.trimmingCharacters(in: .whitespaces) != "" }
    }

    func sortAlphabetically(_ lines: [String]) -> [String] {
        return lines.sorted()
    }
}

// MARK: - Load Localisation Files in memory

let masterLocalizationFile = LocalizationFiles(name: masterLanguage)
let localizationFiles = supportedLanguages
    .filter { $0 != masterLanguage }
    .map { LocalizationFiles(name: $0) }

// MARK: - Detect Unused Keys

let sourcesPath = FileManager.default.currentDirectoryPath + relativeSourceFolder
let fileManager = FileManager.default
let enumerator = fileManager.enumerator(atPath: sourcesPath)
var localizedStrings: [String] = []
while let swiftFileLocation = enumerator?.nextObject() as? String {
    // checks the extension
    if swiftFileLocation.hasSuffix(".swift") || swiftFileLocation.hasSuffix(".m") || swiftFileLocation.hasSuffix(".mm") {
        let location = "\(sourcesPath)/\(swiftFileLocation)"
        if let string = try? String(contentsOfFile: location, encoding: .utf8) {
            for p in patterns {
                let regex = try? NSRegularExpression(pattern: p, options: [])
                let range = NSRange(location: 0, length: (string as NSString).length) // Obj c wa
                regex?.enumerateMatches(in: string,
                                        options: [],
                                        range: range,
                                        using: { result, _, _ in
                                            if let r = result {
                                                let value = (string as NSString).substring(with: r.range(at: r.numberOfRanges - 1))
                                                localizedStrings.append(value)
                                            }
                })
            }
        }
    }
}

var masterKeys = Set(masterLocalizationFile.keyValue.keys)
let usedKeys = Set(localizedStrings)
let ignored = Set(ignoredFromUnusedKeys)
let unused = masterKeys.subtracting(usedKeys).subtracting(ignored)
let untranslated = usedKeys.subtracting(masterKeys)

// Here generate Xcode regex Find and replace script to remove dead keys all at once!
var replaceCommand = "\"("
var counter = 0
for v in unused {
    var str = "\(path)/\(masterLocalizationFile.name).lproj/Localizable.strings:\(masterLocalizationFile.linesNumbers[v]!): "
    str += "error: [Unused Key] \"\(v)\" is never used"
    print(str)
    numberOfErrors += 1
    if counter != 0 {
        replaceCommand += "|"
    }
    replaceCommand += v
    if counter == unused.count - 1 {
        replaceCommand += ")\" = \".*\";"
    }
    counter += 1
}

print(replaceCommand)

// MARK: - Compare each translation file against master (en)

for file in localizationFiles {
    for k in masterLocalizationFile.keyValue.keys {
        if let v = file.keyValue[k] {
            if v == masterLocalizationFile.keyValue[k] {
                if !ignoredFromSameTranslation[file.name]!.contains(k) {
                    let str = "\(path)/\(file.name).lproj/Localizable.strings"
                        + ":\(file.linesNumbers[k]!): "
                        + "warning: [Potentially Untranslated] \"\(k)\""
                        + "in \(file.name.uppercased()) file doesn't seem to be localized"
                    print(str)
                    numberOfWarnings += 1
                }
            }
        } else {
            var str = "\(path)/\(file.name).lproj/Localizable.strings:\(masterLocalizationFile.linesNumbers[k]!): "
            str += "error: [Missing] \"\(k)\" missing from \(file.name.uppercased()) file"
            print(str)
            numberOfErrors += 1
        }
    }

    let redundantKeys = file.keyValue.keys.filter { !masterLocalizationFile.keyValue.keys.contains($0) }

    for k in redundantKeys {
        let str = "\(path)/\(file.name).lproj/Localizable.strings:\(file.linesNumbers[k]!): "
            + "error: [Redundant key] \"\(k)\" redundant in \(file.name.uppercased()) file"

        print(str)
    }
}

if checkForUntranslated {
    for key in untranslated {
        var str = "\(path)/\(masterLocalizationFile.name).lproj/Localizable.strings:1: "
        str += "error: [Missing Translation] \(key) is not translated"

        print(str)
        numberOfErrors += 1
    }
}

print("Number of warnings : \(numberOfWarnings)")
print("Number of errors : \(numberOfErrors)")

if numberOfErrors > 0 {
    exit(1)
}
