//
//  ViewController.swift
//  Silly Song
//
//  Created by Adrian Borcea on 07/10/2016.
//

// UIKit framework, using for textfields, buttons etc
import UIKit

// create ViewController class of UIViewController type. UITextFieldDelegate is a delegate for UITextField. Here we are confirming that this class will implement that protocol.

// UITextFieldDelegate tells when a textfield is start editing, end editing, when return key pressed and so on.
class ViewController: UIViewController , UITextFieldDelegate{

    // creating outlets for storyboard items to access them in the class.
    @IBOutlet weak var txtLyrics: UITextView!
    
    @IBOutlet weak var txtName: UITextField!
    
    // action method when textfield begins editing. connected through storyboard.
    @IBAction func reset(sender: AnyObject) {
        
        // clearing any text from textfield (for name) and textview (for lyrics)
        txtName.text = ""
        txtLyrics.text = ""
    }
    
    // action method when textfield ends editing. connected through storyboard.
    @IBAction func displayLyrics(sender: AnyObject) {
        
        // this line called to hide keyboard and end editing of textfield
        txtName.resignFirstResponder()
        
        // unwrapping the text from the textfield
        if let userName = txtName.text {
            
            // creating a string by joining diffrent strings. Each part is joined by a new line.
            let template = [
                "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
                "Banana Fana Fo F<SHORT_NAME>",
                "Me My Mo M<SHORT_NAME>",
                "<FULL_NAME>"].joinWithSeparator("\n")
            
            // calling function lyricsForName and assigning the return string to textview for lyrics
            txtLyrics.text=self.lyricsForName(fullName: userName, template: template)
            
        }
    }
    
    // override keyword is used when a method exists in parent class and child class override it's implementation.
    override func viewDidLoad() {
        
        // super is used to call the method from parent class.
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func lyricsForName(fullName fullName:String, template: String) -> String {
        
        // calling shortNameFromName function
        let shortName = self.shortNameFromName(fullName)
        
        // replace all the <FULL_NAME> from template with fullName parameter.
        // replace all the <SHORT_NAME> from template with shortName.
        let lyrics = template
            .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
            .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
        // return the modified lyrics
        return lyrics
    }
    
    func shortNameFromName(fullName: String) -> String {
        
        // convert the fullName into lowercase letters
        let shortName = fullName.lowercaseString

        // defining all vowels
        let vowelString = "aeiou"
        // creating a character set for all vowel letters
        let vowelCharacterSet = NSCharacterSet(charactersInString:vowelString)
        
        // find the range of first vowel character, if found, goes inside the block otherwie return the name as it is.
        if let firstVowelRange = shortName.rangeOfCharacterFromSet(vowelCharacterSet, options: .CaseInsensitiveSearch) {
            
            // trim the characters from the startIndex of the range of first vowel
            return shortName.substringFromIndex(firstVowelRange.startIndex)
        }
        
        return shortName
    }
    
    //MARK: TextField Delegate Methods
    
    // This is the delegate method for textfield. This method is called whenever user press return key.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // hide keyboard and end editing
        txtName.resignFirstResponder()
        
        return true
    }
}

