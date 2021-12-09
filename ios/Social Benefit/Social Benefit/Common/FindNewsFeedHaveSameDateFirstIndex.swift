//
//  FindNewsFeedHaveSameDateFirstIndex.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import SwiftUI

struct SeparateByDateData: Hashable {
    
    // EX: [20/11, 20/11, 22/11, 23/11]
    
    var head: Int // head = [0, 2, 3]
    var tail: Int // tail = [1, 2, 3]
    var date: String // date = [20/11, 22/11, 23/11]
}

func FindNewsFeedHaveSameDateFirstIndex(timeArray: [String]) -> [SeparateByDateData] {
    
    var sameDateGroup = [SeparateByDateData]()
    
    if timeArray.count == 0 {
        // Do nothing
    } else if timeArray.count == 1 {
        sameDateGroup.append(SeparateByDateData(head: 0, tail: 0,  date: ""))
    } else {
        
        var tempHead = 0
        var tempTail = 0
        
        for i in 1..<timeArray.count {
            if timeArray[i] != timeArray[i - 1] {
                tempTail = i - 1
                
                sameDateGroup.append(SeparateByDateData(head: tempHead, tail: tempTail, date: ""))
                tempHead = i
            }
        }
        
        tempTail = timeArray.count - 1
        sameDateGroup.append(SeparateByDateData(head: tempHead, tail: tempTail, date: ""))
    }
    
    // Assign date
    let time = getDateHistoryName(timeArray: timeArray, sameDateGroup: sameDateGroup)
    
    for i in time.indices {
        sameDateGroup[i].date = time[i]
    }
    
    return sameDateGroup
}

func getDateHistoryName(timeArray: [String], sameDateGroup: [SeparateByDateData]) -> [String] {
    
    var timeName = [String]()
    
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let yesterday = Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    
    let todayEnglishFormat = convertToEnglishFormat(day: today.day, month: today.month, year: today.year)
    let yesterdayEnglishFormat = convertToEnglishFormat(day: yesterday.day, month: yesterday.month, year: yesterday.year)
    
    var index = 0
    for i in 0 ..< sameDateGroup.count {
        if timeArray[index] == todayEnglishFormat {
            timeName.append("today")
        } else if timeArray[index] == yesterdayEnglishFormat {
            timeName.append("yesterday")
        } else {
            timeName.append(timeArray[index])
        }
        index = sameDateGroup[i].head
    }
    
    return timeName
}
