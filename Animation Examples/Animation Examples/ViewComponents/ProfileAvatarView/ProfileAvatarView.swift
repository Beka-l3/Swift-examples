//
//  ProfileAvatarView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


protocol ProfileAvatarViewDelegate: AnyObject {
    func didTapOnCameraButton()
}


final class ProfileAvatarView: UIImageView {
    
    weak var delegate: ProfileAvatarViewDelegate?
    
    var imageUrl: String? { didSet { fetchImage() } }
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(Constants.cameraIcon, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCameraButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(with viewDimension: CGFloat, borderWidth: CGFloat = 0, isEditable: Bool = false) {
        self.init(frame: .zero)
        layer.cornerRadius = viewDimension / 2
        layer.borderWidth = borderWidth
        cameraButton.alpha = isEditable ? 1 : 0
        isUserInteractionEnabled = isEditable
    }
    
}


extension ProfileAvatarView {
    
    private func configure() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        backgroundColor = .gray
        layer.borderColor = UIColor.white.cgColor
        
        addSubview(cameraButton)
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: Constants.cameraButtonDimension),
            cameraButton.heightAnchor.constraint(equalToConstant: Constants.cameraButtonDimension),
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}


extension ProfileAvatarView {
    
    @objc func handleCameraButton() {
        delegate?.didTapOnCameraButton()
    }
}
    

extension ProfileAvatarView {
    
    private func fetchImage() {
        guard let imageUrl = imageUrl else {
            setNoImage()
            return
        }
        
        Task {
            do {
                self.image = try await getImage(from: imageUrl)
            } catch {
                setNoImage()
            }
        }
    }
    
    private func setNoImage() {
        image = nil
    }
    
    func getImage(from urlString: String) async throws -> UIImage {
        let data = try await getData(endpoint: urlString)
        
        guard let image = UIImage(data: data) else {
            throw ServiceError.badResponse
        }
        
//        cache.setObject(image, forKey: NSString(string: urlString))
        
        return image
    }
    
    private func getData(endpoint: String) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: endpoint) else {
                continuation.resume(throwing: ProfileAvatarView.ServiceError.badUrl)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    continuation.resume(throwing: ProfileAvatarView.ServiceError.badResponse)
                    return
                }
                
                guard let data = data else {
                    continuation.resume(throwing: ProfileAvatarView.ServiceError.invalidData)
                    return
                }
                
                return continuation.resume(returning: data)
            }
            
            task.resume()
        }
    }
}


extension ProfileAvatarView {

    enum Constants {
        
        static let cameraIcon:                      UIImage?    = UIImage(systemName: "camera")
        static let cameraButtonDimension:           CGFloat     = 60
    }
    
    enum ServiceError: String, Error {
        
        case badUrl = "Oops. Seems like gihub.com server is not responding"
        case badResponse = "Server could not find a data about followers of this user"
        case invalidData = "Server sent invalid data. Please, try again later"
    }
}


