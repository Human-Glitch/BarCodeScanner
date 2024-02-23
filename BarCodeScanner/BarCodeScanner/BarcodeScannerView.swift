//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Kody Buss on 2/18/24.
//

import SwiftUI

struct BarcodeScannerView: View {
	
	@StateObject var viewModel = BarCodeScannerViewModel()
	
	var body: some View {
		NavigationStack{
			VStack(spacing: 20) {
				Spacer()
				
				ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
					.frame(maxWidth: .infinity, maxHeight: 300)
				
				Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
					.font(.title)
				
				Text(viewModel.statusText)
					.font(.largeTitle)
					.foregroundStyle(viewModel.statusTextColor)
					.bold()
				
				Spacer()
			}
			.navigationTitle("Barcode Scanner")
			.alert(item: $viewModel.alertItem) { alertItem in
				Alert(
					title: Text(alertItem.title),
					message: Text(alertItem.message),
					dismissButton: alertItem.dismissButton)
				
			}
		}
	}
}

#Preview {
	BarcodeScannerView()
}
