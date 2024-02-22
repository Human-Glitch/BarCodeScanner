//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Kody Buss on 2/19/24.
//

import AVFoundation
import UIKit

enum CameraError: String {
	case invalidDeviceInput = "Something is wrong with the camera. We are unable to capture the input."
	case invalidScanValue = "The value scanned is invalid. This app scans EAN-8 and EAN-13."
}

protocol ScannerVCDelegate: AnyObject {
	func didFind(barcode: String)
	func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {
	let captureSession = AVCaptureSession()
	var previewLayer: AVCaptureVideoPreviewLayer?
	weak var scannerDelegate: ScannerVCDelegate?
	
	init(scannerDelegate: ScannerVCDelegate) {
		super.init(nibName: nil, bundle: nil)
		self.scannerDelegate = scannerDelegate
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCaptureSession()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		guard let previewLayer = previewLayer else {
			scannerDelegate?.didSurface(error: .invalidDeviceInput)
			return
		}
		
		previewLayer.frame = view.layer.bounds
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCaptureSession() {
		// Get the device if capable of video
		guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
			scannerDelegate?.didSurface(error: .invalidDeviceInput)
			return
		}
		
		// Get the device's video input
		let videoInput: AVCaptureDeviceInput
		
		do{
			try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
		} catch {
			scannerDelegate?.didSurface(error: .invalidDeviceInput)
			return
		}
		
		// Hook up video input to capture session
		if captureSession.canAddInput(videoInput) {
			captureSession.addInput(videoInput)
		} else {
			return
		}
		
		// Get the device's video output
		let metaDataOutput = AVCaptureMetadataOutput()
		
		// Hook up video output to capture session
		if captureSession.canAddOutput(metaDataOutput) {
			captureSession.addOutput(metaDataOutput)
			metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) // requires extension
			metaDataOutput.metadataObjectTypes = [.ean8, .ean13] // Look for 8 and 13 digit bar codes
		} else {
			return
		}
		
		// Assign capture session to the preview layer so it is visible
		previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		previewLayer!.videoGravity = .resizeAspectFill
		view.layer.addSublayer(previewLayer!)
		
		captureSession.startRunning() // must be activated before running
	}
}

// What we do with the video data aka scan barcode
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		guard let object = metadataObjects.first else {
			scannerDelegate?.didSurface(error: .invalidScanValue)
			return
		}
		
		guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
			scannerDelegate?.didSurface(error: .invalidScanValue)
			return
		}
		
		guard let barcode = machineReadableObject.stringValue else {
			scannerDelegate?.didSurface(error: .invalidScanValue)
			return
		}
		
		scannerDelegate?.didFind(barcode: barcode)
	}
}
