//
//  FileStorage.swift
//  Secure Gallery
//
//  Created by Артём Симан on 28.04.22.
//

import Foundation
import UIKit

class FileStorage {
    static func saveImage (_ image: UIImage?) {
        
        guard let image = image,
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let filename = UUID().uuidString
        
        let fileURL = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("png")
        
        guard let data = image.pngData() else { return }
        
        do {
            try data.write(to: fileURL)
            addFileName(filename)
        } catch {
            return
        }
    }
    
    static func getAllImages() -> [UIImage?] {
        var images: [UIImage?] = []
        let allNames = getFileNames()
        
        for filename in allNames {
            guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {continue}
            
            let fileURL = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("png")
            
            guard let saveData = try? Data(contentsOf: fileURL) else {continue}
            images.append(UIImage(data: saveData))
        }
        return images
    }
    
    private static func addFileName(_ filename: String) {
        let newArray = getFileNames() + [filename]
        setFileNames(newArray)
    }
    
    private static func getFileNames() -> [String] {
        guard let filenames = UserDefaults.standard.array(forKey: UserKeys.filenames.rawValue) as? [String] else {return [] }
        return filenames
    }
    
    private static func setFileNames(_ filenames: [String]) {
        UserDefaults.standard.set(filenames, forKey: UserKeys.filenames.rawValue)
    }
}

fileprivate enum UserKeys: String {
    case filenames
}
