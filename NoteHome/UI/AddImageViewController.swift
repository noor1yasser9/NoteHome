//
//  AddImageViewController.swift
//  NoteHome
//
//  Created by Nor on 03/02/1400 AP.
//

import UIKit



class AddImageViewController: UIViewController {
    
    
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtDate:UITextField!
    @IBOutlet weak var mImage:UIImageView!
    @IBOutlet weak var btnAdd :UIButton!
    var imageS: String!
    
    var onChange:DataChange!
    
    var modleImage:ImageModel?
    
    
    @IBAction func btnAdd(_ sender:UIButton){
        
        if modleImage == nil {
            modleImage = ImageModel(context: db)
        }
       
        modleImage!.name = txtName.text!
        modleImage!.date = txtDate.text!
        modleImage!.image = imageS
        
        do{
            try self.db.save()
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                self.onChange.onChangeData()
            }
        }catch{
            
        }
    }
    @IBAction func btnImage(_ sender:Any){
        let packerPhoto = UIImagePickerController()
        packerPhoto.sourceType = .photoLibrary
        packerPhoto.delegate = self
        DispatchQueue.main.async {
            self.present(packerPhoto, animated: true, completion: nil)
        }
    }
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
        txtDate.inputView = datePicker
    
        datePicker.addTarget(self, action: #selector(onTextDateChange(_:)), for: .valueChanged)
                
        
        if modleImage != nil {
            txtName.text = modleImage!.name
            txtDate.text = modleImage!.date
        
            let dataDecoded : Data = Data(base64Encoded: modleImage!.image, options: .ignoreUnknownCharacters)!

            mImage.image = UIImage(data: dataDecoded)
            
            btnAdd.setTitle("Update", for: .normal)
        }
  
    }
    
    @objc func onTextDateChange(_ date:UIDatePicker){
        
        let formater = DateFormatter()
        formater.dateFormat = "MM/DD/YYYY mm:ss:hh"
        
        txtDate.text = formater.string(from: date.date)
        
    }
    
}

extension AddImageViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        mImage.image = info[.originalImage] as? UIImage
   
        
        let image : UIImage = info[.originalImage] as?  UIImage ?? UIImage()
        let imageData:NSData = image.pngData()! as NSData
        imageS = imageData.base64EncodedString(options: .lineLength64Characters)
     
        dismiss(animated: true, completion: nil)
    }
    
  
    
    
}
protocol DataChange {
    func onChangeData()
}
