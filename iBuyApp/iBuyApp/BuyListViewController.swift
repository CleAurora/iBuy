//
//  BuyListViewController.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 30/10/20.
//

import UIKit

class BuyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productSearchBar: UISearchBar!


    var arrayProducts = [Product]()
    var arrayCompleted = [Product]()
    var arrayOpen = [Product]()
    var arrayFiltered = [Product]()
    
    var index: Int?

    @IBAction func AddActionTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Criar", message: "Digite o nome do item", preferredStyle: .alert)
        var productTextField: UITextField?
        let saveAction = UIAlertAction(title: "Salvar", style: .default, handler: { (action) in
            if let textField = productTextField, let text = textField.text, textField.hasText {
                self.arrayProducts.append(Product(name: text, isCompleted: false))
                self.loadFilters()
            }
        })

        alertController.addTextField { (textField) in
            productTextField = textField
            textField.placeholder = "Ex: Maçã"
        }

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }

    func edit(product: Product) {
        let alertController = UIAlertController(title: "Criar", message: "Digite o nome do item", preferredStyle: .alert)
        var productTextField: UITextField?
        let saveAction = UIAlertAction(title: "Salvar", style: .default, handler: { (action) in
            if let textField = productTextField, let text = textField.text, textField.hasText {
                product.name = text
                self.loadFilters()
            }
        })

        alertController.addTextField { (textField) in
            productTextField = textField
            textField.text = product.name
            textField.placeholder = "Ex: Maçã"
        }

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        productSearchBar.delegate = self

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

        alert.addAction(UIAlertAction(title: markOption, style: .default) { (_) in
            product.isCompleted = !product.isCompleted
            self.loadFilters()
            self.tableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { (_) in
            self.delete(product: product)
        })

        alert.addAction(UIAlertAction(title: "Editar", style: .default) { (_) in
            self.edit(product: product)
        })

        self.present(alert, animated: true){}
    }

    func delete(product: Product) {
        let alertController = UIAlertController(
            title: "Atenção", message: "Tem certeza de que deseja apagar este item?",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { (_) in
            self.arrayProducts.removeAll { (currentProduct) -> Bool in
                product == currentProduct
            }
            self.loadFilters()
        }))

        alertController.addAction(UIAlertAction(title: "Não", style: .default))

        present(alertController, animated: true, completion: nil)
    }

    func loadFilters(){
        filterProducts(searchTyping: productSearchBar.text ?? "")
    }

    func filterProducts(searchTyping: String){
        arrayFiltered = arrayProducts
        arrayOpen = []
        arrayCompleted = []

        if !searchTyping.isEmpty {
            arrayFiltered = arrayProducts.filter {(product) -> Bool in
                return product.name.lowercased().contains(searchTyping.lowercased())
            }
        }

        arrayOpen = arrayFiltered.filter({ (product) -> Bool in
            product.isCompleted == false
        })

        arrayCompleted = arrayFiltered.filter({ (product) -> Bool in
            product.isCompleted == true
        })

        tableView.reloadData()
    }
}

extension BuyListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            openOptions(product: arrayOpen[indexPath.row])
        }else {
            openOptions(product: arrayCompleted[indexPath.row])
        }
    }
}

extension BuyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterProducts(searchTyping: searchText)
    }
}

extension BuyListViewController: UITableViewDataSource {
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
