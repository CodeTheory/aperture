// Exit codes:
// 1: some argument is missing ¯\_(ツ)_/¯
// 2: bad crop rect coordinates
// ?: ¯\_(ツ)_/¯

import Foundation
import AVFoundation

let numberOfArgs = Process.arguments.count;
if (numberOfArgs != 3 && numberOfArgs != 4) {
	print("usage: main destinationPath fps [crop rect coordinates]")
	print("examples: main ./file.mp4 30");
	print("          main ./file.mp4 30 0:0:100:100");
	exit(1);
}

let destinationPath = Process.arguments[1];
let fps = Process.arguments[2];

var coordinates = [];
if (numberOfArgs == 4) {
	coordinates = Process.arguments[3].componentsSeparatedByString(":");
	if (coordinates.count - 1 != 3) { // number of ':' in the string
		print("The coordinates for the crop rect must be in the format 'originX:originY:width:height'");
		exit(2);
	}
}

let recorder = Recorder(fps: fps);

recorder.start(destinationPath, coordinates: coordinates as! [String]);

setbuf(__stdoutp, nil);

readLine();

recorder.stop();
