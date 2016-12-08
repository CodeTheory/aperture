//
//  AudioDeviceList.swift
//  aperture
//
//  Created by Khaled Garbaya on 30/11/2016.
//  Copyright © 2016 Wulkano. All rights reserved.
//

//: Playground - noun: a place where people can play

import Cocoa
import CoreAudio
import Foundation
import AVFoundation
import AudioToolbox

class AudioDeviceList {

func getInputDevices() -> NSString? {

    var inputDevices: [[String:String]] = []
    let captureDevices: [AnyObject] = AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio) as [AnyObject]

    for device in captureDevices {
      inputDevices.append([
        "id": device.uniqueID,
        "name":device.localizedName
      ])
    }

    do {
        let parsedData = try JSONSerialization.data(withJSONObject: inputDevices, options: [])
        return NSString(data: parsedData, encoding: String.Encoding.utf8.rawValue)
    } catch _ as NSError {
        return nil
    }
}

}
