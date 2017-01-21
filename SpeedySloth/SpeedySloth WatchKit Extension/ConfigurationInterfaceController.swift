/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Interface controller for the configuration screen.
 */

import WatchKit
import Foundation
import HealthKit

class ConfigurationInterfaceController: WKInterfaceController {
    // MARK: Properties
    
    var selectedActivityType: HKWorkoutActivityType
    
    var selectedLocationType: HKWorkoutSessionLocationType
    
    var selectedHeartRate: Int
    
    let activityTypes: [HKWorkoutActivityType] = [.walking, .running, .hiking]
    
    let locationTypes: [HKWorkoutSessionLocationType] = [.unknown, .indoor, .outdoor]
    let heartTargets: [Int] = Array(120...150)
    // MARK: IB Outlets
    
    @IBOutlet var activityTypePicker: WKInterfacePicker!
    
    @IBOutlet var locationTypePicker: WKInterfacePicker!
    
    @IBOutlet var heartTypePicker: WKInterfacePicker!
    // MARK: Initialization
    
    override init() {
        selectedActivityType = activityTypes[0]
        selectedLocationType = locationTypes[0]
        selectedHeartRate = heartTargets[0]
        super.init()
    }
    
    // MARK: Interface Controller Overrides
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Populate the activity type picker
        let activityTypePickerItems: [WKPickerItem] = activityTypes.map {type in
            let pickerItem = WKPickerItem()
            pickerItem.title = format(activityType: type)
            return pickerItem
        }
        activityTypePicker.setItems(activityTypePickerItems)
        
        // Populate the location type picker
        let locationTypePickerItems: [WKPickerItem] = locationTypes.map {type in
            let pickerItem = WKPickerItem()
            pickerItem.title = format(locationType: type)
            return pickerItem
        }
        
        let heartPickerItems: [WKPickerItem] = heartTargets.map { type in
            let pickerItem = WKPickerItem()
            pickerItem.title = String(type)
            return pickerItem
        }
        heartTypePicker.setItems(heartPickerItems)
        locationTypePicker.setItems(locationTypePickerItems)
        
        setTitle("Speedy Sloth")
    }

    // MARK: IB Actions
    
    @IBAction func activityTypePickerSelectedItemChanged(value: Int) {
        selectedActivityType = activityTypes[value]
    }
    
    @IBAction func locationTypePickerSelectedItemChanged(value: Int) {
        selectedLocationType = locationTypes[value]
    }
    
    @IBAction func heartRatePickerSelectedItemChanged(_ value: Int) {
        selectedHeartRate = heartTargets[value]
    }
    
    var finalHeartRate: Int = 0
    @IBAction func didTapStartButton() {
        // Create workout configuration
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = selectedActivityType
        workoutConfiguration.locationType = selectedLocationType
        self.finalHeartRate = selectedHeartRate
        mainInstance.modifyHeartRate(heartRate: self.finalHeartRate)
        // Pass configuration to next interface controller
        WKInterfaceController.reloadRootControllers(withNames: ["WorkoutInterfaceController"], contexts: [workoutConfiguration])
    }
}

