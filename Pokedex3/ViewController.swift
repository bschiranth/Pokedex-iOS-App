//
//  ViewController.swift
//  Pokedex3
//
//  Created by Chiranth on 9/12/16.
//  Copyright © 2016 Chiranth. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self

        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    
    //AUDIO FUNCTION
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch {
            
        }
    }
    
    //POKEMON DATA - THIS WILL PARSE THE POKEMON DATA FROM THE CSV.SWIFT JSON-LOOKING FILE
    func parsePokemonCSV() {
       
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            //We're going to use the parser, but it could produce an error so we'll do a do-catch
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)

            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemonArray.append(poke)
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    //SEARCH BAR METHOD - To end the keyboard when we're finished searching for the pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    //SEARCH BAR METHOD
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true

            let lower = searchBar.text!.lowercased()

            filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil})
            
            collectionView.reloadData()
        }
    }
    
  
    //COLLECTIONVIEW REQUIRED METHODS
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {

            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemonArray[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemonArray[indexPath.row]
                cell.configureCell(poke)
            }
            
            
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemonArray.count
        }
        
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 105)
    }

    
    //MUSIC BUTTON FUNCTION
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemonDetail = poke
                }
            }
        }
    }
    

    
    
}

