//
//  TrainViewController.swift
//  Verregular
//
//  Created by Polina Tereshchenko on 01.08.2023.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Properties
    private let edgeInsets =   30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            // numberOfCurrentVerbLabel.text = "\(count + 1) from \(dataSource.count)"
            pastSimpleTextField.text = ""
            participleTextField.text = ""
        }
    }
    // private var rightAnswersCount = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    //MARK: Private methods
    
    @objc
    private func checkAction() {
        if checkAnswers() {
<<<<<<< HEAD
            count += 1
            //      rightAnswersCount += 1
=======
            changeRightAnswersCount(isPreviousAnswerRight: isPreviousAnswerRight)
        if currentVerb?.infinitive != dataSource.last?.infinitive {
                count += 1
                isPreviousAnswerRight = true
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Check".localized, for: .normal)
                checkButton.setTitleColor(UIColor.black, for: .normal)
            } else {
                numberOfRightAnswersLabel.text = "Score: ".localized + "\(rightAnswersCount)"
                showAlert(titleController: "The end of selected verbs".localized,
                          messageController: "Your score is ".localized + "\(rightAnswersCount). \n" +
                          "You can choose other verbs and train again!".localized,
                          titleButton: "Back to the homepage".localized,
                          isLastVerb: true)
            }
>>>>>>> homework
        } else {
            checkButton.setTitle("Try again".localized,
                                 for: .normal)
            checkButton.backgroundColor = .red
<<<<<<< HEAD
=======
            isPreviousAnswerRight = false        }
    }
    
    @objc
    private func skipAction() {
        if currentVerb?.infinitive == dataSource.last?.infinitive {
            showAlert(titleController: "Let's remember!".localized,
                      messageController: "Past Simple form: \(currentVerb?.pastSimple ?? ""). \n Past Participle form: \(currentVerb?.participle ?? ""). \n" +
                      "That was last verb.".localized + "\n" +
                      "Your score is ".localized + "\(rightAnswersCount). \n" +
                      "You can choose other verbs and train again!".localized,
                      titleButton: "Back to the homepage".localized,
                      isLastVerb: true)
        } else {
            showAlert(titleController: "Let's remember!".localized,
                      messageController: "Past Simple form: \(currentVerb?.pastSimple ?? ""). \n Past Participle form: \(currentVerb?.participle ?? "").",
                      titleButton: "Next verb".localized,
                      isLastVerb: false)
            isPreviousAnswerRight = true
        }
        checkButton.backgroundColor = .systemGray5
        checkButton.setTitle("Check".localized, for: .normal)
        checkButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    private func showAlert(titleController: String,
                           messageController: String,
                           titleButton: String,
                           isLastVerb: Bool) {
        let alert = UIAlertController(title: titleController,
                                      message: messageController,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: titleButton,
                                   style: .default) { (action) in
            if isLastVerb {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.count += 1
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func changeRightAnswersCount(isPreviousAnswerRight: Bool) {
        if isPreviousAnswerRight {
            rightAnswersCount += 1
>>>>>>> homework
        }
    }
    
    private func checkAnswers() -> Bool {
        return pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() == currentVerb?.participle.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([
            // numberOfCurrentVerbLabel,
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            participleLabel,
            participleTextField,
            checkButton])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
    }
}
//MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        
        return true
    }
}

//MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame =
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 100
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
