//
//  CameraView.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import UIKit
import AVFoundation

protocol CameraViewProtocol: AnyObject {
    
}

class CameraView: UIViewController, CameraViewProtocol {

    var presenter: CameraViewPresenterProtocol!
    
    private lazy var shotsCollectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "shotCell")
        $0.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        
        return $0
    }(UICollectionView(frame: CGRect(x: 0, y: 60, width: view.frame.width - 110, height: 60), collectionViewLayout: UICollectionViewFlowLayout()))
    
    private lazy var closeButton: UIButton = {
        $0.setBackgroundImage(.closeIcon, for: .normal)
        
        return $0
    }(UIButton(frame: CGRect(x: view.frame.width - 60, y: 60, width: 25, height: 25), primaryAction: presenter.closeViewAction))
    
    private lazy var shotButton: UIButton = {
        $0.setBackgroundImage(.shotBtn, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: view.center.x - 30, y: view.frame.height - 110, width: 60, height: 60), primaryAction: shotAction))
    
    private lazy var shotAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .auto
        self.presenter.cameraService.output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    private lazy var switchCamera: UIButton = {
        $0.setBackgroundImage(.switchCamera, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: shotButton.frame.origin.x - 60, y: shotButton.frame.origin.y + 17.5, width: 25, height: 25), primaryAction: presenter.switchCameraAction))
    
    private lazy var nextButton: UIButton = {
        $0.setTitle("Далее", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 17.5
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UIButton(frame: CGRect(x: shotButton.frame.origin.x + 90, y: shotButton.frame.origin.y + 12.5, width: 100, height: 35)))
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.cameraService.setupCaptureSession()
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.post(name: .hideTabBar, object: nil, userInfo: ["isHide" : true])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()
        setupPreviewLayer()
        
        view.addSubview(shotsCollectionView)
        view.addSubview(closeButton)
        view.addSubview(shotButton)
        view.addSubview(switchCamera)
        view.addSubview(nextButton)

    }
    
    private func checkPermissions() {
        let cameraStatusAuth = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraStatusAuth {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { auth in
                if !auth {
                    abort()
                }
            }
        case .restricted, .denied:
            abort()
        case .authorized:
            return
        default:
            fatalError()
        }
    }
    
    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: presenter.cameraService.captureSession)
        
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    private func getImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 60, height: 60)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }
}

extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        if let image = UIImage(data: imageData) {
            presenter.photos.append(image)
            self.shotsCollectionView.reloadData()
        }
    }
    
}

extension CameraView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shotCell", for: indexPath)
      
        let photo = presenter.photos[indexPath.item]
        let imageView = self.getImageView(image: photo)
        
        cell.addSubview(imageView)
        return cell
    }
    
    
}
