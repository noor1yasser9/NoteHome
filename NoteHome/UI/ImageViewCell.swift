//
//  ImageViewCell.swift
//  NoteHome
//
//  Created by Nor on 03/02/1400 AP.
//

import UIKit

class ImageViewCell: UITableViewCell {

    
    
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

    
    func onBind(_ image:ImageModel) {
        txtName.text = image.name!
        txtDate.text = image.date!
   
    }
    
}
