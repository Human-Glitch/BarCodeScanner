//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Kody Buss on 2/21/24.
//

import SwiftUI

// UIViewController -> Coordinator -> Swift UI
struct ScannerView: UIViewControllerRepresentable {
	@Binding var scannedCode: String // allows the bar code to reach the ui
	@Binding var alertItem: AlertItem?
	
	func makeUIViewController(context: Context) -> ScannerVC {
		ScannerVC(scannerDelegate: context.coordinator)
	}
	
	func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(scannerView: self)
	}
	
	// Coordinator listens for the Scanner VC Delegate
	final class Coordinator: NSObject, ScannerVCDelegate{
		private let scannerView: ScannerView
		
		init(scannerView: ScannerView) {
			self.scannerView = scannerView
		}
		
		func didFind(barcode: String) {
			scannerView.scannedCode = barcode
		}
		
		func didSurface(error: CameraError) {
			switch error{
				case .invalidScanValue:
					scannerView.alertItem = AlertContext.invalidScannedType
					
				case .invalidDeviceInput:
					scannerView.alertItem = AlertContext.invalidDeviceInput
			}
		}
	}
}
