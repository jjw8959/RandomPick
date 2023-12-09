//
//  ViewController.swift
//  RandomPick
//
//  Created by woong on 11/21/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adjustNumber: UIStepper!
    @IBOutlet weak var peopleCountLabel: UILabel!
    var peopleCount = 0
    var names = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        peopleCount = Int(sender.value)
        peopleCountLabel.text = Int(sender.value).description
        tableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
    }
    
    @IBAction func startRandomPick(_ sender: Any) {
        if peopleCount == 0 {
            let alert = UIAlertController(title: "경고", message: "사람이 0명?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            return
        }
        names.remove(at: 0)
        for i in 0..<peopleCount {
            let index = IndexPath(row: i, section: 0)
            let cell: CustomTableViewCell = self.tableView.cellForRow(at: index) as! CustomTableViewCell
            if let name = cell.nameField.text {
                if name == ""{
                    let alert = UIAlertController(title: "경고", message: "이름이 비는디??", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                    self.present(alert, animated: true, completion: nil)
                    names = [""]
                    return
                }
                names.append(name)
            }
        }
        var runCount = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            self.nameLabel.text = self.names.randomElement()
            runCount += 1
            print(runCount)
            if runCount == self.peopleCount * 10 {
                timer.invalidate()
            }
        }
    }
}
        

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        return cell
    }
    
    
}

