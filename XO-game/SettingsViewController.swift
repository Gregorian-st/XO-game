//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let gameSettings = GameSettings.instance
    
    @IBOutlet weak var gameTypeControl: UISegmentedControl!
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    
    @IBAction func gameTypeControlDidChange(_ sender: UISegmentedControl) {
        gameSettings.gameType = GameType(rawValue: sender.selectedSegmentIndex) ?? .classic
    }
    @IBAction func gameModeControlDidChange(_ sender: UISegmentedControl) {
        gameSettings.gameMode = GameMode(rawValue: sender.selectedSegmentIndex) ?? .humanVsHuman
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTypeControl.selectedSegmentIndex = gameSettings.gameType.rawValue
        gameModeControl.selectedSegmentIndex = gameSettings.gameMode.rawValue
    }
    
}
