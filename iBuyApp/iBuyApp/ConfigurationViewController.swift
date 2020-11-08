//
//  ConfigurationViewController.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 08/11/20.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var configurationArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        configurationArray.append("Avaliar o app")
        configurationArray.append("Suporte")
        configurationArray.append("Relatar um problema por email")
    }
}

extension ConfigurationViewController: UITableViewDelegate{

}

extension ConfigurationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configurationArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigurationViewCell", for: indexPath) as! ConfigurationViewCell

        cell.setup(configuration: configurationArray[indexPath.row])

        return cell
    }
}
