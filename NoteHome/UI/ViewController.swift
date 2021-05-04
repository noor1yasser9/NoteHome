//
//  ViewController.swift
//  NoteHome
//
//  Created by Nor on 03/02/1400 AP.
//

import UIKit

class ViewController: UIViewController {

    var data:[ImageModel]  = []

    
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var mTable:UITableView!
    @IBAction func btnAddImage(_ sender: Any){
        

        let addImage = storyboard?.instantiateViewController(withIdentifier: "AddImageViewController") as! AddImageViewController

        
        addImage.onChange = self
        present(addImage, animated: true, completion: nil)
        
        
    }
    
    fileprivate func fetchData(){
        do{
            self .data = try db.fetch(ImageModel.fetchRequest())
            DispatchQueue.main.async {
                self.mTable.reloadData()
            }
        }catch{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
        	
        mTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        mTable.dataSource = self
        mTable.delegate = self
        
    }

    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.onBind(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let controller = storyboard.instantiateViewController(withIdentifier: "AddImageViewController") as! AddImageViewController
        controller.onChange = self
        controller.modleImage = data[indexPath.row]
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let lineToRemove = self.data[indexPath.row]
        
        do{
            try self.db.delete(lineToRemove)
            self.fetchData()
            mTable.reloadData()
        }catch{
            
        }
        
    }
    
    
}

extension ViewController : DataChange{
    func onChangeData() {
        fetchData()
    }
    
    
}
