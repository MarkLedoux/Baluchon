//
//  DetailViewController.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 25/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var detailItem: WeatherResult?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (detailItem?.base.count)!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailItem?.main.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let detailItem = detailItem else { return UITableViewCell() }

        return cell
    }
}
