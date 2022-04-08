//
//  SceduleNotificationController.swift
//  LocalNotifications
//
//  Created by Paul on 07.04.2022.
//

import UIKit
import UserNotifications
import AudioToolbox

class SceduleNotificationController: UIViewController {

    @IBOutlet weak var intervalPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        requestNotificationPermission()
        intervalPicker.dataSource = self
        intervalPicker.delegate = self
    }
    @IBAction func setInterval() {
        let requestID = "Interval timer ID"
        let minutes = intervalPicker.selectedRow(inComponent: 0)
        let seconds = intervalPicker.selectedRow(inComponent: 1)
        let intervalComponents = DateComponents(minute: minutes, second: seconds)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.formattingContext = .beginningOfSentence
        let intervalString = formatter.string(from: intervalComponents)
        
        let content = UNMutableNotificationContent()
        content.title = "Interval timer"
        content.subtitle = intervalString == nil ? "" : "every \(intervalString!)"
        //content.sound = .default
        content.sound = .ringtoneSoundNamed(UNNotificationSoundName(rawValue: "fe_07.mp3"))
        //content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "fe_07.mp3"))

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds + minutes * 60), repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: requestID, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [requestID])
        UNUserNotificationCenter.current().add(request)
        
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SceduleNotificationController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        60
    }
}

extension SceduleNotificationController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(row)"
    }
}

extension UIViewController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        //AudioServicesPlaySystemSound(1025)
        var saudioID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(Bundle.main.url(forResource: "fe_07", withExtension: "mp3")! as CFURL, &saudioID)
        AudioServicesPlaySystemSound(saudioID)
        // note that it does not play sound if `.sound` is the only option
        completionHandler([])
    }
}
