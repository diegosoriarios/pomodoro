//
//  InterfaceController.swift
//  pomodoro-watch WatchKit Extension
//
//  Created by diego.rios on 26/11/19.
//  Copyright © 2019 diego.rios. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    @IBOutlet weak var button: WKInterfaceButton!
    @IBOutlet weak var pause: WKInterfaceButton!
    
    var seconds = 60
    
    var timer = Timer()
    
    var isTimeRunning = false
    var resumeTapped = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        pause.setEnabled(false)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(InterfaceController.updateTimer)), userInfo: nil, repeats: true)
        isTimeRunning = true
        pause.setEnabled(true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        } else {
            seconds -= 1
            timeLabel.setText(timeString(time: TimeInterval(seconds)))
        }
    }
 

    @IBAction func startTimer() {
        if isTimeRunning == false {
            runTimer()
            self.button.setEnabled(false)
        }
    }
    
    @IBAction func pauseTimer() {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pause.setTitle("Resume")
        } else {
            runTimer()
            self.resumeTapped = false
            self.pause.setTitle("Pause")
        }
    }
    
    @IBAction func resetTimer() {
        timer.invalidate()
        seconds = 0
        timeLabel.setText(timeString(time: TimeInterval(seconds)))
        
        isTimeRunning = false
        pause.setEnabled(false)
        button.setEnabled(true)
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}
