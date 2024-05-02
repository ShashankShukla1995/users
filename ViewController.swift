//
//  ViewController.swift
//  Posts
//
//  Created by Shashank Shukla on 02/05/24.
//

import UIKit

class ViewController: UIViewController {
    var viewModel = ViewModel()
    var count = 1
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
    }
    
    override func viewDidLayoutSubviews() {
        viewModel.getUsers(count: 1, completion: { result in
            switch(result) {
            case .success(let _):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        if viewModel.users.count > 1 {
            cell.titleLabel.text = viewModel.users[indexPath.row].title
            cell.userIdLabel.text = String(viewModel.users[indexPath.row].userID)
            cell.idLabel.text = String(viewModel.users[indexPath.row].id)
            cell.bodyLabel.text = viewModel.users[indexPath.row].body
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == viewModel.users.count - 1 {
                count += 1
                viewModel.getUsers(count: count, completion: { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Failed to fetch more users: \(error)")
                    }
                })
            }
        }
    
}

