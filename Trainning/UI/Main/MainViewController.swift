//
//  MainViewController.swift
//  altar
//
//  Created by Tri on 2020/08/22.
//

import UIKit

class MainViewController: BaseVC<MainViewModel>, UITabBarControllerDelegate {

    private var tabBarVC: UITabBarController?
    private lazy var homeVC = HomeViewController.instance()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        tabBarVC = segue.destination as? UITabBarController
        tabBarVC?.delegate = self

        guard let navRoot = tabBarVC?.viewControllers?.first as? UINavigationController else { return }
        let firstVC = self.initFirstVC(0)
        navRoot.viewControllers.append(firstVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNav()
    }

    override func setupView() {
        super.setupView()
    }

    override func bindView() {
        super.bindView()
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex

        guard let navRoot = viewController as? UINavigationController else { return }
        
        if (navRoot.viewControllers.isEmpty) {
            let firstVC = self.initFirstVC(index)
            navRoot.viewControllers.append(firstVC)
        }
    }

    private func initFirstVC(_ index: Int) -> UIViewController {
        var vc: UIViewController!
        switch index {
        case 0:
            vc = homeVC
            break
        case 1:
            vc = homeVC
            break
        case 2:
            vc = homeVC
            break
        case 3:
            vc = homeVC
            break
        default:
            break
        }
        return vc
    }
}

extension MainViewController {
    
    static func instance() -> MainViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateVC(ofType: MainViewController.self)
        let vm = MainViewModel()
        vc.bindViewModel(with: vm)
        return vc
    }
}
