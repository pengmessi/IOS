//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by new on 15/8/6.
//  Copyright (c) 2015年 pengmessi. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
