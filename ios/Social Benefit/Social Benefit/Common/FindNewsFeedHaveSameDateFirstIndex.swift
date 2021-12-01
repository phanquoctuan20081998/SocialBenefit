//
//  FindNewsFeedHaveSameDateFirstIndex.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation


struct HeadTailIndex: Hashable {
    var head: Int
    var tail: Int
}

func FindNewsFeedHaveSameDateFirstIndex(timeArray: [String]) -> [HeadTailIndex] {
    
    var sameDateGroup = [HeadTailIndex]()
    
    if timeArray.count == 0 {
        // Do nothing
    } else if timeArray.count == 1 {
        sameDateGroup.append(HeadTailIndex(head: 0, tail: 0))
    } else {
        
        var tempHead = 0
        var tempTail = 0
        
        for i in 1..<timeArray.count {
            if timeArray[i] != timeArray[i - 1] {
                tempTail = i - 1
                
                sameDateGroup.append(HeadTailIndex(head: tempHead, tail: tempTail))
                tempHead = i
            }
        }
        
        tempTail = timeArray.count - 1
        sameDateGroup.append(HeadTailIndex(head: tempHead, tail: tempTail))
    }
    
    return sameDateGroup
}
