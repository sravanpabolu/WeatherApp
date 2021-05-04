//
//  BookmarkedCityCell.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import UIKit

class BookmarkedCityCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
