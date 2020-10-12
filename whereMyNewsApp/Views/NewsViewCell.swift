//
//  TableViewCell.swift
//  whereMyNewsApp
//
//  Created by Konstantin on 11.10.2020.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet var newsImageView: ImageView!
    
    func configure(with news: Articles) {
        guard let image = news.urlToImage else { return }
            self.newsImageView.fetchImage(from: image)
    }
}
