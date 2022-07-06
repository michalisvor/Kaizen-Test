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
    
    private var sportEvent: APIResponseSportEvent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // I could use greater than equal for timeTitleLabel leading constraint
        // or even to put it inside a UIView.
        // But with these too large times the UI wouldn't be so pretty with every change,
        // so I chose the whole space for the border.
        timeTitleLabel.layer.borderColor = UIColor(hex: "E0E1E1").cgColor
        timeTitleLabel.layer.borderWidth = 1
        timeTitleLabel.layer.cornerRadius = 6
    }

    func setUp(with data: APIResponseSportEvent) {
        sportEvent = data
        
        let teams = data.teams
        teamHomeLabel.attributedText = teams.teamHome?.style(fontName: .regular, x2FontSize: 17, color: .white, alignment: .center)
        teamAwayLabel.attributedText = teams.teamAway?.style(fontName: .regular, x2FontSize: 17, color: .white, alignment: .center)
        
        teamHomeLabel.isHidden = teams.teamHome == nil
        teamAwayLabel.isHidden = teams.teamAway == nil
        
        setUpImage(isFavorite: data.isFavorite)
        favoriteImageView.event = data
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTapped)))
        setUpTimeLabel()
    }
    
    func setUpTimeLabel() {
        guard let event = sportEvent, let startTime = event.eventStartTime else {
            timeTitleLabel.text = ""
            return
        }
        let time = abs(Date().timeIntervalSince(Date(timeIntervalSince1970: startTime)))
        
        let hours = Int(time) / 3600
        let minutes = (Int(time) / 60) % 60
        let seconds = Int(time) % 60
        
        var times: [String] = []
        times.append(contentsOf: ["\(hours)", "\(minutes)", "\(seconds)"])
        
        timeTitleLabel.attributedText = times.joined(separator: ":").style(fontName: .regular, x2FontSize: 17, color: .white, alignment: .center)
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
