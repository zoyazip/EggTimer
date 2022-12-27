

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    let eggTimes = ["Soft": 3, "Medium": 9, "Hard": 27]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

    @IBAction func ButtonPressed(_ sender: UIButton) {
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
       
        TitleLabel.text = "You have choosed \(hardness)"
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        progressBar.progress = 0
        secondsPassed = 0
        
    }
    
    @objc func updateTimer(){
        if(secondsPassed < totalTime){
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            print(percentageProgress)
            progressBar.progress = percentageProgress
        }
        else {
            timer.invalidate()
            TitleLabel.text = "Finished"
            playSound()
        }
    }
    
    func playSound(){
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!)
        do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
    }
    
}
