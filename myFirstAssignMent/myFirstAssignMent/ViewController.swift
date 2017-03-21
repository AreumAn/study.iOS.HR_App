//
//  ViewController.swift
//  myFirstAssignMent
//
//  Created by Areum on 2016-11-24.
//  Copyright © 2016 Areum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    // declare
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    
    @IBOutlet weak var empListTableView: UITableView!
    
    
    
    // countryPicker list
    let countryList : [String] = ["Korea", "Brazil", "Canada", "America", "Slovakia"]
    
    // make array
    var arrEmployees: [Employee] = [Employee]()
    
    var currentEmployee : Employee? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        empListTableView.delegate = self
        
        txtEmpName.delegate = self
        txtSearch.delegate = self
        txtDateOfBirth.delegate = self
        txtCountry.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //***************************** txt birthday*****************************//
    
    // when it openㄴ the datepicker, keyboard is disappear
    @IBAction func dateOfBirthKeyboard(_ sender: Any) {
        keyboardClose()
    }
    
    
    // when touch name textbox, open date picker
    @IBAction func dateOfBirthPickerPress(_ sender: UITextField) {
        dateOfBirthPicker.isHidden = false
        keyboardClose()
    }
    
    
    // change the value and show BOD textbox
    @IBAction func dateOfBirthPickerChange(_ sender: UIDatePicker) {
        
        let myDate : Date = dateOfBirthPicker.date
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        txtDateOfBirth.text = formatter.string(from: myDate)

 

    }
    
    // did edit name textbox, picker disappear
    @IBAction func dateOfBirthPickerEnd(_ sender: UITextField) {
         dateOfBirthPicker.isHidden = true
        
    }
    
    
    
    //***************************** txtCountry *****************************//
    
    // when touches txtcountry, keyboard will be disappear
    @IBAction func contryKeyboard(_ sender: Any) {
        keyboardClose()
    }
    
    // when touches country textbox, country picker will be opened
    @IBAction func countryPickerPress(_ sender: UITextField) {
        countryPicker.isHidden = false
        keyboardClose()

    }
    
    // did edit country box, picker disappear
    @IBAction func countyPickerEnd(_ sender: UITextField) {
        countryPicker.isHidden = true
    }
    
    
    
    
    
    //***************************** pickerView *****************************//
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtCountry.text = "\(countryList[row])"
        countryPicker.isHidden = true
    }
    
    
    //***************************** alertMessage *****************************//
    
    func alertMessage(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //***************************** add button *****************************//
    
    @IBAction func btnEmpAdd(_ sender: AnyObject) {
        
        
        // check if txtname is existed.
        var existEmp : Bool = false
        
        for arrEmp in arrEmployees {
            if (arrEmp.getName() == txtEmpName.text) {
                existEmp = true
            }
        }
        
        
        
        if existEmp {
            // if txtname is existed, don't save employee information
            txtEmpName.becomeFirstResponder()
            alertMessage(message: "\(txtEmpName.text!) is already existed")
        } else{
            // check validity
            if (txtEmpName.text?.isEmpty)! {
                txtEmpName.becomeFirstResponder()
                alertMessage(message: "Please, Enter employee's name")
            } else if (txtDateOfBirth.text?.isEmpty)! {
                txtDateOfBirth.becomeFirstResponder()
                alertMessage(message: "Please, Select employee's birthday")
            } else if (txtCountry.text?.isEmpty)! {
                txtCountry.becomeFirstResponder()
                alertMessage(message: "Please, Select employee's country")
            } else {
            // add employee information
            var Emp : Employee
            Emp = Employee(pName: txtEmpName.text!, pDateOfBirth: txtDateOfBirth.text!, pCountry: txtCountry.text!)
            arrEmployees.append(Emp)
            clearField()
            alertMessage(message: "\(Emp.getName()) added")
            
            empListTableView.reloadData()

            
            }
            
        }
        
        
        
        

    }
    
    
    //***************************** search button *****************************//
    
    @IBAction func btnSearchEmp(_ sender: UIButton) {
        
        // check validity
        if (txtSearch.text?.isEmpty)! {
            txtSearch.becomeFirstResponder()
            alertMessage(message: "Please, Enter employee's name")
        }
        
        // search the employee and show those information
        let nameToSearch = txtSearch.text
        var found = false
        
        for i in 0..<arrEmployees.count{
            if arrEmployees[i].getName() == nameToSearch {
                currentEmployee = arrEmployees[i]
                txtEmpName.text = arrEmployees[i].getName()
                txtDateOfBirth.text = arrEmployees[i].getDateOfBirth()
                txtCountry.text = arrEmployees[i].getCountry()
                found = true
                txtSearch.text = nil
                break
            }
        }

        
        if !found{
            alertMessage(message: "Not Found")
        }
        
        
    }
    
    
    
    //***************************** update button *****************************//
    
    @IBAction func btnUpdateEmp(_ sender: UIButton) {
        
        if(txtEmpName.text?.isEmpty)! || (txtDateOfBirth.text?.isEmpty)! || (txtCountry.text?.isEmpty)!{
          alertMessage(message: "Search the name before you update data")
        } else if(currentEmployee == nil){
          alertMessage(message: "Search the name before you update data")
        } else {
            let curEmp = currentEmployee
            
            curEmp?.setName(pName: txtEmpName.text!)
            curEmp?.setDateOfBirth(pDateOfBirth: txtDateOfBirth.text!)
            curEmp?.setCountry(pCountry: txtCountry.text!)
            alertMessage(message: "\(txtEmpName.text!)'s information Updated")
            clearField()
            
            currentEmployee = nil
            empListTableView.reloadData()
        }
        
        
        
    }
    
    
      //***************************** age button *****************************//
    
    
    @IBAction func btnShowAge(_ sender: UIButton) {
        
        if (txtDateOfBirth.text?.isEmpty)! {
            
            alertMessage(message: "Please, Select employee's birthday")
            
        } else {
        // get this year
        let date = Date()
        let calendar = Calendar.current
        let tempCal = (calendar as NSCalendar).components([.day, .month, .year], from: date)
        let thisYear : Int = tempCal.year!
        // get birthday year
        func substring(from: Int) -> String {
            let fromIndex = index(ofAccessibilityElement: from)
            return substring(from: fromIndex)
        }
            
        let tmepBirthtxt = txtDateOfBirth.text!
        let dex = tmepBirthtxt.index(tmepBirthtxt.startIndex, offsetBy: 7)
        let birthYear : Int = Int(tmepBirthtxt.substring(from: dex))!
            
           
        // calculate
        let empAge = thisYear - birthYear
        // show age
        lblAge.text = "\(empAge) years old"
        }

        
    }
    
    
    //***************************** clear btn *****************************//
    
    @IBAction func btnClear(_ sender: AnyObject) {
        clearField()
    }
    
    //***************************** clearField *****************************//
    
    func clearField(){
        txtEmpName.text = nil
        txtDateOfBirth.text = nil
        txtCountry.text = nil
        dateOfBirthPicker.isHidden = true
        countryPicker.isHidden = true
        txtSearch.text = nil
        lblAge.text = nil
        let date = Date()
        dateOfBirthPicker.setDate(date, animated: true)
        countryPicker.selectRow(0, inComponent: 0, animated: true)
        view.endEditing(true)
       
        
    }
    
    
    //***************************** show table view *****************************//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmpTableViewCell
        
        cell.lblName.text = arrEmployees[indexPath.row].getName()
        cell.lblDateOfBirthday.text = arrEmployees[indexPath.row].getDateOfBirth()
        cell.lblCountry.text = arrEmployees[indexPath.row].getCountry()
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmployees.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return "NAME           BIRTHDAY         COUNTRY"

    }
    

    
    //*****************************  keyboard control *****************************//
    
    // when push the return button, keyboard disappear
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }

    }
    
    func keyboardClose() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dateOfBirthPicker.isHidden = true
        countryPicker.isHidden = true

        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtEmpName.resignFirstResponder()
        self.txtDateOfBirth.resignFirstResponder()
        self.txtCountry.resignFirstResponder()
        self.txtSearch.resignFirstResponder()
        
        return false
    }




}

