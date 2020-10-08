//
//  BaseVM.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

public class BaseVM {
    
    var disposeBag = DisposeBag()
    
    lazy var isLoading = PublishSubject<Bool>()
    lazy var error = PublishSubject<Error>()
    
    lazy var loadingType = BehaviorRelay<LoadingType>(value: .fetch)
    lazy var pagingReponse = BehaviorRelay<PagingReponse?>(value: nil)

    func showLoading() {
        if isCanShowLoading() {
            isLoading.onNext(true)
        }
    }
    
    func hideLoading() {
        isLoading.onNext(false)
    }
    
    func onError(with error: Error) {
        self.loadingType.accept(.completed)
        self.hideLoading()
        self.error.onNext(error)
    }
    
    func updateLoadingType(with type: LoadingType) {
        self.loadingType.accept(type)
    }
    
}

extension BaseVM {
    
    func isCanShowLoading() -> Bool {
        let value = self.loadingType.value
        return value == .fetch || value == .refresh
    }
    
    func isLoadMore() -> Bool {
        let value = self.loadingType.value
        return value == .loadNext || value == .loadPrevious
    }
}
