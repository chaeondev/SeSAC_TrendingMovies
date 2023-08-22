//
//  TVDetailsViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import UIKit

class TVDetailsViewController: UIViewController {
    
    var seriesID: Int = 0
    var seasonInfo: [Season] = []
    var epiInfo: [TVSeasonsDetails] = []

    @IBOutlet var episodeCollectionView: UICollectionView!
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()
        print(seriesID)
        TMDBAPIManager.shared.callSeasonInfoRequest(seriesID: seriesID) { data in
            self.seasonInfo = data.seasons
            self.episodeCollectionView.reloadData()

            for season in self.seasonInfo {
                
                self.group.enter()
                TMDBAPIManager.shared.callEpisodeInfoRequest(seriesID: self.seriesID, seasonNumber: season.seasonNumber) { data in
                    self.epiInfo.append(data)
                    self.group.leave()
                }
            }
            self.group.notify(queue: .main) {
                print("=====END====")
                self.episodeCollectionView.reloadData()
            }
            
        }
        
    }

}

extension TVDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // ???: - 이부분 index out of range 오류 뜸 -> reloadData되기전까지 list가 반영안되어서 일어나는 오류..?
    // func 이 실행되는 시점이 viewDidLoad랑 같나..? 모르겠음ㅠ
    // 애매하게 처리하긴 했는데 완전한 해결책이 아닌듯함.. list를 다 업뎃하고 아래 function들을 동작시킬 방법은 없나..?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seasonInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if epiInfo.count > 0 {
            return epiInfo[section].episodes.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if epiInfo.count > 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }

            if let epiURL = epiInfo[indexPath.section].episodes[indexPath.row].stillPath {
                let url = URL(string: "https://image.tmdb.org/t/p/original" + epiURL)
                cell.epiPosterImageView.kf.setImage(with: url)
            } else {
                cell.epiPosterImageView.backgroundColor = .black
            }
            
            
            let epiNum = epiInfo[indexPath.section].episodes[indexPath.row].episodeNumber
            let epiName = epiInfo[indexPath.section].episodes[indexPath.row].name
            cell.epiTitleLabel.text = "\(epiNum) \(epiName)"
            
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSeasonCollectionReusableView.identifier, for: indexPath) as? HeaderSeasonCollectionReusableView else { return UICollectionReusableView() }
            
            let seasonURL = seasonInfo[indexPath.section].posterPath
            let url = URL(string: "https://image.tmdb.org/t/p/original" + seasonURL)
            view.seasonBackDropImageView.kf.setImage(with: url)
            view.seasonTitleLabel.text = seasonInfo[indexPath.section].name
            view.seasonOverviewLabel.text = seasonInfo[indexPath.section].overview
            
            return view
        } else {
            
            return UICollectionReusableView()
            
        }
    }
    
}

extension TVDetailsViewController {
    func configureCollectionView() {
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        
        episodeCollectionView.register(UINib(nibName: EpisodeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        episodeCollectionView.register(UINib(nibName: HeaderSeasonCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeasonCollectionReusableView.identifier)
        
    }
    
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        
        episodeCollectionView.collectionViewLayout = layout
        
    }
}
