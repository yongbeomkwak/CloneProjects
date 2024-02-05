//
//  ViewController.swift
//  StopWatch
//
//  Created by yongbeomkwak on 2/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    var isPlay: Bool = false
    var laps: [String] = []
    
    var counter: Double = .zero
    var timer: Timer = .init()
    
    

    var mainTimerLabel : UILabel = {
        let view = UILabel()
        
        view.text = "00:00:00"
        view.textColor = .black
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 60)
        
        
        return view
    }()
    
    var leftButton: UIButton = {
        
        let view = UIButton()
       
        view.setTitle("Reset",for: .normal)
        view.setTitleColor(.black, for: .normal)
        
        view.setTitle("Lap", for: .disabled)
        view.setTitleColor(.lightGray, for: .disabled)
        
        return view
    }()
    
    var rightButton: UIButton = {
       
        let view = UIButton()
        
        view.setTitle("Start", for: .normal)
        view.setTitleColor(.green, for: .normal)
        
        return view
    }()
    
    var tableView : UITableView = {
        
        let view = UITableView()
      
        view.register(LapTableViewCell.self, forCellReuseIdentifier: LapTableViewCell.id)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayout()
        bindEvent()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        leftButton.isEnabled = false
        
        tableView.backgroundColor = .red
  
    }


}

extension ViewController {
    
    func addSubviews() {
        self.view.addSubviews(mainTimerLabel,leftButton,rightButton,tableView)
    }
    
    func setLayout() {
        
        mainTimerLabel.setHorizon(constant: .zero)
        mainTimerLabel.setTop(anchor: self.view.safeAreaLayoutGuide.topAnchor, constant: 60)
        
        leftButton.setTop(anchor: self.mainTimerLabel.bottomAnchor, constant: 30)
        leftButton.setLeading(anchor: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80)
        
        rightButton.setTop(anchor: self.mainTimerLabel.bottomAnchor, constant: 30)
        rightButton.setTrailing(anchor: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        
        
        tableView.setTop(anchor: self.rightButton.bottomAnchor, constant: 20)
        tableView.setHorizon(constant: .zero)
        tableView.setBottom(anchor: self.view.bottomAnchor, constant: -20)
        
    }
    
    
    fileprivate func changeButton(_ button: UIButton, _ title: String, _ titleColor: UIColor){
        
        tableView.reloadData()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
    
    fileprivate func resetTimer() {
        timer.invalidate()
        counter = .zero
        mainTimerLabel.text = "00:00:00"
    }
    
    func updateTimer() {
        counter += 0.035
        
        var minutes: String = "\((Int)(counter / 60))"
        if (Int)(counter / 60) < 10 {
          minutes = "0\((Int)(counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (counter.truncatingRemainder(dividingBy: 60)))  // Double, Float의 나머지값을 구함
        if counter.truncatingRemainder(dividingBy: 60) < 10 {
          seconds = "0" + seconds
        }
        
        mainTimerLabel.text = minutes + ":" + seconds
    }
    
    func bindEvent() {
        rightButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(lapReset), for: .touchUpInside)
    }
    
    
    
    //  objc
    
    @objc func playPause() {
        leftButton.isEnabled = true
        
        changeButton(leftButton, "Lap", .black)
        
        if !isPlay {
            
            unowned let weakSelf = self
            
            timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            
            isPlay = true
            changeButton(rightButton, "Stop", .red)
            
        } else {
            timer.invalidate()
            
            isPlay = false
            
            changeButton(rightButton, "start", .green)
            changeButton(leftButton, "Reset", .black)
        }
        
    }
    
    @objc func lapReset() {
        if !isPlay {
            resetTimer()
            laps.removeAll()
            changeButton(leftButton, "Lap", .black)
            leftButton.isEnabled = false
            
        } else {
            if let timerLabelText = mainTimerLabel.text {
                laps.append(timerLabelText)
            }
            tableView.reloadData()

        }
    }
    
    @objc func updateMainTimer() {
        updateTimer()
    }
    

}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LapTableViewCell.id, for: indexPath) as? LapTableViewCell else {
            
            return UITableViewCell()
        }
        
        let index = indexPath.row
        
        
        cell.update("Lap\(laps.count-index)", laps[laps.count - index-1])
        
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
}
