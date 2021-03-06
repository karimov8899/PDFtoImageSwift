//
//  PdfVC.swift
//  PDFReader
//
//  Created by Dave on 4/19/21.
//

import UIKit
import SnapKit
import PDFKit
import MobileCoreServices
import PSPDFKit

class PdfVC: UIViewController {

    var selectedUrl = URL(fileURLWithPath: "")
    var allPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPDF()
        let img = UIBarButtonItem(title: "IMG", style: .plain, target: self, action: #selector(addTapped))
        let pdf = UIBarButtonItem(title: "PDF", style: .plain, target: self, action: #selector(addPDFTapped))
        navigationItem.rightBarButtonItems = [img, pdf]
    }
     
    //Открытие PDF файла
    
    func showPDF() {
        let pdfView: PDFView = {
            let pdfView = PDFView()
            pdfView.autoScales = true
            return pdfView
        }()
        
        view.addSubview(pdfView)
        view.backgroundColor = .black
        pdfView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        // Create a `PDFDocument` object and set it as `PDFView`'s document to load the document in that view.
        let pdfDocument = PDFDocument(url: URL(fileURLWithPath: selectedUrl.path))!
        pdfView.document = pdfDocument
        allPages  = pdfView.document?.pageCount ?? 0
    }
    
    // Логика для сохранения Изображений из PDF
    func pdfToImageLogic() {
        func savePDFtoImg(page: Int) {
            let url = URL(fileURLWithPath: selectedUrl.path)
            guard let document = CGPDFDocument(url as CFURL) else { return }
            guard let page = document.page(at: page) else { return }
            // Fetch the page rect for the page we want to render.
            let pageRect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            let img = renderer.image { ctx in
                // Set and fill the background color.
                UIColor.white.set()
                ctx.fill(pageRect)
                
                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                
                ctx.cgContext.drawPDFPage(page)
            }
            UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        for page in 0...allPages {
            savePDFtoImg(page: page)
        }
    }
//    func pdfToImageLogic() {
//        func savePDFtoImg(page: Int) {
//            let document = Document(url: selectedUrl)
//            let pageIndex: PageIndex = PageIndex(page)
//            guard let pageImageSize = document.pageInfoForPage(at: pageIndex)?.mediaBox.size else { return }
//
//            // Create a render request from your `Document`.
//            let request = MutableRenderRequest(document: document)
//            request.imageSize = pageImageSize
//            request.pageIndex = pageIndex
//
//            do {
//                // Create a render task using the `MutableRenderRequest`.
//                let task = try RenderTask(request: request)
//                task.priority = .utility
//                PSPDFKit.SDK.shared.renderManager.renderQueue.schedule(task)
//
//                // The page is rendered as a `UIImage`.
//                let image = try PSPDFKit.SDK.shared.cache.image(for: request, imageSizeMatching: [.allowLarger])
//                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//            } catch {
//                // Handle error.
//            }
//        }
//        for page in 0...allPages {
//            savePDFtoImg(page: page)
//        }
//    }
    
    func pdfToPDFLogic() {
        let pdfDocument = PDFDocument(url: URL(fileURLWithPath: selectedUrl.path))!
        
        func savingToPDF(pages: Int) {
            guard let page = pdfDocument.page(at: pages) else {return}
            let new = PDFDocument(data: page.dataRepresentation!)
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent("\(UUID().uuidString).pdf")
            do {
                try new?.write(to: fileURL)
                let ac = UIAlertController(title: "Saved!", message: "Your PDF pages saved.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            catch {
                print("Error: \(error)")
            }
        }
        
        for page in 0...allPages {
            savingToPDF(pages: page)
        }
    }
    
    //Обработка сохранения изображения
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // Логика Кнопки сохранить
    @objc func addTapped() {
        pdfToImageLogic()
    }
    
    @objc func addPDFTapped() {
        pdfToPDFLogic()
    }
}
