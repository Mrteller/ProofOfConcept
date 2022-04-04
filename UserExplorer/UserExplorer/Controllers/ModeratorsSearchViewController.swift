import UIKit

class ModeratorsSearchViewController: UIViewController {
    private enum SegueIdentifiers {
        static let list = "ListViewController"
    }
    
    @IBOutlet var siteTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    private var behavior: ButtonEnablingBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Search", comment: "Controller title")
        
        behavior = ButtonEnablingBehavior(textFields: [siteTextField]) { [unowned self] enable in
            if enable {
                self.searchButton.isEnabled = true
                self.searchButton.alpha = 1
            } else {
                self.searchButton.isEnabled = false
                self.searchButton.alpha = 0.7
            }
        }
        
        siteTextField.setBottomBorder()
        
        siteTextField.text = "stackoverflow"
        // Just to trigger button enabled
        behavior.textFieldDidChange(behavior.textFields.first!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.list {
            if let listViewController = segue.destination as? ModeratorsListViewController,
               let siteName = siteTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                listViewController.site = siteName
            }
        }
    }
}
