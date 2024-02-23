//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Kody Buss on 2/22/24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
	var id: UUID = UUID()
	let title: String
	let message: String
	let dismissButton: Alert.Button
}

struct AlertContext {
	static let invalidDeviceInput = AlertItem(
		title: "Invalid Device Input",
		message: "Something is wrong with the camera. We are unable to capture the input.",
		dismissButton: .default(Text("OK")))
	
	static let invalidScannedType   = AlertItem(
		title: "Invalid Scan Type",
		message: "The value scanned is invalid. This app scans EAN-8 and EAN-13.",
		dismissButton: .default(Text("OK")))
}
