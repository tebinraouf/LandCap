//
//  LoginView.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIScrollView {
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let btnSignIn = NSLocalizedString("Sign In", comment: "Sign in to your account");
        let btnRegister = NSLocalizedString("Register", comment: "Register to save your info in the cloud")
        let sc = UISegmentedControl(items: [btnSignIn, btnRegister])
        //sc.backgroundColor = .white
        sc.tintColor = .white
        sc.selectedSegmentIndex = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: UIControlEvents.valueChanged)
        return sc
    }()
    let container: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    let nameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        let txtPlaceholder = NSLocalizedString("enter name", comment: "enter your name here")
        textField.placeholder = txtPlaceholder
        return textField
    }()
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        let txtPlaceholder = NSLocalizedString("enter email address", comment: "enter your email address")
        textField.placeholder = txtPlaceholder
        textField.keyboardType = .emailAddress
        return textField
    }()
    let passTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let txtPlaceholder = NSLocalizedString("enter password", comment: "enter your password")
        textField.placeholder = txtPlaceholder
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var loginRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnName = NSLocalizedString("Register", comment: "Register user")
        btn.setTitle(btnName, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnName = NSLocalizedString("Forget Password", comment: "Forget the password label")
        btn.setTitle(btnName, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
        return btn
    }()
    
    let fieldHeight: CGFloat = 40
    let containerHeight: CGFloat = 40 * 3 + 30
    let containerHeightWithoutName: CGFloat = 40 * 3
    
    var containerConstraint: NSLayoutConstraint!
    var nameHeightConstraint: NSLayoutConstraint!
    var nameTopConstarint: NSLayoutConstraint!
    
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            nameTopConstarint.constant = 0
            nameTextField.isHidden = true
            forgetPasswordBtn.isHidden = false
            
            
        } else {
            nameTopConstarint.constant = 10
            nameTextField.isHidden = false
            forgetPasswordBtn.isHidden = true
            
        }
        
        containerConstraint.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? containerHeightWithoutName : containerHeight
        
        nameHeightConstraint.isActive = false
        let nameHeight: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : (1/3 - 0.06)
        nameHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: nameHeight)
        nameHeightConstraint.isActive = true
    }
    //MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubViews()
        setupSegmentedControl()
        setupContainer()
        setupForgetPassword()
        setupLoginRegisterBtn()
    }
    func addSubViews(){
        addSubview(loginRegisterSegmentedControl)
        addSubview(container)
        container.addSubview(nameTextField)
        container.addSubview(emailTextField)
        container.addSubview(passTextField)
        addSubview(forgetPasswordBtn)
        addSubview(loginRegisterButton)
    }
    func setupSegmentedControl(){
        NSLayoutConstraint.activate([
            loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginRegisterSegmentedControl.topAnchor.constraint(equalTo: topAnchor),
            loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: fieldHeight),
            loginRegisterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginRegisterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    func setupContainer(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        //height = name + email + password + spacing height
        containerConstraint = container.heightAnchor.constraint(equalToConstant: fieldHeight * 3 + 30)
        containerConstraint.isActive = true
        
        setupName()
        setupEmail()
        setupPassword()
    }
    func setupName(){
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ])
        
        nameTopConstarint = nameTextField.topAnchor.constraint(equalTo: container.topAnchor)
        nameTopConstarint.constant = 10
        nameTopConstarint.isActive = true
        
        nameHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3 - 0.06)
        nameHeightConstraint.isActive = true
    }
    func setupEmail() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    func setupPassword() {
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            passTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    func setupForgetPassword() {
        forgetPasswordBtn.topAnchor.constraint(equalTo: passTextField.bottomAnchor).isActive = true
        forgetPasswordBtn.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        forgetPasswordBtn.heightAnchor.constraint(equalTo: forgetPasswordBtn.heightAnchor).isActive = true
        forgetPasswordBtn.widthAnchor.constraint(equalTo: forgetPasswordBtn.widthAnchor).isActive = true
        forgetPasswordBtn.isHidden = true
    }
    func setupLoginRegisterBtn() {
        loginRegisterButton.topAnchor.constraint(equalTo: forgetPasswordBtn.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: fieldHeight).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        loginRegisterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -220).isActive = true
    }
    func keyboardResponder() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    var loginDelegate: LoginViewDelegate!
    //MARK: Button Handlers
    @objc private func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            handleSignIn()
        }else{
            handleRegister()
        }
        //hide the keyboard
        endEditing(true)
    }
    private func handleSignIn(){
        loginDelegate.signInBtn(email: emailTextField.text, password: passTextField.text)
    }
    private func handleRegister(){
        loginDelegate.registerBtn(name: nameTextField.text, email: emailTextField.text, password: passTextField.text)
    }
    @objc private func handleForgetPassword(){
        loginDelegate.forgetPasswordBtn()
    }
    
}



protocol LoginViewDelegate {
    func signInBtn(email: String?, password: String?)
    func registerBtn(name: String?, email: String?, password: String?)
    func forgetPasswordBtn()
    func getStartedBtn()
}
