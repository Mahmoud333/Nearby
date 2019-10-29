//
//  ViewController.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import UIKit
import IHProgressHUD
import NVActivityIndicatorView

class NearByListViewController: UIViewController {
    
    var presenter: NearByListPresenterProtocol!
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorsImageView: UIImageView!
    var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActivityIndicator()
        setupTableView()
        presenter.viewDidLoad()
    }
    
    private func setupActivityIndicator() {
        let size = CGFloat(50.0)
        let frame = CGRect(x: self.view.frame.size.width + size / 2, y: self.view.frame.size.height + size / 2, width: size, height: size)
        activityIndicator = NVActivityIndicatorView(frame: frame)
    }
    
    private func setupUI() {
        self.title = presenter.viewControllerTitle()
        setupRightButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "NearByListCell", bundle: .main), forCellReuseIdentifier: "NearByListCell")
        tableView.estimatedRowHeight = 90
    }
    
    private func setupRightButton() {
        let currentMode = Defaults.shared.getListType()
        let nextMode: NearByListPresenter.ListType = currentMode == .singleUpdate ? .realTime : .singleUpdate
        let button = UIBarButtonItem(title: nextMode.userDefaultsValues, style: .done, target: self, action: #selector(didTapRightNavigationButton(_:)))
        self.navigationItem.rightBarButtonItem = button
    }
}

//MARK:- Actions
extension NearByListViewController {
    @objc func didTapRightNavigationButton(_ sender: Any?) {
        if Defaults.shared.getListType() == .singleUpdate {
            Defaults.shared.setListType(type: .realTime)
            presenter.viewDidLoad()
            setupUI()
        } else if Defaults.shared.getListType() == .realTime {
            Defaults.shared.setListType(type: .singleUpdate)
            presenter.viewDidLoad()
            setupUI()
        }
    }
}

//MARK:- NearByListViewProtocol
extension NearByListViewController: NearByListViewProtocol {
    func showLoadingIndicator() {
        //IHProgressHUD.show()
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        IHProgressHUD.dismiss()
        activityIndicator.stopAnimating()
    }
    
    func reloadData() {
        if presenter.numberOfRows() == 0 {
            errorsImageView.isHidden = false
        } else {
            errorsImageView.isHidden = true
        }
        tableView.reloadData()
    }
    
    func setErrorsImage(named: String) {
        errorsImageView.isHidden = false
        errorsImageView.image = UIImage(named: named)
    }
}

//MARK:- TableView
extension NearByListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearByListCell", for: indexPath) as! NearByListCell
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
}


