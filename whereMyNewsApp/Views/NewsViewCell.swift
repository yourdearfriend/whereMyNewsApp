//
//  TableViewCell.swift
//  whereMyNewsApp
//
//  Created by Konstantin on 11.10.2020.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet var nameNewsLabel: UILabel!
    @IBOutlet var newsImageView: ImageView!
    
    func configure(with news: Articles) {
        newsImageView.fetchImage(from: news.urlToImage ?? "news")
        nameNewsLabel.text = news.title ?? "News"
    }
}
