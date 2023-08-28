//
//  TVDetailsViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import UIKit

class TVDetailsViewController: BaseViewController {
    
    var seriesID: Int = 0
    var seasonInfo: [Season] = []
    var epiInfo: [TVSeasonsDetails] = []
    
    let group = DispatchGroup()
    
    let mainView = TVDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TMDBAPIManager.shared.callSeasonInfoRequest(seriesID: seriesID) { data in
            self.seasonInfo = data.seasons
            self.mainView.collectionView.reloadData()

            for season in self.seasonInfo {
                
                self.group.enter()
                TMDBAPIManager.shared.callEpisodeInfoRequest(seriesID: self.seriesID, seasonNumber: season.seasonNumber) { data in
                    self.epiInfo.append(data)
                    self.group.leave()
                }
            }
            self.group.notify(queue: .main) {
                print("=====END====")
                self.mainView.collectionView.reloadData()
            }
            
        }
        
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpiCollectionViewCell.identifier, for: indexPath) as? EpiCollectionViewCell else { return UICollectionViewCell() }

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
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeasonCollectionReusableView.identifier, for: indexPath) as? SeasonCollectionReusableView else { return UICollectionReusableView() }
            
            let seasonURL = seasonInfo[indexPath.section].posterPath
            let url = URL(string: "https://image.tmdb.org/t/p/original" + seasonURL)
            view.seasonBackdropImageView.kf.setImage(with: url)
            view.seasonTitleLabel.text = seasonInfo[indexPath.section].name
            view.seasonOverviewLabel.text = seasonInfo[indexPath.section].overview
            
            return view
        } else {
            
            return UICollectionReusableView()
            
        }
    }
    
}

