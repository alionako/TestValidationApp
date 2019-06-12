import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var first: MyTextField!
    @IBOutlet weak var second: MyTextField!
    @IBOutlet weak var third: MyTextField!
    @IBOutlet weak var fourth: MyTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        second.validationDelegate.set(textFieldRules: [
            MoreThanOtherTextField(with: first),
            LessThanOtherTextField(with: third)
        ])
    }
}
