final class XcodeReporter: Reporter {
    func projectCopyFinished(destinationPath: String) {
        print("Finished copying your project to a temporary directory for mutation testing")
        print("\nYou can find your copied project here:\n\n\(destinationPath.bold)")
        print("\nThis directory will also serve as a backup for any XCTest logs that are generated by running your test suite")
    }
    
    func newMutationTestOutcomeAvailable(outcomeWithFlush: MutationOutcomeWithFlush) {
        let outcome = outcomeWithFlush.mutation
        
        guard outcome.testSuiteOutcome == .passed else {
            return
        }

        print(outcomeIntoXcodeString(outcome: outcome))

        outcomeWithFlush.fflush()
    }
    
    func mutationTestingFinished(mutationTestOutcomes outcomes: [MutationTestOutcome.Mutation]) {
        print(report(from: outcomes))
    }
    
    func report(from outcomes: [MutationTestOutcome.Mutation]) -> String {
        let report = MuterTestReport(from: outcomes)
        return """
            Mutation score: \(report.globalMutationScore)
            Mutants introduced into your code: \(report.totalAppliedMutationOperators)
            Number of killed mutants: \(report.numberOfKilledMutants)
            """
    }

    private func outcomeIntoXcodeString(outcome: MutationTestOutcome.Mutation) -> String {
        // {full_path_to_file}{:line}{:character}: {error,warning}: {content}

        return "\(outcome.originalProjectPath):" +
            "\(outcome.point.position.line):\(outcome.point.position.column): " +
            "warning: " +
            "Your test suite did not kill this mutant: \(outcome.snapshot.description)"
    }
}
