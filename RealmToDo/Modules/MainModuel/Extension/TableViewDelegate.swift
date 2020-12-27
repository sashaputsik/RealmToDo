import Foundation
import UIKit

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let count = dataLayer.list?.count else{return 0}
        if count == 0{
            tableView.isHidden = true
        }
        return count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        guard let value = dataLayer.list?[indexPath.row] else{return UITableViewCell()}
        cell.textLabel?.text = value.name
        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard let object = dataLayer.list?[indexPath.row] else{return }
        switch editingStyle {
        case .delete:
            DataLayer().delete(object: object)
            tableView.deleteRows(at: [indexPath],
                                 with: .left)
            tableView.reloadData()
        default:
            print("default")
        }
    }
}
