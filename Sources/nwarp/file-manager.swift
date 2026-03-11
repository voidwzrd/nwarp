import Foundation

// func run(_ count: Int) -> Bool {
//     let fm = FileManager.default
//     let currentPath = fm.currentDirectoryPath
// }


// LIST CONTENTS OF CURRENT DIRECTORY
func listContents() {
    let fm = FileManager.default
    let path = fm.currentDirectoryPath

    do {
        let contents = try fm.contentsOfDirectory(atPath: path)
        // return contents.joined(separator: "\n")
        contents.forEach {print($0)}

        // for content in contents {
        //     // print(type(of: content))
        //     return content
        // }
    } catch {
        print("Error:", error)
    }
}



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