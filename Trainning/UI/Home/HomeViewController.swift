//
//  HomeViewController.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import UIKit

class HomeViewController: BaseVC<HomeViewModel> {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: BaseTableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(ofType: UserCell.self)
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func setupView() {
        super.setupView()
        hideNav()
        
        searchTextField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter({ !$0.isEmpty })
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                self.viewModel.searchData(query: query)
            })
            .disposed(by: disposeBag)
        
        viewModel.initSearch()
        viewModel.fetchData()
    }
    
    override func bindView() {
        super.bindView()
    
        viewModel.userList
            .asDriver()
            .drive(onNext: { [weak self] userListt in
                guard let self = self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        tableView.refreshAction = { [weak self]  in
            guard let self = self else { return }
            self.viewModel.refreshData()
        }
        
        viewModel.isSearching
            .asDriver()
            .distinctUntilChanged()
            .do(onNext: { [weak self] isSearching in
                guard let self = self else { return }
                self.tableView.isHidden = isSearching
                self.indicatorView.isHidden = !isSearching
            })
            .drive(onNext: { [weak self] isSearching in
                guard let self = self else { return }
                if (isSearching) {
                    self.indicatorView.startAnimating()
                } else {
                    self.indicatorView.stopAnimating()
                }
            })
            .disposed(by: self.disposeBag)
        
        tableView.didReachBottomAction = { [weak self] scrollView in
            guard let self = self else { return }
            self.viewModel.loadMore()
        }
        
        viewModel.loadingType
            .bind(to: tableView.loadingType)
            .disposed(by: self.disposeBag)
        
        viewModel.pagingReponse
            .bind(to: tableView.pagingInfo)
            .disposed(by: self.disposeBag)
    }
}

extension HomeViewController {
    
    static func instance() -> HomeViewController {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateVC(ofType: HomeViewController.self)
        let vm = HomeViewModel()
        vc.bindViewModel(with: vm)
        return vc
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath: indexPath) as UserCell
        let user = viewModel.userList.value[indexPath.row]
        cell.user = user
        cell.userTapped = { [weak self] user in
            Dlog.log(user)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.didScroll(scrollView)
    }
}


