@testable import muterCore
import Quick
import Nimble
import Foundation

class FileOperationSpec: QuickSpec {
    override func spec() {
        describe("Logging Directory Creation") {
            it("creates a logging directory") {
                let fileManagerSpy = FileManagerSpy()
                let timestamp = DateComponents(
                    calendar: .init(identifier: .gregorian),
                    year: 2019,
                    month: 5,
                    day: 10,
                    hour: 2,
                    minute: 42
                )

                let loggingDirectory = createLoggingDirectory(in: "~/some/path",
                                                              fileManager: fileManagerSpy,
                                                              locale: Locale(identifier: "en_US"),
                                                              timestamp:  { timestamp.date! })

                expect(loggingDirectory).to(equal("~/some/path/muter_logs/May 10, 2019 at 2:42 AM"))
                expect(fileManagerSpy.methodCalls).to(equal(["createDirectory(atPath:withIntermediateDirectories:attributes:)"]))
                expect(fileManagerSpy.createsIntermediates).to(equal([true]))
                expect(fileManagerSpy.paths).to(equal(["~/some/path/muter_logs/May 10, 2019 at 2:42 AM"]))
            }
        }
    }
}
