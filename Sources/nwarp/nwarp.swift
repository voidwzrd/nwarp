// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

func runGit(_ args: [String]) -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
    process.arguments = args

    let pipe = Pipe()
    process.standardOutput = pipe

    try? process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8) ?? ""
}


@main
struct Nwarp: ParsableCommand {
    func run() throws {
        let isGitRepoResponse: String = runGit(["rev-parse", "--is-inside-work-tree"])
        let isGitRepo: Bool =
            isGitRepoResponse.trimmingCharacters(in: .whitespacesAndNewlines) == "true"
            ? true : false

        // print(listContents())
        listContents()

        // if hasFolderCount(3) {
        //     print("Directory contains exactly 3 folders")
        // } else {
        //     print("Different number of folders")
        // }

        if isGitRepo {
            print("Checking repository...\n")

            let status = runGit(["status", "--short"])

            if status.isEmpty {
                print("Working directory clean")

            } else {
                print("Uncommited changes:")
                print(status)
            }

            let ahead = runGit(["rev-list", "--count", "origin/main..HEAD"])
            let behind = runGit(["rev-list", "--count", "HEAD..origin/main"])

            print(
                "\nCommits ahead of origin/main:",
                ahead.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            print(
                "Commits behind origin/main:",
                behind.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            print("This is not a git repo")
        }

    }
}
