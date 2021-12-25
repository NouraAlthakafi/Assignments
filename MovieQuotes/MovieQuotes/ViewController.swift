//
//  ViewController.swift
//  MovieQuotes
//
//  Created by admin on 25/12/2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var cvMoviesCollection: UICollectionView!
    
    let arrayTitles = ["Bilal a New Breed of Hero",
                       "Detective Conan",
                       "InuYasha",
                       "Lion of the Desert",
                       "Sherlock",
                       "Slam Dunk",
                       "SnowWhite and the Seven Dwarfs",
                       "The Good the Bad and the Ugly",
                       "The Hobbit",
                       "The Maze Runner"]
    
    let arrayPosters = [URL(string: "https://i.egycdn.com/pic/WmFwZndlY21UbW1FbVRwYm1qRWNhbWptdmFjd1BtSGM.jpg"),
                        URL(string: "https://upload.wikimedia.org/wikipedia/en/3/36/Detective_Conan_%28Secret_File%29.png"),
                        URL(string: "https://movieposters2.com/images/1236022-b.jpg"),
                        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT48ysdUXK35qGN06WS-CKYEA6Gh_6R0RVsMA&usqp=CAU"),
                        URL(string: "https://i.ebayimg.com/images/g/4EUAAOSw0dJft4w6/s-l400.jpg"),
                        URL(string: "https://cdn.shopify.com/s/files/1/0516/6940/1772/products/JGKP377_530x@2x.jpg?v=1621435296"),
                        URL(string: "https://cdn.statically.io/img/cimalek.club/f=auto/wp-content/uploads/2021/10/4UvFMz8Ys0TaTTxma5e2tKj8u61.jpg"),
                        URL(string: "https://cdn.shopify.com/s/files/1/1057/4964/products/The-Good-Bad-and-the-Ugly-Vintage-Movie-Poster-Original-French-1-panel-47x63-5052.jpg?v=1629781389"),
                        URL(string: "https://upload.wikimedia.org/wikipedia/ar/a/a9/The_Hobbit_trilogy_dvd_cover.jpg"),
                        URL(string: "https://m.media-amazon.com/images/I/51ihDXYQARL._AC_.jpg")]
    
    let arrayQuotes = ["Being a great man means...living without chains.",
                       "A trick is nothing but a puzzle mankind came up with. If you use your head, you can uncover the logical answer.",
                       "Can it be that I'm afraid... or is it merely I know not my own limit?",
                       "We will not give up. We win, or we die.",
                       "Dear God, what is it like in your funny little brains? It must be so BORING.",
                       "No one can ever know how to do EVERYTHING without learning it first.",
                       "She's a female! And all females is poison! They're full of wicked wiles!",
                       "You see, in this world, there's two kinds of people, my friend... Those with loaded guns, and those who dig. You dig.",
                       "If more people... valued home above gold... this world would be a merrier... place...",
                       "If you ain't scared... You ain't human."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMoviesCollection.dequeueReusableCell(withReuseIdentifier: "cellMovie", for: indexPath) as! MovieCVC
        cell.lbTitle.text = arrayTitles[indexPath.row]
        cell.ivPoster.kf.setImage(with: arrayPosters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: arrayTitles[indexPath.row], message: arrayQuotes[indexPath.row], preferredStyle: .alert)
                let finishAlert = UIAlertAction(title: "OK", style: .default, handler: nil )
                alert.addAction(finishAlert)
                present(alert, animated: true, completion: nil)
            }
    
}
