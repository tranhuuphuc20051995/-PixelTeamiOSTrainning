//
//  UserCell.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import UIKit

class UserCell: BaseUITableVIewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var userTapped: ((_ user: UserTest) -> Void)?
    
    var user: UserTest? {
        didSet {
            guard let user = user else { return }
            nameLabel.text = user.fullName
            
            addGestureRecognizer(tapGesture)
            
            tapGesture.rx.event
                .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
                .bind(onNext: { [weak self] recognizer in
                    guard let self = self, let user = self.user else { return }
                    self.userTapped?(user)
                })
                .disposed(by: disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
