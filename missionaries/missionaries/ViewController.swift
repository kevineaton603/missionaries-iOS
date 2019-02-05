//
//  ViewController.swift
//  missionaries
//
//  Created by Eaton, Kevin on 2/5/19.
//  Copyright © 2019 Eaton, Kevin. All rights reserved.
//

import UIKit
/**
 * This idea came from...
 * https://stackoverflow.com/questions/34882746/generic-function-to-output-to-uitextfield-or-uilabel
 */
protocol setText {
    func setText(repeatingValue: String, count: Int) -> String
}
extension setText {
    func setText(repeatingValue:String, count: Int) -> String {
        let res = String(repeating: repeatingValue, count: count)
        return res
    }
}
extension UILabel:setText{
    func setUILabelText(repeatingValue: String, count:Int ) {
        self.text = setText(repeatingValue: repeatingValue, count:count)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var WestMissionaries: UIButton!
    @IBOutlet weak var WestCannibals: UIButton!
    @IBOutlet weak var EastMissionaries: UILabel!
    @IBOutlet weak var EastCannibals: UILabel!
    @IBOutlet weak var WestPassengers: UILabel!
    @IBOutlet weak var EastPassengers: UILabel!
    @IBOutlet weak var WestBoat: UILabel!
    @IBOutlet weak var EastBoat: UILabel!
    public var GameState = Position(boatOnWestBank: true, westMissionaries: 3, eastMissionaries: 0, westCannibals: 3, eastCannibals: 0, boatMissionaries: 0, boatCannibals: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
        GameState.westCannibals-=1
        GameState.eastCannibals+=1
        updateDisplay()
    }
    func updateDisplay(){
        WestMissionaries.setTitle(String(repeating: "⛪️", count:GameState.westMissionaries), for: .normal)
        WestCannibals.setTitle(String(repeating: "🔪", count: GameState.westCannibals), for: .normal)
        EastMissionaries.setUILabelText(repeatingValue: "⛪️", count:GameState.eastMissionaries)
        EastCannibals.setUILabelText(repeatingValue: "🔪", count: GameState.eastCannibals)
        let boatMissionariesString = String(repeating: "⛪️", count: GameState.boatMissionaries)
        let boatCannibalsString = String(repeating: "🔪", count: GameState.boatCannibals)
        if GameState.boatOnWestBank{
            WestBoat.setUILabelText(repeatingValue: "🛶", count: 1)
            EastBoat.setUILabelText(repeatingValue: "", count: 1)
            WestPassengers.setUILabelText(repeatingValue: boatCannibalsString + boatMissionariesString, count: 1)
            EastPassengers.setUILabelText(repeatingValue: "", count: 1)
        }
        else {
            EastBoat.setUILabelText(repeatingValue: "🛶", count: 1)
            EastPassengers.setUILabelText(repeatingValue: boatCannibalsString + boatMissionariesString, count: 1)
            WestPassengers.setUILabelText(repeatingValue: "", count: 1)
        }
    }
    @IBAction func WestMissionariesClick(_ sender: UIButton) {
        if(GameState.boatOnWestBank && GameState.onBoat() < 2){
            GameState.westMissionaries-=1
            GameState.boatMissionaries+=1
        }
        updateDisplay()
    }
    
    
}
struct Position {
    var boatOnWestBank: Bool
    var westMissionaries: Int
    var eastMissionaries: Int
    var westCannibals: Int
    var eastCannibals: Int
    var boatMissionaries: Int
    var boatCannibals:Int
    func onBoat()->Int{
        return boatMissionaries + boatCannibals
    }
    
    func moveEast(missionariesOnBoat: Int, cannibalsOnBoat: Int){
        
    }
    func moveWest(missionariesOnBoat: Int, cannibalsOnBoat: Int){
        
    }
}
