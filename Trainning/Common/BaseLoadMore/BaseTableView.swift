//
//  BaseTableView.swift
//  altar
//
//  Created by Tri on 2020/09/17.
//

import UIKit

enum LoadingType {
    case fetch
    case refresh
    case loadNext
    case loadPrevious
    case completed
}

class BaseTableView: UITableView {
        
    private let disposeBag = DisposeBag()

    //MARK: - refresh
    var tableRefreshControl: UIRefreshControl?
    var refreshAction: (() -> Void)? {
        didSet {
            tableRefreshControl = UIRefreshControl()
            tableRefreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            self.addSubview(tableRefreshControl!)
        }
    }
    
    @objc func refreshData() {
        refreshAction?()
    }
    
    //MARK: - reachedTop
    var topOffset: CGFloat = 0
    
    private lazy var _reachedTop: Bool = {
        return self.contentOffset.y < self.topOffset
    }()
    
    fileprivate(set) var reachedTop: Bool {
        set {
            let oldValue = _reachedTop
            _reachedTop = newValue
            if _reachedTop == oldValue  || _reachedTop == true {
                return
            }
            didReachTopAction?(self)
        }
        get {
            return _reachedTop
        }
    }
    public var didReachTopAction: ((UIScrollView) -> ())?
    
    //MARK: - reachedBottom
    var bottomOffset: CGFloat = 0
    
    private lazy var _reachedBottom: Bool = {
        let maxScrollDistance = max(0, self.contentSize.height - self.bounds.size.height)
        return self.contentOffset.y >= (maxScrollDistance + self.bottomOffset)
    }()
    
    fileprivate(set) var reachedBottom: Bool {
        set {
            let oldValue = _reachedBottom
            _reachedBottom = newValue
            if _reachedBottom == oldValue || _reachedBottom == true {
                return
            }
            didReachBottomAction?(self)
        }
        get {
            return _reachedBottom
        }
    }
    public var didReachBottomAction: ((UIScrollView) -> ())? {
        didSet {
            configLoadMore()
        }
    }
    
    //MARK: - loadMore
    var loadingType =  BehaviorRelay<LoadingType>(value: .fetch)
    var pagingInfo = BehaviorRelay<PagingReponse?>(value: nil)
    var canLoadMore = BehaviorRelay<Bool>(value: true)
    
    private var loadMoreView: LoadMoreView?
    
    func configLoadMore() {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
        self.loadMoreView = LoadMoreView(frame: frame)
                     
        loadingType.asObservable()
            .skip(1)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self ] type in
                Dlog.log("loadingType: " + String(describing: type))
                
                guard let self = self else { return }
                switch type {
                case .refresh:
                    self.tableRefreshControl?.beginRefreshing()
                case .loadNext:
                    self.loadMoreView?.showLoading()
                case .completed:
                    if let tableRefreshControl = self.tableRefreshControl, tableRefreshControl.isRefreshing {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            tableRefreshControl.endRefreshing()
                        }
                    }
                        self.loadMoreView?.hideLoading()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        pagingInfo.asObservable()
            .skip(1)
            .observeOn(MainScheduler.instance)
            .map { pagingInfo -> Bool in
                guard let pagingInfo = pagingInfo else {
                    return false
                }
                return pagingInfo.isCanLoadMore()
            }
            .bind(to: canLoadMore)
            .disposed(by: disposeBag)
        
        canLoadMore.asObservable()
            .skip(1)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (canLoadMore) in
                Dlog.log("canLoadMore: " + String(describing: canLoadMore))

                guard let self = self else { return }
                if canLoadMore {
                    self.tableFooterView = self.loadMoreView
                } else {
                    self.tableFooterView = nil
                }
            })
            .disposed(by: disposeBag)
    }
}

extension BaseTableView {
    
    func didScroll(_ scrollView: UIScrollView) {
        if (!canLoadMore.value) {
            return
        }
        let hasContent = scrollView.contentSize.height > 0
        self.reachedTop = scrollView.contentOffset.y < topOffset && hasContent

        let maxScrollDistance = max(0, scrollView.contentSize.height - scrollView.bounds.size.height)
        self.reachedBottom = scrollView.contentOffset.y >= (maxScrollDistance + self.bottomOffset) && hasContent
    }
}
