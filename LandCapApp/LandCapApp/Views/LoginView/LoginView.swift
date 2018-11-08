//
//  LoginView.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

///The Login view components
class LoginView: UIScrollView {
    private lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [App.label.signIn, App.label.signUp])
        //sc.backgroundColor = .white
        sc.tintColor = UIColor.textColor
        sc.selectedSegmentIndex = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: UIControlEvents.valueChanged)
        return sc
    }()
    private let container: UIView = {
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
        textField.textColor = UIColor.textColor
        textField.placeholder = App.label.enterName
        return textField
    }()
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = UIColor.textColor
        textField.placeholder = App.label.enterEmail
        textField.keyboardType = .emailAddress
        return textField
    }()
    let passTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = App.label.enterPassword
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = UIColor.textColor
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var loginRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(App.label.signUp, for: .normal)
        btn.setTitleColor(UIColor.mainColor, for: .normal)
        btn.backgroundColor = UIColor.textColor
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(App.label.forgotPassword, for: .normal)
        btn.setTitleColor(UIColor.textColor, for: .normal)
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
    ///Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        setupViews()
    }
    ///Required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///Initial setup
    func setupViews(){
        addSubViews()
        setupSegmentedControl()
        setupContainer()
        setupForgetPassword()
        setupLoginRegisterBtn()
    }
    private func addSubViews(){
        addSubview(loginRegisterSegmentedControl)
        addSubview(container)
        container.addSubview(nameTextField)
        container.addSubview(emailTextField)
        container.addSubview(passTextField)
        addSubview(forgetPasswordBtn)
        addSubview(loginRegisterButton)
    }
    private func setupSegmentedControl(){
        NSLayoutConstraint.activate([
            loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginRegisterSegmentedControl.topAnchor.constraint(equalTo: topAnchor),
            loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: fieldHeight),
            loginRegisterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginRegisterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    private func setupContainer(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        containerConstraint = container.heightAnchor.constraint(equalToConstant: fieldHeight * 3 + 30)
        containerConstraint.isActive = true
        setupName()
        setupEmail()
        setupPassword()
    }
    private func setupName(){
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
    private func setupEmail() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    private func setupPassword() {
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            passTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    private func setupForgetPassword() {
        forgetPasswordBtn.topAnchor.constraint(equalTo: passTextField.bottomAnchor).isActive = true
        forgetPasswordBtn.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        forgetPasswordBtn.heightAnchor.constraint(equalTo: forgetPasswordBtn.heightAnchor).isActive = true
        forgetPasswordBtn.widthAnchor.constraint(equalTo: forgetPasswordBtn.widthAnchor).isActive = true
        forgetPasswordBtn.isHidden = true
    }
    private func setupLoginRegisterBtn() {
        loginRegisterButton.topAnchor.constraint(equalTo: forgetPasswordBtn.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: fieldHeight).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        loginRegisterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -220).isActive = true
    }
    ///Handle keyboard responsiveness
    public func keyboardResponder() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    ///LoginViewDelegate instance to handle login actions
    public var loginDelegate: LoginViewDelegate!
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
        loginDelegate.forgotPasswordBtn()
    }
    
}


///LoginView protocol to handle actions
protocol LoginViewDelegate {
    ///Event listener for sign in button
    /// - Parameter email: the entered email
    /// - Parameter password: the entered password
    ///
    /// - Returns: Void
    func signInBtn(email: String?, password: String?)
    
    ///Event listener for sign up button
    /// - Parameter name: the user name
    /// - Parameter email: the entered email
    /// - Parameter password: the entered password
    ///
    /// - Returns: Void
    func registerBtn(name: String?, email: String?, password: String?)
    
    ///Listener for fogot button
    func forgotPasswordBtn()
    
    ///Listener for Skip button
    func skipBtn()
}
