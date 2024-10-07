import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var calcButtons: [UIButton]!
    
    @IBOutlet weak var currentNumber: UILabel!
    @IBOutlet weak var secondaryNumber: UILabel!
    
    private var currentOperation = ""
    private var firstNumber: Double?
    private var secondNumber: Double?
    private var numberAfterResult = ""
    private var result = 0.0
    
    @IBAction func pressNumber(_ sender: UIButton) {
        guard let btnText = sender.titleLabel?.text else {
            return
        }
        
        guard let currentText = currentNumber.text else {
            return
        }
        
        if btnText == "." {
            if !currentText.contains(".") {
                currentNumber.text! += btnText
            }
            return
        }
        
        if currentNumber.text == "0" {
            currentNumber.text = btnText
            return
        }
        
        currentNumber.text! += btnText
    }
    
    @IBAction func pressOperation(_ sender: UIButton) {
        guard let operationText = sender.titleLabel?.text else {
            return
        }
        
        if operationText == "Clear" {
            firstNumber = nil
            secondNumber = nil
            currentOperation = ""
            currentNumber.text = "0"
            secondaryNumber.text = ""
            return
        }
        
        guard let currentNumberText = currentNumber.text else {
            return
        }
        
        if firstNumber == nil {
            firstNumber = Double(currentNumberText)
            secondaryNumber.text = currentNumberText + " " + operationText
        } else {
            if currentNumberText.isEmpty {
                currentOperation = operationText
                secondaryNumber.text = (secondaryNumber.text?.dropLast())! + operationText
                return
            }
            
            secondNumber = Double(currentNumberText)
            result = countResult()
            secondaryNumber.text = "\(result)" + operationText
            secondNumber = nil
            firstNumber = result
        }
        
        currentNumber.text = ""
        currentOperation = operationText
    }
    
    @IBAction func pressEquals(_ sender: UIButton) {
        guard let currentNumberText = currentNumber.text, !currentNumberText.isEmpty else {return}
        
        if firstNumber != nil {
            secondNumber = Double(currentNumberText)
            currentNumber.text = "\(countResult())"
            currentOperation = ""
            firstNumber = nil
            secondNumber = nil
            secondaryNumber.text = ""
        }
        
    }
    
    private func countResult() -> Double {
        switch currentOperation {
        case "X":
            return firstNumber!*secondNumber!
        case "/":
            return firstNumber!/secondNumber!
        case "–":
            return firstNumber!-secondNumber!
        case "+":
            return firstNumber!+secondNumber!
        default:
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        
    }
    
    
}

