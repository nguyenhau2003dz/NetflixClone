//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 15/3/25.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .darkMode
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TitleTableViewCell.identifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleButton)
        contentView.addSubview(titleLabel)
        
        applyContraits()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyContraits() {
        let posterImageViewConstraits = [
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let titleLabelContraits = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleButtonContraits = [
            titleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            titleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(posterImageViewConstraits)
        NSLayoutConstraint.activate(titleLabelContraits)
        NSLayoutConstraint.activate(titleButtonContraits)


    }
    public func configure(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        titleLabel.text = model.titleLabel
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
