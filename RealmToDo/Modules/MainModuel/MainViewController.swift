import UIKit
import RealmSwift

class MainViewController: UIViewController {
    let dataLayer = DataLayer()
    
    @IBOutlet weak var tableView: UITableView!
    private let realmData = try? Realm()
    var notificationToken: NotificationToken?
    override func viewWillAppear(_ animated: Bool) {
        let addedButton = UIBarButtonItem(title: "Set",
                                          style: .done,
                                          target: self,
                                          action: #selector(added))
        navigationItem.rightBarButtonItem = addedButton
        dataLayer.fetchData {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationToken = DataLayer().list?._observe(.main, { [weak self](changes: RealmCollectionChange) in
            guard let self = self else{return }
            print(changes)
            switch changes{
            case .initial:
                self.tableView.reloadData()
            case .update(_, deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0,
                                                                        section: 0)}),
                                          with: .automatic)
                self.tableView.insertRows(at: insertions.map({IndexPath(row: $0,
                                                                        section: 0)}),
                                          with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0,
                                                                            section: 0) }),
                                          with: .automatic)
                self.tableView.endUpdates()
            case .error(let error ):
                fatalError("\(error)")
            }
        })
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
         
    }

    //MARK: Handler
    
    @objc
    private func added(){
        let addedView = Builder.setAddedModule()
        navigationController?.pushViewController(addedView,
                                                 animated: true)
    }
}

