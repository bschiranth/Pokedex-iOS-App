//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Chiranth on 9/13/16.
//  Copyright © 2016 Chiranth. All rights reserved
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemonDetail: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemonDetail.name.capitalized
        
        let img = UIImage(named: "\(pokemonDetail.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemonDetail.pokedexId)"
        
        pokemonDetail.downloadPokemonDetail {
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.attackLbl.text = self.pokemonDetail.attack
        self.defenseLbl.text = self.pokemonDetail.defense
        self.heightLbl.text = self.pokemonDetail.height
        self.weightLbl.text = self.pokemonDetail.weight
        self.pokedexLbl.text = "\(self.pokemonDetail.pokedexId)"
        self.typeLbl.text = self.pokemonDetail.type
        self.descriptionLbl.text = self.pokemonDetail.description
        
        if pokemonDetail.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemonDetail.nextEvolutionId)
            let str = "Next Evolution: \(pokemonDetail.nextEvolutionName) - LVL \(pokemonDetail.nextEvolutionLevel)"
            evoLbl.text = str
        }
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
  

}

