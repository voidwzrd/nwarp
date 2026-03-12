// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

@main
struct Nwarp: ParsableCommand {
    func run() throws {
        let fm = FileManager.default
        let url = URL(fileURLWithPath: fm.currentDirectoryPath)

        let items = try fm.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        for item in items {
            let values = try item.resourceValues(forKeys: [.isDirectoryKey])
            // let directories = try? url.resourceValues(forKeys: [.isDirectoryKey])

            if values.isDirectory == true {
                print("📁 \(item.lastPathComponent)")
                print(checkIsGitRepo("\(item.lastPathComponent)"))

            }

            // return directories?.isDirectory == true ? url.lastPathComponent : "No"
        }


        // let fm: FileManager = FileManager.default

        // print(fm.homeDirectoryForCurrentUser)
        // print(NSUserName()) // Returns the logon name of the current user.

        // try? listDirectories()

        // listContents()

        // if isGitRepo {
        //     print("Checking repository...\n")

        //     let status = runGit(["status", "--short"])

        //     if status.isEmpty {
        //         print("Working directory clean")

        //     } else {
        //         print("Uncommited changes:")
        //         print(status)
        //     }

        //     let ahead = runGit(["rev-list", "--count", "origin/main..HEAD"])
        //     let behind = runGit(["rev-list", "--count", "HEAD..origin/main"])

        //     print(
        //         "\nCommits ahead of origin/main:",
        //         ahead.trimmingCharacters(in: .whitespacesAndNewlines)
        //     )
        //     print(
        //         "Commits behind origin/main:",
        //         behind.trimmingCharacters(in: .whitespacesAndNewlines))
        // } else {
        //     print("This is not a git repo")
        // }

    }
}
