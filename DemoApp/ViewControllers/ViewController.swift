//
//  ViewController.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fetchingView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel: MainListViewModel {
        return controller.viewModel
    }
    
    lazy var controller: MainListController = {
        return MainListController()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        initBinding()
        controller.start()
    }

    func initBinding() {
        viewModel.rowViewModel.addObserver { [weak self](rowViewModels) in
            self?.listTableView.reloadData()
        }
        
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.fetchingView.isHidden = false
            } else {
                self?.fetchingView.isHidden = true
            }
        }
        
        viewModel.error.addObserver { [weak self](errorString) in
            self?.showAlertWithError(errorMessage: errorString)
        }
        
        viewModel.title.addObserver { [weak self](title) in
            self?.title = title
        }
    }
    
    private func showAlertWithError(errorMessage:String) {
        let alert = UIAlertController(title: .emptyString, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK_title".localized, style: .default) { action in
        })
        self.present(alert, animated: true)
    }

    /**
     * Its for initial view setup
     */
    private func setUpViews() {
        
        self.listTableView.register(UINib(nibName: "PhotosCell", bundle: Bundle(for: PhotosCell.self)), forCellReuseIdentifier: PhotosCell.cellIdentifier())
        self.listTableView.estimatedRowHeight = 100
        self.listTableView.rowHeight = UITableView.automaticDimension
        let add = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        self.navigationItem.rightBarButtonItem = add
        
    }
    
    @objc func refreshTapped() {
        controller.refreshData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController, let indexPath =  self.listTableView.indexPathForSelectedRow{
            let rowModel = self.viewModel.rowViewModel.value[indexPath.row]
            if let photo = self.controller.getPhotosFrom(row: rowModel) {
                let detailController = DetailController()
                detailController.photo = photo
                destination.controller = detailController
            }
            self.listTableView.deselectRow(at: indexPath, animated: true)

        }
        
    }
}

//MARK: UITableView Datasource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowViewModel.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = self.viewModel.rowViewModel.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier:PhotosCell.cellIdentifier(), for: indexPath)
        
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        cell.accessoryType = .disclosureIndicator
        cell.layoutIfNeeded()
        return cell
    }
    
}

//MARK: UITableView Delegare
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}
