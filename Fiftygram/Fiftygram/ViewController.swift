//
//  ViewController.swift
//  Fiftygram
//
//  Created by Salman Faris on 22/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    let context = CIContext()  // for Core Image
    var originalImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func choosePhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        navigationController?.present(picker, animated: true)
    }
    
    
    @IBAction func applySepia() {
        guard let filter = CIFilter(name: Filter.sepia.rawValue) else { return }
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        displayInImageView(with: filter)
    }
    
    
    @IBAction func applyNoir() {
        guard let filter = CIFilter(name: Filter.noir.rawValue) else { return }
        displayInImageView(with: filter)
        
    }
    
    
    @IBAction func applyVintage() {
        guard let filter = CIFilter(name: Filter.vintage.rawValue) else { return }
        displayInImageView(with: filter)
    }
    
    
    func displayInImageView(with filter: CIFilter) {
        guard let originalImage = originalImage else { return }
        filter.setValue(CIImage(image: originalImage), forKey: kCIInputImageKey)
        
        // Actually applying the filter
        guard let output = filter.outputImage else { return }
        guard let imageToCg = self.context.createCGImage(output, from: output.extent) else { return }
        imageView.image = UIImage(cgImage: imageToCg)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = image
        originalImage = image
    }
}
