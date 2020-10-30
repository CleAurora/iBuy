//
//  BuyListViewController.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 30/10/20.
//

import UIKit

class BuyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var arrayProducts = [Product]()
    var arrayCompleted = [Product]()
    var arrayOpen = [Product]()

    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        arrayProducts.append(Product(name: "Maçã", isCompleted: false))
        arrayProducts.append(Product(name: "Pera", isCompleted: false))
        arrayProducts.append(Product(name: "Uva", isCompleted: false))
        arrayProducts.append(Product(name: "Suco", isCompleted: true))
        arrayProducts.append(Product(name: "Açucar", isCompleted: true))
        arrayProducts.append(Product(name: "Arroz", isCompleted: true))

        loadFilters()

    }

    func openOptions(product: Product){
        let alert = UIAlertController(title: "Opções", message: "Selecione a opção desejada", preferredStyle: .actionSheet)

        var markOption = "Marcar como concluído"
        if product.isCompleted{
            markOption = "Marcar como aberto"
        }

        alert.addAction(UIAlertAction(title: markOption, style: .default) { (UIAlertAction) in
            product.isCompleted = !product.isCompleted
            self.loadFilters()
            self.tableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in

        })
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { (UIAlertAction) in
        //criar modal para confirmar exclusão do item
        })

        alert.addAction(UIAlertAction(title: "Editar", style: .default) { (UIAlertAction) in

        })



        self.present(alert, animated: true){}
    }

    func loadFilters(){
        arrayOpen = []
        arrayCompleted = []
        arrayCompleted = arrayProducts.filter { (product) -> Bool in
            return product.isCompleted == true
        }

        arrayOpen = arrayProducts.filter { (product) -> Bool in
            return product.isCompleted == false
        }

    }
}

extension BuyListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            openOptions(product: arrayOpen[indexPath.row])
        }else {
            openOptions(product: arrayCompleted[indexPath.row])
        }

        //index = indexPath.row
        //openOptions(product: array[])
        //let cell = tableView.cellForRow(at: indexPath) as? ListViewCell
        //print(cell?.nameLabel.text)
        //print(indexPath.section)
    }

}

extension BuyListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrayOpen.count
        }
        else {
            return arrayCompleted.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        if indexPath.section == 0 {
            cell.setup(product: arrayOpen[indexPath.row])
        }else {
            cell.setup(product: arrayCompleted[indexPath.row])
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {

            return "Abertos"
        }
        else {
            return "Concluidos"
        }
    }


}
