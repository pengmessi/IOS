//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by new on 15/8/6.
//  Copyright (c) 2015年 pengmessi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLable: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordingLable.text = "Tap to Record"
        recordingLable.hidden = false
        microphoneButton.enabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func stopAudio(sender: UIButton) {
        recordingLable.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    @IBAction func touchMicrophoneButton(sender: UIButton) {
        recordingLable.text = "recording in progress"
        stopButton.hidden = false
        microphoneButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
            if (flag) {
                //1. save audio
                let recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
                //2. perform segue
                self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
            else {
                println("Recording is not successful")
                microphoneButton.enabled = true
                stopButton.hidden = true
            
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "stopRecording") {
                let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
                let data = sender as! RecordedAudio
                playSoundsVC.receivedAudio = data
            }
    }
}

