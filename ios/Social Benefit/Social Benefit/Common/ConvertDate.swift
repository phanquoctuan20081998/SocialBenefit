//
//  ConvertDate.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/11/2021.
//

import Foundation

func getFullDateSince1970(date: Int) -> String {
    let commentDate = Date(timeIntervalSince1970: Double(date / 1000))
    let diffirent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: commentDate, to: Date())
    
    if diffirent.year != 0 {
        return "\(String(describing: diffirent.year!)) " + ((diffirent.year == 1) ? "year".localized : "years".localized)
    } else if diffirent.month != 0 {
        return "\(String(describing: diffirent.month!)) " + ((diffirent.month == 1) ? "month".localized : "months".localized)
    } else if diffirent.day != 0 {
        return "\(String(describing: diffirent.day!)) " + ((diffirent.day == 1) ? "day".localized : "days".localized)
    } else if diffirent.hour != 0 {
        return "\(String(describing: diffirent.hour!)) " + ((diffirent.hour == 1) ? "hour".localized : "hours".localized)
    } else if diffirent.minute != 0 {
        return "\(String(describing: diffirent.minute!)) " + ((diffirent.minute == 1) ? "minute".localized : "minutes".localized)
    } else {
        return "a_few_seconds".localized
    }
}

func getDateElementSince1970(_ date1970: Int) -> DateComponents {
    let date = Date(timeIntervalSince1970: Double(date1970 / 1000))
    let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    return dateComponents
}

func convertToEnglishFormat(day: Int?, month: Int?, year: Int?) -> String {
    
    var date = ""
    
    guard let day = day else { return "" }
    guard let month = month else { return "" }
    guard let year = year else { return "" }
    
    date += getDayEnglishFormat(day: day) + " "
    date += getMonthEnlishFormat(month: month) + " "
    date += String(year)
    
    return date
}

func getDayEnglishFormat(day: Int) -> String {
    
    var date = ""
    
    if (day == 1 ||  day == 21 || day == 31) {
        date += String(day) + "st".localized
    } else if (day == 2 || day == 22) {
        date += String(day) + "nd".localized
    } else if (day == 3 || day == 23) {
        date += String(day) + "rd".localized
    } else {
        date += String(day) + "th".localized
    }
    
    return date
}

func getMonthEnlishFormat(month: Int) -> String {
    var date = ""
    
    switch month {
    case 1: date += "january".localized
    case 2: date += "febuary".localized
    case 3: date += "march".localized
    case 4: date += "april".localized
    case 5: date += "may".localized
    case 6: date += "june".localized
    case 7: date += "july".localized
    case 8: date += "august".localized
    case 9: date += "september".localized
    case 10: date += "october".localized
    case 11: date += "november".localized
    default: date += "december".localized
    }
    
    return date
}

func getDateSinceToday(time: String) -> String {
    // time = dd/MM/yyyy
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyy"
    
    let date = dateFormatter.date(from: time)
    
    let components = Calendar.current.dateComponents([.year, .month, .day], from: date!)
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let yesterday = Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    
    let dateEnglishFormat = convertToEnglishFormat(day: components.day, month: components.month, year: components.year)
    let todayEnglishFormat = convertToEnglishFormat(day: today.day, month: today.month, year: today.year)
    let yesterdayEnglishFormat = convertToEnglishFormat(day: yesterday.day, month: yesterday.month, year: yesterday.year)
    
    
    if dateEnglishFormat == todayEnglishFormat {
        return "today"
    } else if dateEnglishFormat == yesterdayEnglishFormat {
        return "yesterday"
    } else {
        return time
    }
}

