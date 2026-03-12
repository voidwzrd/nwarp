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

func runCommand(_ command: String) -> Any {
    let process = Process()

    process.arguments = [command]

    try? process.run()
    process.waitUntilExit()

    return process.terminationStatus
}
