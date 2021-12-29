//
//  SportsCustomCell.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//

import UIKit

class SportsCustomCell: UITableViewCell { //UIImagePickerController
    
    // MARK: - Outlets
    @IBOutlet weak var lbSport: UILabel!
    @IBOutlet weak var ivSport: UIImageView!
    
    // MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    let imageVC = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func btnAddImage(_ sender: UIButton) {
    }
    
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        ivSport.image = image
        picker.dismiss(animated: true, completion: nil)
        saveContext()
    }
    
    func importImage() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
     
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                //imagePickerController.delegate = self
                //self.imageVC(imagePickerController, animated: true, completion: nil)
            }
    }*/
}
