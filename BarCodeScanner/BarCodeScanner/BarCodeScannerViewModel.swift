//
//  BarCodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Kody Buss on 2/22/24.
//

import SwiftUI

final class BarCodeScannerViewModel: ObservableObject
{
	@Published var scannedCode: String = ""
	@Published var alertItem: AlertItem?
	
	var statusText: String {
		scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
	}
	
	var statusTextColor: Color {
		scannedCode.isEmpty ? .red : .green
	}
}
