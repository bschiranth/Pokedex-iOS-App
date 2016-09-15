//
//  PokeCell.swift
//  Pokedex3
//
//  Created by Chiranth on 9/12/16.
//  Copyright © 2016 Chiranth. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    //What do we want in our collection cell? We want to modify the image and the label
    
    var pokemon: Pokemon!
    
    //ROUNDING THE CELL'S BORDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Each cell has a layer level where we can modify how it looks
        layer.cornerRadius = 5.0
        
    }
    
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
}
