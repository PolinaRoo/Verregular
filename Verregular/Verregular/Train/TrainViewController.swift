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
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var numberOfCurrentVerbLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray5
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Verb: ".localized + "\(count + 1)" + " from ".localized + "\(dataSource.count)"
            
        return label
    }()
    
    private lazy var numberOfRightAnswersLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray5
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Score: ".localized + "\(rightAnswersCount)"
            
        return label
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.setTitle("Skip".localized, for: .normal)
        button.setTitleColor(UIColor.systemGray5, for: .normal)
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
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
            numberOfCurrentVerbLabel.text = "Verb: ".localized + "\(count + 1)" + " from ".localized + "\(dataSource.count)"
            numberOfRightAnswersLabel.text = "Score: ".localized + "\(rightAnswersCount)"
            pastSimpleTextField.text = ""
            participleTextField.text = ""
        }
    }
    private var rightAnswersCount = 0
    private var isPreviousAnswerRight = true
    
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
        if currentVerb?.infinitive != dataSource.last?.infinitive {
            if checkAnswers() {
                if isPreviousAnswerRight {
                    rightAnswersCount += 1
                }
                count += 1
                isPreviousAnswerRight = true
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Check".localized, for: .normal)
                checkButton.setTitleColor(UIColor.black, for: .normal)
            } else {
                checkButton.setTitle("Try again".localized,
                                     for: .normal)
                checkButton.backgroundColor = .red
                isPreviousAnswerRight = false
            }
        } else {
            if checkAnswers() {
                if isPreviousAnswerRight {
                    rightAnswersCount += 1
                }
                numberOfRightAnswersLabel.text = "Score: ".localized + "\(rightAnswersCount)"
                let alert = UIAlertController(title: "The end of selected verbs".localized,
                                              message: "Your score is ".localized + "\(rightAnswersCount). " + "You can choose other verbs and train again!".localized,
                                              preferredStyle: .alert)
                let action = UIAlertAction(title: "Back to the homepage".localized , style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                
                present(alert, animated: true)
            } else {
                checkButton.setTitle("Try again".localized,
                                     for: .normal)
                checkButton.backgroundColor = .red
                isPreviousAnswerRight = false
            }
        }
    }
    
    @objc
    private func skipAction() {
        if currentVerb?.infinitive == dataSource.last?.infinitive {
            
            let alert = UIAlertController(title: "Let's remember!".localized,
                                          message: "Past Simple form: \(currentVerb?.pastSimple ?? ""). \n Past Participle form: \(currentVerb?.participle ?? ""). \n" + "That was last verb.".localized + "\n" + "Your score is ".localized + "\(rightAnswersCount). \n" + "You can choose other verbs and train again!".localized ,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Back to the homepage".localized , style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Let's remember!".localized,
                                          message: "Past Simple form: \(currentVerb?.pastSimple ?? ""). \n Past Participle form: \(currentVerb?.participle ?? "").",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Next verb".localized , style: .default) { (action) in
                self.count += 1
            }
            alert.addAction(action)
            
            present(alert, animated: true)
            
            isPreviousAnswerRight = false
        }
    }
    
    private func checkAnswers() -> Bool {
        return pastSimpleTextField.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == currentVerb?.participle.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([
            numberOfCurrentVerbLabel,
            numberOfRightAnswersLabel,
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            participleLabel,
            participleTextField,
            checkButton,
            skipButton])
        
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
        
        numberOfCurrentVerbLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(edgeInsets)
            make.width.equalTo(130)
        }
        
       numberOfRightAnswersLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.trailing.equalToSuperview().inset(edgeInsets)
            make.width.equalTo(70)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.bottom).offset(10)
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
        scrollView.contentInset.bottom = .zero - 50
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
