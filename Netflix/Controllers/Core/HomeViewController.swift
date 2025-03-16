//
//  HomeViewController.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 13/3/25.
//

import UIKit
import Foundation

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case UpComing = 3
    case TopRated = 4
}
class HomeViewController: UIViewController {
    
    var sectionTitles: [String] = ["Trending Movies", "Popular", "Trending TV", "Upcoming Movies", "Top rated"]
    private var heroHeaderView: HeroHeaderUIView?
    private var randomTitleOnTrending: Title?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        heroHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = heroHeaderView
        
        configureNavbar()
        configureHeroHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /*
         Câu lệnh này giúp homeFeedTable có kích thước bằng với toàn bộ view chứa nó
         */
        homeFeedTable.frame = view.bounds
    }
    private func configureHeroHeader() {
        APICaller.shared.getTrendingMovies { results in
            switch results {
            case .success(let titles):
                self.randomTitleOnTrending = titles.randomElement()
                guard let urlString = self.randomTitleOnTrending?.poster_path else {
                    return
                }
                self.heroHeaderView?.configure(model: urlString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configureNavbar() {
        let logoImageView = UIImageView(image: UIImage(named: "netflixLogo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        containerView.addSubview(logoImageView)

        let leftBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.darkMode
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    //cái này có hiệu lực khi set homeFeedTable theo style là grouped
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        //MARK: DELEGATE
        cell.delegate = self
        switch indexPath.section {
            
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTV { results in
                switch results {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
        case Sections.UpComing.rawValue:
            APICaller.shared.getUpComingMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRateMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }

        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    //MARK: Cách ẩn navigationBar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetDefault = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + offsetDefault
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    //MARK: Render header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    //MARK: Sửa lại font cho header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.textColor = .darkMode
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 110, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
}

extension HomeViewController: CollectionViewCellDelegate {
    func didTappedCollectionViewCell(cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(model: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
