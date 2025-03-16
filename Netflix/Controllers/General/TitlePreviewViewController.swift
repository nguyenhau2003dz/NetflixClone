//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 15/3/25.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private let webview: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Hary potter"
        return label
    }()
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.darkMode, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        view.addSubview(overViewLabel)
        
        applyContraits()
    }
    func applyContraits() {
        let webviewContraits = [
            webview.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLabelContraits = [
            titleLabel.topAnchor.constraint(equalTo: webview.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ]
        let overviewConstraits = [
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let buttonConstraits = [
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 15),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(webviewContraits)
        NSLayoutConstraint.activate(titleLabelContraits)
        NSLayoutConstraint.activate(overviewConstraits)
        NSLayoutConstraint.activate(buttonConstraits)
    }
    func configure(model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId!)") else {
            return
        }
        print(url)
        webview.load(URLRequest(url: url))
    }
}
