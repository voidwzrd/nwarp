// The Swift Programming Language
// https://docs.swift.org/swift-book

// nwarp is just prawn spelled backwards

import Foundation
import ArgumentParser

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

        print("\nCommits ahead of origin/main:", ahead.trimmingCharacters(in: .whitespacesAndNewlines))
        print("Commits behind origin/main:", behind.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
