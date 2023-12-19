//
//  TrafficLightController.swift
//  TrafficLight
//
//  Created by Nikolai Maksimov on 18.12.2023.
//

import UIKit

final class TrafficLightController: UIViewController {
    
    private let trafficView = TrafficLightView()
    
    override func loadView() {
        super.loadView()
        view = trafficView
    }
}
