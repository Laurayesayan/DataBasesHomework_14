import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var tasksList: [String] = []
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.allowsMultipleSelectionDuringEditing = true
        updateTasksList()
    }
    
    func removeTask(task: String) {
        RealmPersistance.shared.deleteTask(toDelete: task)
    }
    
    @IBAction func deleteRows(_ sender: Any) {
        if let selectedRows = todoTableView.indexPathsForSelectedRows {

            var items: [String] = []
            for indexPath in selectedRows  {
                items.append(tasksList[indexPath.row])
            }

            for item in items {
                if let index = tasksList.firstIndex(of: item) {
                    removeTask(task: tasksList[index])
                    tasksList.remove(at: index)
                }
            }

            todoTableView.beginUpdates()
            todoTableView.deleteRows(at: selectedRows, with: .automatic)
            todoTableView.endUpdates()
        }
        
        todoTableView.isEditing = false
        updateTasksList()
    }
    
    func updateTasksList() {
        tasksList = RealmPersistance.shared.getRecoordedTask()
    }
    
    @IBAction func onEditingMode(_ sender: Any) {
        todoTableView.isEditing = !isEditing
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


}
