//
//  HomeViewModel.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

class HomeViewModel: BaseVM {
    
    let commonRepository: CommonRepository!
    
    var queryData = BehaviorRelay<String?>(value: nil)
    
    var isSearching = BehaviorRelay<Bool>(value: false)
    
    var userList = BehaviorRelay<[UserTest]>(value: [])
    
    var modleRequest = BaseModelRequest()
    
    override init() {
        self.commonRepository = CommonRepositoryImpl()
        self.modleRequest.query = "tran"
    }
    
    fileprivate func updateData(_ data: ([UserTest], PagingReponse?)) {
        // ---------
        // Dummy server not support paging
        var data = data
        var pagingReponse = PagingReponse()
        pagingReponse.currentPage = modleRequest.page
        pagingReponse.totalPages = 1000
        data.1 = pagingReponse
        // ---------
    
        self.hideLoading()
        
        var userList = self.userList.value
        
        if let paging = data.1 {
            self.modleRequest.page = paging.nextPage()
            self.modleRequest.totalPage = paging.totalPages
        }
        
        if (isLoadMore()) {
            userList.append(contentsOf: data.0)
        } else {
            userList = data.0
        }
        
        self.userList.accept(userList)
        self.pagingReponse.accept(data.1)
        self.updateLoadingType(with: .completed)
    }
}
    
extension HomeViewModel {
    
    func searchData(query: String?) {
        isSearching.accept(true)
        queryData.accept(query)
    }
    
    func initSearch() {
        queryData.asObservable()
            .filter({ $0?.isEmpty == false })
            .flatMapLatest({ [weak self] query -> Single<([UserTest], PagingReponse?)> in
                let query = query!
                Dlog.log("search " + String(describing: query))
                
                guard let self = self else { return Single.just(([], nil)) }
                self.modleRequest.resetData()
                self.modleRequest.query = query
                return self.commonRepository
                    .getUserList(modelRequest: self.modleRequest)
                    .catchErrorJustReturn(([], nil))
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                self.updateData(data)
                self.isSearching.accept(false)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.onError(with: error)
                self.userList.accept([])
                self.initSearch()
                self.isSearching.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchData() {
        showLoading()
        commonRepository.getUserList(modelRequest: self.modleRequest)
            .subscribe(onSuccess: { [weak self] data in
                guard let self = self else { return }
                self.updateData(data)
            },
            onError: { [weak self] error in
                self?.onError(with: error)
            })
            .disposed(by: disposeBag)
    }
    
    func loadMore() {
        self.updateLoadingType(with: .loadNext)
        self.fetchData()
    }
    
    func refreshData() {
        self.updateLoadingType(with: .refresh)
        self.modleRequest.page = Constants.API.PAGE_DEFAULT
        self.fetchData()
    }
}

