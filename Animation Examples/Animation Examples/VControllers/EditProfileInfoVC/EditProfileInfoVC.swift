//
//  EditProfileInfoVC.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


protocol EditProfileInfoVCDelegate: AnyObject {
    func didTapSaveButton(with userInfoToSave: UserInfoToSave)
    func didTapVKButton()
}


final class EditProfileInfoVC: UIViewController {
    
    weak var delegate: EditProfileInfoVCDelegate?
    
    private(set) var uiConfig: EditProfileInfoVCUIConfig = .init()
    private let userInfo: UserInfo
    
    
//    MARK: lifecycle
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
//        uiConfig.containerView.setData(userInfo: userInfo)
    }
    
    required init?(coder: NSCoder) {
        self.userInfo = .spampleData
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        uiConfig.configureFrames()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        stopAnimatingLoad()
    }
}


extension EditProfileInfoVC {
    private func configure() {
        uiConfig.rootView = view
        uiConfig.configureUI()
        uiConfig.configureAutolayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        uiConfig.containerView.delegate = self
    }
}


extension EditProfileInfoVC {
    @objc func handleBackButton() {
//        pop()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(
//                top: 0, left: 0,
//                bottom: keyboardSize.height + Constants.offsetForKeyboardAppearance, right: 0
//            )
//            uiConfig.scrollView.contentInset = contentInsets
//            uiConfig.scrollView.scrollIndicatorInsets = contentInsets
//            
//            if let activeTextField = findActiveTextField() {
//                let rect = activeTextField.convert(activeTextField.bounds, to: uiConfig.scrollView)
//                uiConfig.scrollView.scrollRectToVisible(rect, animated: true)
//            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
//        uiConfig.scrollView.contentInset = .zero
//        uiConfig.scrollView.scrollIndicatorInsets = .zero
    }
}


extension EditProfileInfoVC {
    func setData(userInfo: UserInfo) {
        uiConfig.setData(userInfo: userInfo)
    }
    
    func startAnimatingLoad() {
//        uiConfig.loadingView.show()
    }
    
    func stopAnimatingLoad() {
//        uiConfig.loadingView.hide()
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}


extension EditProfileInfoVC {
//    private func findActiveTextField() -> EditProfileTextField? {
//        uiConfig.containerView.activeField
//    }
}

extension EditProfileInfoVC {
    
    enum Constants {
        
        static let offsetForKeyboardAppearance:         CGFloat     = 80
    }
}
