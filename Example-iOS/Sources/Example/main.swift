import Foundation
import AVFoundation
import Aperture

let url = URL(filePath: "../screen-recording-ios.mp4")
do {
	let recorder = Aperture.Recorder()

	let devices = Aperture.Devices.iOS()

	guard let device = devices.first else {
		print("Could not find any iOS devices")
		exit(1)
	}

	print("Available iOS devices:", devices.map(\.name).joined(separator: ", "))

	try await recorder.start(
		target: .externalDevice,
		options: Aperture.RecordingOptions(
			destination: url,
			targetID: device.id,
			losslessAudio: true,
			recordSystemAudio: true,
			microphoneDeviceID: Aperture.Devices.audio().first?.id
		)
	)
	print("Recording screen for 5 seconds")

	try await Task.sleep(for: .seconds(5))
	print("Stopping recording")

	try await recorder.stop()
	print("Finished recording:", url.path)
	exit(0)
} catch let error as Aperture.Error {
	print("Aperture Error: \(error.localizedDescription)")
	exit(1)
} catch {
	print("Unknown Error: \(error.localizedDescription)")
	exit(1)
}
