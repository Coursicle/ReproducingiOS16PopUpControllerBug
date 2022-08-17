//
//  FlagPopUpController.swift
//  Coursicle
//
//  Created by Kiran Aida on 12/6/21.
//  Copyright © 2021 Coursicle. All rights reserved.
//

import UIKit

struct ContentType {
    
}

//get device screen width. This is actually used in multiple files.
let deviceScreenWidth = Int(UIScreen.main.bounds.size.width)
let deviceScreenHeight = Int(UIScreen.main.bounds.size.height)

// This is the view controller that displays the flag category options when a user
// wants to flag a post or comment for some type of inappropriate content.
class FlagPopUpController: UIViewController, UIAdaptivePresentationControllerDelegate {

    
    let backgroundView : UIView = UIView()
    let filterPopUpViewSlideDuration = 0.2
    var filterPopUpViewHeight = CGFloat(0.65*Double(deviceScreenHeight))
    let filterPopUpViewWidth = CGFloat(deviceScreenWidth)
    let filterPopUpViewRadius = CGFloat(10.0)
    let filterOptionsContainer = UIStackView()
    
    // These variables will be used to handle the pan gesture
    // to drag the class filter view on and off screen.
    lazy var startingPosition = filterPopUpViewHeight*2.3
    lazy var finalPosition = filterPopUpViewHeight*1.5
    lazy var turningPointToShow = finalPosition*1.4
    lazy var turningPointToHide = finalPosition*1.2
    
    // Header Sizing Variables
    let headerLabel : UILabel = UILabel()
    var headerLabelTopMargin : CGFloat = 28
    let headerLabelSideMargin : CGFloat = 20
    
    // Header Sizing Variables
    let descriptionLabel : UILabel = UILabel()
    var descriptionLabelTopMargin : CGFloat = 45
    let descriptionLabelSideMargin : CGFloat = 40
    
    // Apply Button Variables
    let submitButton = UIButton()
    var submitButtonWidth: CGFloat = CGFloat(deviceScreenWidth)*0.85
    var submitButtonHeight: CGFloat = 45
    var submitButtonFontSize: CGFloat = 18
    let submitButtonColor = UIColor.red
    let submitButtonColorLight = UIColor.init(named: "#F16660")
    
    // Sort option buttons
    let cheatingOption : MenuOptionsView = MenuOptionsView()
    let harassmentOption : MenuOptionsView = MenuOptionsView()
    let hateOption : MenuOptionsView = MenuOptionsView()
    let spamOption : MenuOptionsView = MenuOptionsView()
    let sexualOption : MenuOptionsView = MenuOptionsView()
    let violentOption : MenuOptionsView = MenuOptionsView()
    let otherOption : MenuOptionsView = MenuOptionsView()
    
    // currently selected option
    var currentlySelectedOption : String?
    
    // Delegate Controller
    var delegateController : PostViewController
    
    init(delegateController: PostViewController){
        
        // set delegate controller
        self.delegateController = delegateController
        
     
        
        // set viewToReturnTo so the correct view is displayed
        // once the class filter view is dismissed
        super.init(nibName: nil, bundle: nil)
        
       
        
        // add class filter view and background to the window
        delegateController.view.addSubview(backgroundView)
        delegateController.view.addSubview(view)
        
        // display translucent black backdrop to hide classes view
        // when class filter view is being displayed
        backgroundView.backgroundColor = UIColor.white
        backgroundView.frame = CGRect(x: 0, y: -deviceScreenHeight, width: deviceScreenWidth, height: deviceScreenHeight)
        
        // adjust layout variables based on screen size
        if UIDevice().screenType == .iPhones_6_6s_7_8 || UIDevice().screenType == .iPhone_12Mini {
            filterPopUpViewHeight = CGFloat(0.7*Double(deviceScreenHeight))
            startingPosition = filterPopUpViewHeight*2.3
            finalPosition = filterPopUpViewHeight*1.5
            turningPointToShow = finalPosition*1.4
            turningPointToHide = finalPosition*1.2
        }
        
        if UIDevice().screenType == .iPhones_6_6s_7_8{
            filterPopUpViewHeight = CGFloat(0.8*Double(deviceScreenHeight))
        }
        
        if UIDevice().screenType == .iPhone_12Mini{
            filterPopUpViewHeight = CGFloat(0.67*Double(deviceScreenHeight))
        }
        
        if UIDevice().screenType == .iPhone_XSMax_ProMax || UIDevice().screenType == .iPhone_12ProMax{
            filterPopUpViewHeight = CGFloat(0.58*Double(deviceScreenHeight))
        }
        
        // position class filter view off-screen initially (tried to do this
        // with layout anchors but seemed more complicated than it was
        // worth - could try doing it again if we find it's necessary)
        view.frame = CGRect(x: 0, y: CGFloat(deviceScreenHeight), width: filterPopUpViewWidth, height: filterPopUpViewHeight)
        view.layer.cornerRadius = filterPopUpViewRadius
        view.backgroundColor = .white
    }
    
    // add gesture recognizers so that when user taps outside of
    // class filter view or swipes down, the class filter view is dismissed
    override func viewDidLoad() {
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMyself)))
        
        // Set up the header label
        view.addSubview(headerLabel)
        headerLabel.font = .systemFont(ofSize: 24, weight: .bold)
        headerLabel.sizeToFit()
       
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: headerLabelSideMargin),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: headerLabelTopMargin),
        ])
        
        setUpFilterOptions()
        setUpSubmitButton()
        
    }

    func setUpFilterOptions() {
        
        filterOptionsContainer.translatesAutoresizingMaskIntoConstraints = false
        filterOptionsContainer.axis  = NSLayoutConstraint.Axis.vertical
        filterOptionsContainer.distribution  = UIStackView.Distribution.fillEqually
        filterOptionsContainer.alignment = UIStackView.Alignment.center
        filterOptionsContainer.spacing = 5
        
        view.addSubview(filterOptionsContainer)
        
        filterOptionsContainer.addArrangedSubview(cheatingOption)
        filterOptionsContainer.addArrangedSubview(harassmentOption)
        filterOptionsContainer.addArrangedSubview(hateOption)
        filterOptionsContainer.addArrangedSubview(spamOption)
        filterOptionsContainer.addArrangedSubview(sexualOption)
        filterOptionsContainer.addArrangedSubview(violentOption)
        filterOptionsContainer.addArrangedSubview(otherOption)
        
        
        
        cheatingOption.infoLabel.text = "Cheating"
        harassmentOption.infoLabel.text = "Harassment"
        hateOption.infoLabel.text = "Hate"
        spamOption.infoLabel.text = "Spam"
        sexualOption.infoLabel.text = "Nudity"
        violentOption.infoLabel.text = "Violence"
        otherOption.infoLabel.text = "Other"
        
        cheatingOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        harassmentOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        hateOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        spamOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        sexualOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        violentOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        otherOption.addTarget(self, action: #selector(selectNewSortOption(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            filterOptionsContainer.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            filterOptionsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    func setUpSubmitButton() {
        // Create apply now button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = submitButtonHeight/2
        
        if(UIDevice().screenType == .iPhones_5_5s_5c_SE){submitButtonFontSize -= 4}
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: submitButtonFontSize, weight: UIFont.Weight.regular)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.backgroundColor = .systemGray
        
        // Add gesture recognizer for the apply button
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonTouchedDown), for: .touchDown)
        
        // Add apply button to the view and set position
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: filterOptionsContainer.bottomAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: submitButtonWidth),
            submitButton.heightAnchor.constraint(equalToConstant: submitButtonHeight),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func submitButtonTapped(_ sender: UIButton) {
       
        
        // Dismiss Filter modal screen
        dismissMyself()
    }
    
    @objc func submitButtonTouchedDown(_ sender: UIButton){
        sender.backgroundColor = submitButtonColorLight
    }
    
    @objc func selectNewSortOption(_ sender: MenuOptionsView) {
        submitButton.backgroundColor = submitButtonColor
        
        cheatingOption.backgroundColor = .white
        harassmentOption.backgroundColor = .white
        hateOption.backgroundColor = .white
        spamOption.backgroundColor = .white
        sexualOption.backgroundColor = .white
        violentOption.backgroundColor = .white
        otherOption.backgroundColor = .white
    
        cheatingOption.checkmarkIconView.isHidden = true
        harassmentOption.checkmarkIconView.isHidden = true
        hateOption.checkmarkIconView.isHidden = true
        spamOption.checkmarkIconView.isHidden = true
        sexualOption.checkmarkIconView.isHidden = true
        violentOption.checkmarkIconView.isHidden = true
        otherOption.checkmarkIconView.isHidden = true
        
        sender.backgroundColor = UIColor.init(named: "#F2F2F2")
        sender.checkmarkIconView.isHidden = false
        currentlySelectedOption = sender.infoLabel.text
    }
    
    // this function sets up and displays the class filter view -
    // this gets called from the home view controller
    func displayFlagPopUp() {
        backgroundView.frame = CGRect(x: 0, y: 0, width: deviceScreenWidth, height: deviceScreenHeight)
        // slide in class filter view with animation
        UIView.animate(withDuration: filterPopUpViewSlideDuration, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            self.view.frame = CGRect(x: 0, y: CGFloat(deviceScreenHeight)-self.filterPopUpViewHeight, width: self.filterPopUpViewWidth, height: self.filterPopUpViewHeight)
        })
    }
    
    // This function slides the class filter view off-screen and fades out the backgroundView
    @objc override func dismissMyself() {
        UIView.animate(withDuration: filterPopUpViewSlideDuration, animations: {
            self.backgroundView.alpha = 0
            self.view.frame = CGRect(x: 0, y: CGFloat(deviceScreenHeight), width: self.filterPopUpViewWidth, height: self.filterPopUpViewHeight)
        }, completion : { finished in
            self.backgroundView.frame = CGRect(x: 0, y: deviceScreenHeight, width: deviceScreenWidth, height: deviceScreenHeight)
            self.view.removeFromSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

