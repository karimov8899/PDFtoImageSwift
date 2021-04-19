//
//  ViewController.swift
//  PDFReader
//
//  Created by Dave on 4/19/21.
//

import UIKit
import SnapKit
import MobileCoreServices

class ViewController: UIViewController, UIDocumentPickerDelegate {

    //UI Elements
    
    let openFile: UIButton = {
        let btn = UIButton()
        btn.setTitle("Open", for: .normal)
        btn.backgroundColor = .black
        return btn
    }()
    
    //Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(openFile)
        openFile.addTarget(self, action: #selector(openPdf), for: .touchUpInside)
        openFile.snp.makeConstraints{(make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
         
    }

    // Открытие Файлового Менеджера
    
    @objc func openPdf(sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension ViewController {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let vc = PdfVC()
        vc.selectedUrl = selectedFileURL
        navigationController?.pushViewController(vc, animated: true)
        
    } 
}



//        func savePDFtoImg(page: Int) {
//            guard let page = pdfDocument.page(at: page) else { return }
//            // Fetch the page rect for the page we want to render.
//            let pageRect = page.bounds(for: .mediaBox)
//
//            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//            let img = renderer.image { ctx in
//                // Set and fill the background color.
//                UIColor.white.set()
//                ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))
//
//                // Translate the context so that we only draw the `cropRect`.
//                ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)
//
//                // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
//                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
//
//                // Draw the PDF page.
//                page.draw(with: .mediaBox, to: ctx.cgContext)
//            }
//            UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//        }
//
//        for page in 0...allPages {
//            savePDFtoImg(page: page)
//        }
