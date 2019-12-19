import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var tasksList: [String] = []
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTasksList()
    }
    
    func removeTask(task: String) {
        RealmPersistance.shared.deleteTask(toDelete: task)
    }
    
    func updateTasksList() {
        tasksList = RealmPersistance.shared.getRecoordedTask()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTask = newTaskTextField.text {
            RealmPersistance.shared.setTask(newTask: newTask)
        }
     
        RealmPersistance.shared.recordTask()

        updateTasksList()
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let data = tasksList[indexPath.row]
            removeTask(task: data)
            updateTasksList()
            todoTableView.reloadData()
        }
    }

}
