//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by new on 15/8/6.
//  Copyright (c) 2015年 pengmessi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithRate(2.0)
    }
    
    func playAudioWithRate(rate: Float){
        stopAllAudio()
        
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    
    @IBAction func pressStop(sender: UIButton) {
        stopAllAudio()
    }
    
    @IBAction func playChipmonkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
         
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        
        audioEngine.stop()
        audioEngine.reset()
    }

}
