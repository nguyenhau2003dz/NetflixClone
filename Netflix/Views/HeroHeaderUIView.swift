//
//  HeroHeaderUIView.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 14/3/25.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let heroImage: UIImageView = {
        let heroImage = UIImageView()
        heroImage.contentMode = .scaleAspectFill
        heroImage.clipsToBounds = true
        heroImage.image = UIImage(named: "heroImage")
        return heroImage
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImage)
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraits()
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        /*
         Câu lệnh này thiết lập kích thước (frame) của heroImage bằng với kích thước (bounds) của view chứa nó.
         */
        heroImage.frame = bounds
    }

    private func addGradient() {
    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        heroImage.layer.addSublayer(gradientLayer)
    }

    private func applyConstraits() {
        let playButtonConstraits = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        let downloadButtonConstraits = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 110)
        ]

        
        NSLayoutConstraint.activate(playButtonConstraits)
        NSLayoutConstraint.activate(downloadButtonConstraits)
    }
    public func configure(model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}

        heroImage.sd_setImage(with: url, completed: nil)
    }
}
