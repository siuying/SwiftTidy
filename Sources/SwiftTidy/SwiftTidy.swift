import CTidy
import Foundation

public enum TidyError: Error {
    case parse(Int, String)
    case cleanAndRepair(Int, String)
}

extension CTidy.Bool {
    static let no = CTidy.Bool(rawValue: 0)
    static let yes = CTidy.Bool(rawValue: 1)
}

public class Document {
    public static let defaultConfiguration: [String: String] = [
        "wrap": "0",
        "doctype": "omit",
        "show-body-only": "auto",
        "output-html": "yes"
    ]

    let document: TidyDoc!

    public init(_ configuration: [String: String] = Document.defaultConfiguration) {
        document = tidyCreate()
        tidyOptSetBool(document, TidyForceOutput, .yes)
        for (key, value) in configuration {
            tidyOptParseValue(document, key, value)
        }
    }

    deinit {
        tidyRelease(document)
    }

    public func clean(_ html: String) throws -> String {
        var errorBuffer: TidyBuffer = TidyBuffer()
        tidyBufInit(&errorBuffer)
        defer {
            tidyBufFree(&errorBuffer)
        }
        tidySetErrorBuffer(document, &errorBuffer)

        var outputBuffer: TidyBuffer = TidyBuffer()
        tidyBufInit(&outputBuffer)
        defer {
            tidyBufFree(&outputBuffer)
        }

        tidySetInCharEncoding(document, "utf-8")
        tidySetOutCharEncoding(document, "utf-8")

        var returnCode = tidyParseString(document, html)
        guard returnCode >= 0 else {
            throw TidyError.parse(Int(returnCode), String(cString: errorBuffer.bp))
        }

        returnCode = tidyCleanAndRepair(document)
        guard returnCode >= 0 else {
            throw TidyError.cleanAndRepair(Int(returnCode), String(cString: errorBuffer.bp))
        }

        tidySaveBuffer(document, &outputBuffer)
        return String(cString: outputBuffer.bp)
    }
}
