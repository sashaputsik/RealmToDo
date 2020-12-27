import RealmSwift
import UIKit

class AddedViewController: UIViewController {
        
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addedButton.addTarget(self,
                              action: #selector(added),
                              for: .touchUpInside)
    }
    
    //MARK: Handler
    @objc
    private func added(){
        let task = Task()
        guard let text = nameTextField.text else{return }
        task.name = text
        DataLayer().saveToData(object: task)
        navigationController?.pushViewController(Builder.setMainModule(), animated: true)
    }
    
}
