import Foundation

// CHECK IF PATH IS A DIRECTORY
func listDirectories() throws -> String {
    let fm = FileManager.default
    let url = URL(fileURLWithPath: fm.currentDirectoryPath)

    let items = try fm.contentsOfDirectory(at: url,
    includingPropertiesForKeys: [.isDirectoryKey],
    options: [.skipsHiddenFiles])

    for item in items {
        let values = try item.resourceValues(forKeys: [.isDirectoryKey])
        let directories  = try? url.resourceValues(forKeys: [.isDirectoryKey])



        if values.isDirectory == true {
            print("📁 \(item)")
            print(checkIsGitRepo("\(item)"))
            
        }

        return directories?.isDirectory == true ? url.lastPathComponent : "No"
    }

    return "Hello"
}



// LIST CONTENTS OF CURRENT DIRECTORYcd ..
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
