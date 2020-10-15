//
//  TableViewController.swift
//  whereMyNewsApp
//
//  Created by Konstantin on 11.10.2020.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var news: News!
    private var spinnerView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        spinnerView = showSpinner(in: tableView)
        sendRequest(url: getURL.technogolgy.rawValue)
        tableView.rowHeight = 300
        
        
        title = "News"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsViewCell
        
        guard let newsForCell = news?.articles?[indexPath.row] else { return cell }
        cell.configure(with: newsForCell)
        
        return cell
    }
    
    
    private func sendRequest(url: String) {
        self.spinnerView?.startAnimating()
        NetworkManager.shared.fetchData(url: url) { news in
            self.news = news
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.spinnerView?.stopAnimating()
        }
    }
    
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    
    @IBAction func newsSegmentedPanelAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sendRequest(url: getURL.technogolgy.rawValue)
        case 1:
            sendRequest(url: getURL.sports.rawValue)
        case 2:
            sendRequest(url: getURL.business.rawValue)
        case 3:
            sendRequest(url: getURL.science.rawValue)
        case 4:
            sendRequest(url: getURL.health.rawValue)
        default:
            break
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
