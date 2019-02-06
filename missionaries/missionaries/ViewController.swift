//
//  ViewController.swift
//  missionaries
//
//  Created by Eaton, Kevin on 2/5/19.
//  Copyright © 2019 Eaton, Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var WestMissionaries: UIButton!
    @IBOutlet weak var WestCannibals: UIButton!
    @IBOutlet weak var EastMissionaries: UIButton!
    @IBOutlet weak var EastCannibals: UIButton!
    @IBOutlet weak var WestPassengers: UIButton!
    @IBOutlet weak var EastPassengers: UIButton!
    @IBOutlet weak var WestBoat: UIButton!
    @IBOutlet weak var EastBoat: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Crosses: UILabel!
    @IBOutlet weak var WinLoss: UILabel!
    public var GameState = Position(boatOnWestBank: true, westMissionaries: 3, eastMissionaries: 0, westCannibals: 3, eastCannibals: 0, boatMissionaries: 0, boatCannibals: 0, crosses: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    func disableButtons(){
        EastBoat.isEnabled = false
        WestBoat.isEnabled = false
        
    }
    func isValid()->Bool{
        if(GameState.boatOnWestBank){
            if((GameState.westMissionaries + GameState.boatMissionaries < GameState.westCannibals + GameState.boatCannibals && GameState.westMissionaries != 0) || GameState.eastMissionaries < GameState.eastCannibals && GameState.eastMissionaries != 0){
                return false
            }
        }
        else{
            if ((GameState.eastMissionaries + GameState.boatMissionaries < GameState.eastCannibals + GameState.boatCannibals && GameState.eastMissionaries != 0) || (GameState.westMissionaries < GameState.westCannibals && GameState.westMissionaries != 0)) {
                return false
            }
        }
        
        return true
    }
    func isWin()->Bool{
        if(GameState.westMissionaries == 0 && GameState.westCannibals == 0 && GameState.eastMissionaries == 0 && GameState.eastCannibals == 0){
            return true
        }
        else{
            return false
        }
    }
    func resetGame(){
        GameState = Position(boatOnWestBank: true, westMissionaries: 3, eastMissionaries: 0, westCannibals: 3, eastCannibals: 0, boatMissionaries: 0, boatCannibals: 0, crosses: 0)
    }
    func updateDisplay(){
        WestMissionaries.setTitle(String(repeating: "⛪️", count:GameState.westMissionaries), for: .normal)
        WestCannibals.setTitle(String(repeating: "🔪", count: GameState.westCannibals), for: .normal)
        EastMissionaries.setTitle(String(repeating: "⛪️", count:GameState.eastMissionaries), for: .normal)
        EastCannibals.setTitle(String(repeating: "🔪", count: GameState.eastCannibals), for: .normal)
        let boatMissionariesString = String(repeating: "⛪️", count: GameState.boatMissionaries)
        let boatCannibalsString = String(repeating: "🔪", count: GameState.boatCannibals)
        if GameState.boatOnWestBank{
            WestBoat.setTitle(String(repeating: "🛶", count: 1), for: .normal)
            EastBoat.setTitle(String(repeating: "", count: 1), for: .normal)
            WestPassengers.setTitle(String(repeating: boatCannibalsString + boatMissionariesString, count: 1), for: .normal)
            EastPassengers.setTitle(String(repeating: "", count: 1), for: .normal)
        }
        else {
            EastBoat.setTitle(String(repeating: "🛶", count: 1), for: .normal)
            WestBoat.setTitle(String(repeating: "", count: 1), for: .normal)
            EastPassengers.setTitle(String(repeating: boatCannibalsString + boatMissionariesString, count: 1), for: .normal)
            WestPassengers.setTitle(String(repeating: "", count: 1), for: .normal)
        }
        Crosses.text = String(GameState.crosses)
        if(isValid()){
            if(isWin()){
                WinLoss.text = "You Won!"
            }
            else{
                WinLoss.text = nil
            }
        }
        else{
            WinLoss.text = "You Lost!"
        }
    }
    
    @IBAction func WestMissionariesClick(_ sender: UIButton) {
        if(GameState.boatOnWestBank && GameState.onBoat() < 2){
            GameState.westMissionaries-=1
            GameState.boatMissionaries+=1
        }
        updateDisplay()
    }
    
    @IBAction func WestCannibalsClick(_ sender: Any) {
        if(GameState.boatOnWestBank && GameState.onBoat() < 2){
            GameState.westCannibals-=1
            GameState.boatCannibals+=1
        }
        updateDisplay()
    }
    

    @IBAction func EastMissionariesClick(_ sender: Any) {
        if(!GameState.boatOnWestBank && GameState.onBoat() < 2){
            GameState.eastMissionaries-=1
            GameState.boatMissionaries+=1
        }
        updateDisplay()
    }
    
    @IBAction func EastCannibalsClick(_ sender: Any) {
        if(!GameState.boatOnWestBank && GameState.onBoat() < 2){
            GameState.eastCannibals-=1
            GameState.boatCannibals+=1
        }
        updateDisplay()
    }
    @IBAction func WestBoatClick(_ sender: Any) {
        if(GameState.onBoat() > 0){
            GameState.moveEast()
            updateDisplay()
        }
        
    }
    @IBAction func EastBoatClick(_ sender: Any) {
        if(GameState.onBoat() > 0){
            GameState.moveWest()
            updateDisplay()
        }
    }
    @IBAction func EastPassengers(_ sender: UIButton) {
        if(!GameState.boatOnWestBank){
            if(sender.currentTitle != nil && sender.currentTitle != ""){
                var title = sender.currentTitle?.description
                let char =  title?.removeLast()
                if(char == "⛪️"){
                    GameState.eastMissionaries+=1
                    GameState.boatMissionaries-=1
                }
                else if(char == "🔪"){
                    GameState.eastCannibals+=1
                    GameState.boatCannibals-=1
                }
                updateDisplay()
            }
        }
        
    }
    @IBAction func WestPassengers(_ sender: UIButton) {
        if(GameState.boatOnWestBank){
            if(sender.currentTitle != nil && sender.currentTitle != ""){
                var title = sender.currentTitle?.description
                let char =  title?.removeLast()
                if(char == "⛪️"){
                    GameState.westMissionaries+=1
                    GameState.boatMissionaries-=1
                }
                else if(char == "🔪"){
                    GameState.westMissionaries+=1
                    GameState.boatCannibals-=1
                }
                updateDisplay()
            }
        }

    }
    @IBAction func ResetGameClick(_ sender: Any) {
        resetGame()
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
    var crosses:Int
    func onBoat()->Int{
        return boatMissionaries + boatCannibals
    }
    
    mutating func moveEast(){
        boatOnWestBank = false
        eastMissionaries += boatMissionaries
        boatMissionaries -= boatMissionaries
        eastCannibals += boatCannibals
        boatCannibals -= boatCannibals
        crosses += 1
    }
    mutating func moveWest(){
        boatOnWestBank = true
        westMissionaries += boatMissionaries
        boatMissionaries -= boatMissionaries
        westCannibals += boatCannibals
        boatCannibals -= boatCannibals
        crosses += 1
    }
}
