//
//  FontManager.swift
//  altar
//
//  Created by Tri on 2020/10/02.
//

class FontManager: NSObject {
    
    static let SIZE_DEFAULT: CGFloat = 16
    
    static let shared = FontManager()

    var fontSize = BehaviorRelay<CGFloat>(value: 0)
    
    private override init() {
        super.init()
        let fontSize = AppManager.shared.userDefault.integer(forKey: .FONT_SIZE)
        self.fontSize.accept(CGFloat(fontSize))
    }
    
    func setFontSize(size: CGFloat) {
        AppManager.shared.userDefault.set(size, forKey: .FONT_SIZE)
        self.fontSize.accept(size)
    }
    
    func getFontSize() -> Int {
        let size = fontSize.value == 0 ? FontManager.SIZE_DEFAULT : fontSize.value
        return Int(size)
    }
    
}
