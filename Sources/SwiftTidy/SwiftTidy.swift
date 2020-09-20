import CTidy

class Document {
    var document: TidyDoc!
    var text: String { "Hello, World!" }

    init() {
        document = tidyCreate()
    }

    func clean(_ html: String) throws {
        tidySetInCharEncoding(document, "utf-8")
        tidySetOutCharEncoding(document, "utf-8")

    }

    deinit {
        tidyRelease(document)
        document = nil
    }
}
