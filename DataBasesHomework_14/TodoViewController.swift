import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var tasksList: [String] = []
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func removeTask(_ sender: Any) {
        RealmPersistance.shared.deleteTask(toDelete: tasksList[0])

        todoTableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTask = newTaskTextField.text {
            RealmPersistance.shared.addedTask = newTask
        }
     
        RealmPersistance.shared.recordTask()

        tasksList = RealmPersistance.shared.tasksList

        todoTableView.reloadData()
        
        newTaskTextField.text = ""

    }
    
}

extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoTableViewCell
        todoTableView.clearsContextBeforeDrawing = true
        cell.tasksLabel.text = tasksList[indexPath.row]
        
        return cell
    }


}
