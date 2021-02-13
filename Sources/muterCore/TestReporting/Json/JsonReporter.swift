import Foundation

final class JsonReporter: Reporter {
    func mutationTestingFinished(mutationTestOutcomes outcomes: [MutationTestOutcome.Mutation]) {
        print(report(from: outcomes))
    }
    
    func report(from outcomes: [MutationTestOutcome.Mutation]) -> String {
        let report = MuterTestReport(from: outcomes)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let encoded = try? encoder.encode(report),
            let json = String(data: encoded, encoding: .utf8) else {
                return ""
        }
        
        return json
    }
}
