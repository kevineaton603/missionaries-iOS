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

    @IBOutlet weak var WestMissionaries: UILabel!
    @IBOutlet weak var WestCannibals: UILabel!
    @IBOutlet weak var EastMissionaries: UILabel!
    @IBOutlet weak var EastCannibals: UILabel!
    @IBOutlet weak var WestPassengers: UILabel!
    @IBOutlet weak var EastPassengers: UILabel!
    @IBOutlet weak var WestBoat: UILabel!
    @IBOutlet weak var EastBoat: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var GameState = Position(boatOnWestBank: true, westMissionaries: 3, eastMissionaries: 3, westCannibals: 0, eastCannibals: 0, boatMissionaries: 0, boatCannibals: 0)
        WestMissionaries.setUILabelText(repeatingValue: "⛪️", count:3)
        EastMissionaries.setUILabelText(repeatingValue: " ", count:1)
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
