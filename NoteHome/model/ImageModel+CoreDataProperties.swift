	//
//  ImageModel+CoreDataProperties.swift
//  NoteHome
//
//  Created by Nor on 03/02/1400 AP.
//
//

import Foundation
import CoreData


extension ImageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModel> {
        return NSFetchRequest<ImageModel>(entityName: "ImageModel")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var image: String
    @NSManaged public var date: String

}

extension ImageModel : Identifiable {

}
