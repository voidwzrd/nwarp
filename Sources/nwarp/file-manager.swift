import Foundation

// CHECK IF PATH IS A DIRECTORY
func listDirectories() throws {
    let fm = FileManager.default
    let dir = URL(fileURLWithPath: fm.currentDirectoryPath)

    let items = try fm.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.isDirectoryKey])

    for item in items {
        let values = try item.resourceValues(forKeys: [.isDirectoryKey])

        if values.isDirectory == true {
            print("📁 \(item)")
            print(checkIsGitRepo("\(item)"))
            
        }
    }
}



// LIST CONTENTS OF CURRENT DIRECTORY
// func listContents() {
//     let fm = FileManager.default
//     let path = fm.currentDirectoryPath
    
//     try? checkIsDirectory()

//     do {
//         let contents = try fm.contentsOfDirectory(atPath: path)
//         contents.forEach {print(type(of: $0))}
//     } catch {
//         print("Error:", error)
//     }
// }



func hasFolderCount(_ expected: Int) -> Bool {

    let fileManager = FileManager.default
    let path = fileManager.currentDirectoryPath

    do {
        let contents = try fileManager.contentsOfDirectory(atPath: path)

        let folders = contents.filter { item in
            var isDir: ObjCBool = false
            let fullPath = (path as NSString).appendingPathComponent(item)
            fileManager.fileExists(atPath: fullPath, isDirectory: &isDir)
            return isDir.boolValue
        }

        return folders.count == expected

    } catch {
        print("Error reading directory:", error)
        return false
    }
}