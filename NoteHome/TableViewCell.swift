//
//  TableViewCell.swift
//  NoteHome
//
//  Created by Nor on 03/02/1400 AP.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtName:UILabel!
    @IBOutlet weak var txtDate:UILabel!
    @IBOutlet weak var mImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func onBind(_ mimage:ImageModel) {
        txtName.text = mimage.name
        txtDate.text = mimage.date
        
    
        
        
        let dataDecoded : Data = Data(base64Encoded: mimage.image, options: .ignoreUnknownCharacters)!

        mImage.image = UIImage(data: dataDecoded)
   
    }
    
    
}
