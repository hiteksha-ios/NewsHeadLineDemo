//
//  NewsFeedViewModel.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import UIKit

struct NewsFeedListViewModel {
    let newsDetails : [NewsDetails]
}
extension NewsFeedListViewModel{
//    var sections: [GroupedSection<String,FlightDetails>] {
//        var sections = GroupedSection.group(rows: flightDetails, by: {$0.date})
//        sections.sort { lhs, rhs in lhs.sectionItem < rhs.sectionItem }
//        return sections
//    }
    var numberofSections : Int{
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        return self.newsDetails.count
    }
    
    func newsAtIndex(_ index : IndexPath) -> NewsFeedViewModel{
        let newsDetail = self.newsDetails[index.row]
        return NewsFeedViewModel(newsDetail)
    }
    
}

struct NewsFeedViewModel {
    let newsDetail : NewsDetails
}

extension NewsFeedViewModel {
    init(_ newsDetail : NewsDetails) {
        self.newsDetail = newsDetail
    }
}
