//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Kody Buss on 2/21/24.
//

import SwiftUI

// UIViewController -> Coordinator -> Swift UI
struct ScannerView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> ScannerVC {
		ScannerVC(scannerDelegate: context.coordinator)
	}
	
	func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator()
	}
	
	// Coordinator listens for the Scanner VC Delegate
	final class Coordinator: NSObject, ScannerVCDelegate{
		func didFind(barcode: String) {
			print(barcode)
		}
		
		func didSurface(error: CameraError) {
			print(error.rawValue)
		}
	}
}

#Preview {
    ScannerView()
}
