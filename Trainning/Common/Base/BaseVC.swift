//
//  BaseVC.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

public class BaseVC<VM: BaseVM>: UIViewController {

    let disposeBag = DisposeBag()

    var viewModel: VM!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()
    }

    open func setupView() { }
    open func bindView() { }

    func bindViewModel(with viewModel: VM) {
        self.viewModel = viewModel
        self.initError()
        self.initLoading()
    }

    private func initError() {
        viewModel.error.asObserver()
            .subscribe(onNext: { [weak self] error in
                Dlog.log("--------------BaseVC Error--------------")
                Dlog.log(error)

                if let error = error as? APIError {
                    switch error {
                    case .server(let errorReponse):
                        break
                    case .unknown(let json):
                        break
                    default:
                        break
                    }
                }

                guard let error = error.asAFError else { return }
                Dlog.log(error.errorDescription ?? "")
                Dlog.log(error.responseCode ?? "")
            })
            .disposed(by: self.disposeBag)
    }

    private func initLoading() {
        viewModel.isLoading
            .asObserver()
            .subscribe(onNext: { isLoading in
                if (isLoading) {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: self.disposeBag)
    }

    deinit {
        Dlog.log("deinit------------------")
        Dlog.log(String(describing: type(of: self)))
    }
}
