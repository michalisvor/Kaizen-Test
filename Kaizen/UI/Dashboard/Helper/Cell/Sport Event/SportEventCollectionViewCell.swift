//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class FavoriteUIImageView: UIImageView {
    var event: APIResponseSportEvent?
}

protocol SportEventCollectionViewCellDelegate: AnyObject {
    func didChangeEvent(id: String)
}

class SportEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeTitleLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: FavoriteUIImageView!
    @IBOutlet private weak var teamHomeLabel: UILabel!
    @IBOutlet private weak var teamAwayLabel: UILabel!
    
    weak var delegate: SportEventCollectionViewCellDelegate?
    
    var sportEvent: APIResponseSportEvent!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setUp(with data: APIResponseSportEvent) {
        sportEvent = data
        timeTitleLabel.text = "1"
        
        let teams = data.teams
        teamHomeLabel.text = teams.teamHome
        teamAwayLabel.text = teams.teamAway
        
        teamHomeLabel.isHidden = teams.teamHome == nil
        teamAwayLabel.isHidden = teams.teamAway == nil
        
        setUpImage(isFavorite: data.isFavorite)
        favoriteImageView.event = data
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTapped)))
        setUpTimeLabel()
    }
    
    func setUpTimeLabel() {
        guard let event = sportEvent, let startTime = event.eventStartTime else { return }
        let time = abs(Date().timeIntervalSince(Date(timeIntervalSince1970: startTime)))
        
        let hours = Int(time) / 3600
        let minutes = (Int(time) / 60) % 60
        let seconds = Int(time) % 60
        
        var times: [String] = []
        times.append(contentsOf: ["\(hours)", "\(minutes)", "\(seconds)"])
        
        timeTitleLabel.text = times.joined(separator: ":")
    }
    
    private func setUpImage(isFavorite: Bool) {
        favoriteImageView.image = isFavorite ? UIImage(named: "icon_star_filled") : UIImage(named: "icon_star_unfilled")
    }
    
    @objc private func favoriteTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? FavoriteUIImageView, let event = imageView.event else { return }
        
        // I will change here the isFavorite property and now by the class type the value has been updated everywhere.
        event.isFavorite.toggle()
        setUpImage(isFavorite: event.isFavorite)
        delegate?.didChangeEvent(id: event.eventId ?? "")
    }
}
