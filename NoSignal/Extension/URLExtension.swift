//
//  URLExtension.swift
//  NoSignal
//
//  Created by student9 on 2021/12/22.
//

import Foundation

extension URL {
    var fileName: String? {
        guard isFileURL else {
            return nil
        }
        
        return lastPathComponent
    }
    var fileNameWithoutExtension: String? {
        guard isFileURL else {
            return nil
        }
        
        return deletingPathExtension().lastPathComponent
    }
    var fileSize: Int? {
        try? resourceValues(forKeys: [.fileSizeKey]).fileSize
    }
}
