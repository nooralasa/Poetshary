//
//  PoemCollectionViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/17/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "PoemCollectionViewCell"

class PoemCollectionViewController: UICollectionViewController {
  
  fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  
  var poems: [Poem]? {
    didSet {
      if poems != nil {
        collectionView!.reloadData()
      }
    }
  }
  
  var container: NSPersistentContainer? = AppDelegate.persistentContainer
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    NotificationCenter.default.addObserver(
      forName: AppDelegate.Notifications.FinishedLoadingDatabase.name,
      object: nil,
      queue: OperationQueue.main
      ) { [weak self] notification in
        if self?.poems == nil {
          self?.loadPoems()
        }
      }
  }
  
  
  private func loadPoems() {
    let request: NSFetchRequest<Poem> = Poem.fetchRequest()
    if let context = container?.viewContext {
      self.poems = try? context.fetch(request)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if poems == nil {
      loadPoems()
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
//    return poems.count
    return poems != nil ? poems!.count : 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
      
    if let poemCell = cell as? PoemCollectionViewCell {
      
      if let poem = poems?[indexPath.row] {
        poemCell.poem = poem
      }
      
      return poemCell
    }
    
    return cell
  }
  
  // MARK: Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let poemViewController = segue.destination as? PoemViewController {
      if let poemCollectionViewCell = sender as? PoemCollectionViewCell {
        poemViewController.title = poemCollectionViewCell.poem!.translatedTitle
        poemViewController.poem = poemCollectionViewCell.poem!
      }
    }
  }
  
}

extension PoemCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * CGFloat(round(view.frame.width/200) + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / CGFloat(round(view.frame.width/200))
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
