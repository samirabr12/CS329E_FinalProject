//
//  CalendarViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/28/22.
//

import UIKit

class CalendarViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCalendar()
        
    }
    func createCalendar()
    {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "zh_TW")
        calendarView.fontDesign = .rounded
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()), day: Calendar.current.component(.day, from: Date()))
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
