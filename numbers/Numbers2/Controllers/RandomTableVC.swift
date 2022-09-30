//
//  ViewController.swift
//  Numbers2
//
//  
//  
//

import UIKit

// This is going to be a VC with a button, text field, another button, and a table.
class RandomTableVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var buttonTextFieldStackView: UIStackView!
    @IBOutlet weak var textFieldButtonStackView: UIStackView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var factsTableView: UITableView!
    
    // MARK: - Actions
    @objc private func categoryButtonPressed(_ sender: UIButton) {
        // The sender is the current button you pressed; it is a reference to it.
    }
    
    @objc private func goButtonPressed(_ sender: UIButton) {
        // ??: nil-coalesching operator: defaults to the right side if the left is nil.
        // ALWAYS validate text fields where user can input text.
        guard let number = Int(numberTextField.text ?? "") else {
            // If it fails to make an integer from the text field, it will fall in here.
            return
        }
        
        // Call the API, print the results.
        // Part of MVC is separating the Network logic from view controllers. We dont want the
        // view controller to be concerned with managing the network setup.
        NetworkManager().call(using: number) { (data) in
            // Present the alert on the main thread to prevent UI changes in background.
            DispatchQueue.main.async {
                // You will have to use "self" when referencing something outside the closure.
                self.presentFactAlert(with: data)
            }
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func presentFactAlert(with data: Data) {
        if let numberFact: NumberFactModel = try? JSONDecoder().decode(NumberFactModel.self, from: data) {
            let alert = UIAlertController(title: "\(numberFact.type): \(numberFact.number)", message: numberFact.description, preferredStyle: UIAlertController.Style.alert)
            // The actions are the buttons that the alert will have. The handler is code you want to execute after the user presses the button.
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            // You need to add the actions to the alert.
            alert.addAction(okAction)
            // Present the alert to the user.
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UI
extension RandomTableVC {
    // Setup the UI of the outlets, styling, etc.
    private func setupUI() {
        categoryButton.setTitle("Category", for: UIControl.State.normal)
        categoryButton.addTarget(self, action: #selector(categoryButtonPressed), for: UIControl.Event.touchUpInside)
        goButton.setTitle("Go", for: UIControl.State.normal)
        goButton.addTarget(self, action: #selector(goButtonPressed), for: UIControl.Event.touchUpInside)
        numberTextField.placeholder = "Enter Number"
        numberTextField.keyboardType = UIKeyboardType.decimalPad
        buttonTextFieldStackView.spacing = 12
        buttonTextFieldStackView.distribution = UIStackView.Distribution.fillEqually
        textFieldButtonStackView.spacing = 8
        textFieldButtonStackView.distribution = UIStackView.Distribution.fillProportionally
    }
    
    // Setup the constraints of the outlets.
    private func setupConstraints() {
        // ALWAYS make sure that elements are in the same layer.
        // ALWAYS set to false if you are doing programmatic constraints.
        buttonTextFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        // Use negatives for right constraint to make it not go off the edge (negative goes left, positive goes right)
        buttonTextFieldStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        buttonTextFieldStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Prevent it from hiding under the navigation bar/tab bar by using safeAreaLayoutGuide anchors.
        buttonTextFieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        
        factsTableView.translatesAutoresizingMaskIntoConstraints = false
        factsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        factsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        factsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Only use other outlet constraints if they are in the same layer.
        factsTableView.topAnchor.constraint(equalTo: buttonTextFieldStackView.bottomAnchor, constant: 12).isActive = true
    }
}
