//
//  NewsFeedCell.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    //OUTLETS
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAutherName: UILabel!
    @IBOutlet weak var publishTimeLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(newsDetails: NewsDetails) {
        newsTitleLabel.text = newsDetails.title
        newsAutherName.text = newsDetails.author
        let url = URL(string: newsDetails.urlToImage)
        if let data = try? Data(contentsOf: url!) {
            newsImageView.image = UIImage(data: data)
        }
        
        let dateFormater = DateFormatter()
        let dateTimeFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        dateTimeFormater.dateFormat = "dd/MM/yyyy"
        let dateOfBirth = dateFormater.date(from: newsDetails.publishedAt)
        dateTimeFormater.timeStyle = .long
        dateFormater.dateStyle = .medium
        dateFormater.timeZone = TimeZone(identifier:"GMT")
        dateTimeFormater.timeZone = TimeZone(identifier:"IST")
        print("date:\("\(dateFormater.string(from: dateOfBirth ?? Date()))")")
        publishTimeLabel.text = "\(dateTimeFormater.string(from: dateOfBirth ?? Date())) • \(dateFormater.string(from: dateOfBirth ?? Date()))"
        newsContentLabel.text = newsDetails.content
    }
}
