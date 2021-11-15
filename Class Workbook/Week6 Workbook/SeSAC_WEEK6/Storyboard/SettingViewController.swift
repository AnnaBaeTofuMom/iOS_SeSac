//
//  SettingViewController.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/05.
//

import UIKit
import Zip
import MobileCoreServices


class SettingViewController: UIViewController {
    
    let fileManager = FileManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    //폴더 위치 가져오기
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        var urlPaths = [URL]()
        
        if let path = documentDirectoryPath() {
            
            
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
                
            } else {
                print("디폴트.렘 없음 안됨")
            }
            
        }
        
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive")
            print("filePath : \(urlPaths)")
            presentActivityViewController()
        }
        catch {
          print("Something went wrong")
        }
        
        presentActivityViewController()
        
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
         //1, 파일앱 열기
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true, completion:  nil)
        
    
        
    }
    

}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            do {
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress:", progress)
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile:", unzippedFile)
                })
            } catch {
                print("경로없음")
            }
        } else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress:", progress)
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile:", unzippedFile)
                })
            } catch {
                print("error")
            }
            
        }
    }
    
    
}
