//
//  NewsCell.swift
//  Project 32 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 19.06.24.


import UIKit
import SnapKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    private lazy var newsImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var broadcastingLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var publishedAtLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(newsImageView)
        newsImageView.addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(broadcastingLabel)
        addSubview(authorLabel)
        addSubview(publishedAtLabel)
    }
    
    func layouts() {
        newsImageView.snp.remakeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(58)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(222)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(newsImageView.snp.bottom).offset(-25)
            make.leading.equalTo(newsImageView.snp.leading).offset(39)
            make.trailing.equalTo(newsImageView.snp.trailing).offset(-39)
            make.height.equalTo(21)
        }
        
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        broadcastingLabel.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.height.equalTo(31)
        }
        
        authorLabel.snp.remakeConstraints { make in
            make.top.equalTo(broadcastingLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.height.equalTo(31)
        }
        
        publishedAtLabel.snp.remakeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.height.equalTo(31)
        }
        
    }
    
    func configure(with data: Articles) {
        titleLabel.text = data.title
        descriptionLabel.text = "Description \n \(data.description)"
        broadcastingLabel.text = data.source.name
        authorLabel.text = "Author: \(data.author ?? "Unknown")"
        publishedAtLabel.text = "Data: \(data.publishedAt)"
        
        if let urlString = data.urlToImage, let url = URL(string: urlString) {
            newsImageView.kf.setImage(with: url)
        } else {
            newsImageView.image = nil
        }
    }
}
