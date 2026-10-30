import Foundation

public enum SupportedAudioFile: String, CaseIterable, Sendable {
    case mp3, m4a, aac, wav, aif, aiff, caf, flac

    public static let extensions = Set(allCases.map(\.rawValue))
}

public struct LocalFolderImporter: Sendable {
    public init() {}

    /// Recursively enumerates supported audio files in a folder the user has
    /// explicitly selected. The app target must manage iOS security-scoped
    /// access/bookmarks around this call.
    public func audioFiles(in directoryURL: URL) throws -> [URL] {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: directoryURL.path, isDirectory: &isDirectory),
              isDirectory.boolValue else {
            throw FolderImportError.notDirectory
        }

        guard let enumerator = FileManager.default.enumerator(
            at: directoryURL,
            includingPropertiesForKeys: [.isRegularFileKey, .isHiddenKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants]
        ) else {
            throw FolderImportError.cannotEnumerate
        }

        var files: [URL] = []
        for case let url as URL in enumerator {
            let values = try url.resourceValues(forKeys: [.isRegularFileKey, .isHiddenKey])
            guard values.isRegularFile == true,
                  values.isHidden != true,
                  SupportedAudioFile.extensions.contains(url.pathExtension.lowercased()) else {
                continue
            }
            files.append(url)
        }
        return files.sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }
    }
}

public enum FolderImportError: Error, Equatable {
    case notDirectory
    case cannotEnumerate
}
