//
//  CameraService.swift
//  iPocket
//
//  Created by KAMA . on 22.05.2025.
//

import AVFoundation

protocol CameraServiceProtocol: AnyObject {
    var captureSession: AVCaptureSession { get set }
    var output: AVCapturePhotoOutput { get set }
    
    func setupCaptureSession()
    func stopSession()
    func switchCamera()
}

class CameraService: CameraServiceProtocol {
    
    var captureSession: AVCaptureSession = AVCaptureSession()
    var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    
    private var captureDevice: AVCaptureDevice?
    private let cameraQueue = DispatchQueue(label: "ru.kama.CaptureQueue")
    
    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    
    private var backInput: AVCaptureDeviceInput!
    private var frontInput: AVCaptureDeviceInput!
    private var isBackCamera = true
    
    func setupCaptureSession() {
        cameraQueue.async { [weak self] in
            self?.captureSession.beginConfiguration()
            if (self?.captureSession.canSetSessionPreset(.photo)) != nil {
                self?.captureSession.sessionPreset = .photo
            }
            self?.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            self?.setInputs()
            self?.setOutputs()
            
            self?.captureSession.commitConfiguration()
            self?.captureSession.startRunning()
        }
    }
    
    private func setInputs() {
        backCamera = currentDevice()
        frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        
        guard let backCamera = backCamera,
              let frontCamera = frontCamera else { return }
        
        do {
            backInput = try AVCaptureDeviceInput(device: backCamera)
            guard captureSession.canAddInput(backInput) else { return }
            
            frontInput = try AVCaptureDeviceInput(device: frontCamera)
            guard captureSession.canAddInput(frontInput) else { return }
            
            captureSession.addInput(backInput)
            captureDevice = backCamera
            
        } catch {
            fatalError("Not connected camera")
        }
        
    }
    
    private func setOutputs() {
        guard captureSession.canAddOutput(output) else { return }
        output.maxPhotoQualityPrioritization = .balanced
        captureSession.addOutput(output)
    }
    
    private func currentDevice() -> AVCaptureDevice? {
        let sessionDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTripleCamera, .builtInDualCamera, .builtInWideAngleCamera, .builtInDualWideCamera], mediaType: .video, position: .back)
        
        guard let device = sessionDevice.devices.first else { return nil }
        return device
    }
    
    func stopSession() {
        captureSession.stopRunning()
        captureSession.removeInput(backInput)
        captureSession.removeInput(frontInput)
        isBackCamera = true
    }
    
    func switchCamera() {
        captureSession.beginConfiguration()
        if backCamera != nil {
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
            captureDevice = frontCamera
            isBackCamera = false
        } else {
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
            captureDevice = backCamera
            isBackCamera = true
        }
        captureSession.commitConfiguration()
    }
    
}


