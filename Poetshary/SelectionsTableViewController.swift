//
//  SelectionsTableViewController.swift
//  Poetshary
//
//  Created by Noor Amer on 10/19/17.
//  Copyright © 2017 Noor Amer. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AVKit

class SelectionsTableViewController: FetchedResultsTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundView = nil
    updateUI()
  }
  
  var container: NSPersistentContainer? = AppDelegate.persistentContainer {
    didSet {
      updateUI()
    }
  }
  
  fileprivate var fetchedResultsController: NSFetchedResultsController<Selection>?
  
  private func updateUI() {
    if let context = container?.viewContext {
      let request: NSFetchRequest<Selection> = Selection.fetchRequest()
      request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
      fetchedResultsController = NSFetchedResultsController<Selection>(
        fetchRequest: request,
        managedObjectContext: context,
        sectionNameKeyPath: nil,
        cacheName: nil
      )
    }
    fetchedResultsController?.delegate = self
    try? fetchedResultsController?.performFetch()
    if let isEmpty = fetchedResultsController?.fetchedObjects?.isEmpty, isEmpty == true {
      let backgroundView = SelectionTableViewBackgroundView()
      backgroundView.playVideo = playVideo
      backgroundView.backgroundColor = UIColor.white
      backgroundView.contentMode = .redraw
      tableView.backgroundView = backgroundView
    } else {
      tableView.backgroundView = nil
      tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Selection Cell", for: indexPath)
    
    if let selection = fetchedResultsController?.object(at: indexPath) {
      if let selectionCell = cell as? SelectionTableViewCell {
        tableView.backgroundView = nil
        selectionCell.selection = selection
      }
    }
    
    return cell
  }
  
  @objc private func playVideo() {
    let videoURL = URL(string: "https://nooralasa.github.io/images/dragAndDrop.mov")
    let player = AVPlayer(url: videoURL!)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    self.present(playerViewController, animated: true) {
      playerViewController.player!.play()
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let selectionViewController = segue.destination as? SelectionViewController {
      if let selectionCell = sender as? SelectionTableViewCell {
        selectionViewController.title = selectionCell.textLabel?.text
        selectionViewController.selection = selectionCell.selection
      }
    }
  }
  
}

extension SelectionsTableViewController
{
  // MARK: UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return fetchedResultsController?.sections?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if let sections = fetchedResultsController?.sections, sections.count > 0 {
      return sections[section].numberOfObjects
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  {   if let sections = fetchedResultsController?.sections, sections.count > 0 {
    return sections[section].name
  } else {
    return nil
    }
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]?
  {
    return fetchedResultsController?.sectionIndexTitles
  }
  
  override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
  {
    return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
  }
  
}

