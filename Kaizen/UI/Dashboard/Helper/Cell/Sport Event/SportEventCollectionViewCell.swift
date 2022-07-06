//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class SportEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeTitleLabel: UILabel!
    @IBOutlet private weak var teamHomeLabel: UILabel!
    @IBOutlet private weak var teamAwayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setUp(with data: APIResponseSportEvent) {
        timeTitleLabel.text = "1"
        
        let teams = data.teams
        teamHomeLabel.text = teams.teamHome
        teamAwayLabel.text = teams.teamAway
        
        teamHomeLabel.isHidden = teams.teamHome == nil
        teamAwayLabel.isHidden = teams.teamAway == nil
    }
}
