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

// RUN GIT
func runGitSideQuest(args: [String]) {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
    process.arguments = args
    // process.currentDirectoryURL = URL(fileURLWithPath: path)

    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    try! process.run()
    process.waitUntilExit()
}

func checkIsGitDifferent(_ path: String) {
    runGitSideQuest(args: ["-C", "\(path)", "fetch", "origin"])
    runGitSideQuest(args: ["-C", "\(path)", "diff", "--quiet", "main", "origin/main"])

    let response = runCommand("echo $?", path: path)
    print(response)

    // print(type(of: runCommand("echo $?")))

    if response == "0" {
        print("There are no changes between local and remote")
    } else if response == "1" {
        print("Yes, local repo is different from remote")
    } else {
        print("Unknown error? Line 33")
    }

    // return result.trimmingCharacters(in: .whitespacesAndNewlines) == "true" ? true : false
}

func checkHasGitRepo(_ dir: String) -> Bool {
    let result = runGit(args: ["-C", "\(dir)", "rev-parse", "--is-inside-work-tree"])
    return result.trimmingCharacters(in: .whitespacesAndNewlines) == "true" ? true : false
}
