import Foundation

// RUN GIT
func runGit(args: [String]) -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
    process.arguments = args
    // process.currentDirectoryURL = URL(fileURLWithPath: path)

    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    try! process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8) ?? ""
}

func checkIsGitRepo(_ dir: String) -> Bool {
    let result = runGit(args: ["-C", "\(dir)", "rev-parse", "--is-inside-work-tree"])
    return result.trimmingCharacters(in: .whitespacesAndNewlines) == "true" ? true : false
}