import Foundation

// CHECK IF LOCAL DIRECTORIES CONTAIN GIT REPOS
func checkLocalDirectories() throws {
    let fileManager: FileManager = FileManager.default
    let path: URL = URL(fileURLWithPath: fileManager.currentDirectoryPath)

    let items = try fileManager.contentsOfDirectory(
        at: path,
        includingPropertiesForKeys: [.isDirectoryKey],
        options: [.skipsHiddenFiles])

    for item in items {
        let values: URLResourceValues = try item.resourceValues(forKeys: [.isDirectoryKey])

        if values.isDirectory == true {
            print("📁 \(item.lastPathComponent)")

            let isGitRepo = checkHasGitRepo("\(item.lastPathComponent)")

            if isGitRepo == true {
                checkIsGitDifferent("\(item.lastPathComponent)")
            }
        }
    }
}

func runCommand(_ command: String, path: String) -> String {
    let process = Process()
    let pipe = Pipe()

    process.executableURL = URL(fileURLWithPath: path)
    process.arguments = [command]
    process.standardOutput = pipe
    process.standardError = pipe

    try! process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8) ?? ""
}
