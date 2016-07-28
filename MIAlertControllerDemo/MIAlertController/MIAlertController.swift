//
//  MIAlertController.swift
//  MIAlertController
//
//  Created by Mario on 10/07/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import UIKit

class MIAlertController: UIViewController {
    
    typealias ButtonTappedClosure = (buttonIndex: Int) -> ()
    
    struct Config {
        
        // Behavior
        var dismissOnTouchOutsideEnabled = true
        
        // BackgroundView
        var backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        // Alert View
        var alertViewBackgroundColor = UIColor.whiteColor()
        var alertViewCornerRadius: CGFloat = 10
        var alertMarginSize = CGSize(width: 40, height: 30)
        var separatorColor = UIColor.clearColor()
        var alertViewMaxSize = CGSize(width: 300, height: 300)
        
        // Title
        var titleLabelFont = UIFont.boldSystemFontOfSize(19)
        var titleLabelTextColor = UIColor.blackColor()
        var titleLabelTextAlignment = NSTextAlignment.Center
        
        // Message
        var messageLabelFont = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        var messageLabelTextColor = UIColor.blackColor()
        var messageLabelTextAlignment = NSTextAlignment.Center
        var messageVerticalSpaceFromTitle: CGFloat = 10
        
        // Buttons
        var separatorsBetweenButtons = UIColor.clearColor()
        var buttonBackgroundView = UIColor.whiteColor()
        var firstButtonRatio: CGFloat = 0.5 // Only available with two buttons; ratio between the width of the buttons container and the width of the first button
        
    }
    
    struct Button {
        
        struct Config {
            
            var font = UIFont.boldSystemFontOfSize(15)
            var textColor = UIColor.blackColor()
            var textAlignment = UIControlContentHorizontalAlignment.Center
            var backgroundColor = UIColor.clearColor()
            var buttonHeight: CGFloat = 60
            var contentEdgeOffset = UIEdgeInsetsZero
            
        }
        
        enum Type {

            case Default
            case Destructive
            case Cancel
            
            var config: Config {
                
                switch self {
                    
                case .Default:
                    
                    return Config(
                        font: UIFont.systemFontOfSize(16),
                        textColor: UIColor(red: 33/255.0, green: 129/255.0, blue: 247/255.0, alpha: 1),
                        textAlignment: .Center,
                        backgroundColor: UIColor.clearColor(),
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsetsZero
                    )
                    
                case .Destructive:
                    
                    return Config(
                        font: UIFont.boldSystemFontOfSize(16),
                        textColor: UIColor(red: 218/255.0, green: 75/255.0, blue: 56/255.0, alpha: 1),
                        textAlignment: .Center,
                        backgroundColor: UIColor.clearColor(),
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsetsZero
                    )
                    
                case Cancel:
                    
                    return Config(
                        font: UIFont.boldSystemFontOfSize(16),
                        textColor: UIColor(red: 33/255.0, green: 129/255.0, blue: 247/255.0, alpha: 1),
                        textAlignment: .Center,
                        backgroundColor: UIColor.clearColor(),
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsetsZero
                    )
                    
                }
                
            }
            
        }
        
        var type = Type.Default
        var config: Config!
        var title: String?
        
        init(title: String, type: Type = .Default, config: Config? = nil) {
            
            self.title = title
            self.config = config ?? type.config
            
        }
        
        func createUIButton() -> UIButton {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: config.buttonHeight))
            
            button.setTitle(title, forState: .Normal)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.7
            button.setTitleColor(config.textColor, forState: .Normal)
            button.titleLabel?.font = config.font
            button.backgroundColor = config.backgroundColor
            button.contentHorizontalAlignment = config.textAlignment
            
            button.contentEdgeInsets = config.contentEdgeOffset
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
            
        }
        
    }
    
    var config: Config!
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtons: [Button]?
    
    var buttonTappedClosure: ButtonTappedClosure?
    
    var isPresenting: Bool = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertBackgroundView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var buttonsBackgroundView: UIView!
    @IBOutlet weak var buttonsBackgroundViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var alertViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageVerticalSpaceFromTitleConstraint: NSLayoutConstraint!
    
    @IBOutlet var dismissOnTapGestureRecognizer: UITapGestureRecognizer!
    
    var buttonsList: [UIButton]!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String? = nil, message: String? = nil, buttons: [Button]? = nil, config: Config? = nil) {
        
        super.init(nibName: "MIAlertController", bundle: nil)
        
        self.config = config ?? Config()
        
        self.alertTitle = title
        self.alertMessage = message
        self.alertButtons = buttons
        
    }
    
    func presentOn(parentVC: UIViewController, buttonTapped: ButtonTappedClosure?) {
        
        buttonTappedClosure = buttonTapped
        
        self.modalPresentationStyle = .OverCurrentContext
        self.transitioningDelegate = self
        
        parentVC.presentViewController(self, animated: true) {}
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        setupAlertView()
        setupTitleLabelUI()
        setupMessageLabelUI()
        
        view.layoutIfNeeded()
        
    }
    
    private func setupAlertView() {
        
        view.backgroundColor = UIColor.clearColor()
        
        backgroundView.backgroundColor = config.backgroundColor
        
        alertBackgroundView.backgroundColor = config.alertViewBackgroundColor
        alertBackgroundView.layer.cornerRadius = config.alertViewCornerRadius
        
        buttonsBackgroundView.backgroundColor = config.buttonBackgroundView
        
        alertViewTopConstraint.constant = config.alertMarginSize.height
        alertViewBottomConstraint.constant = config.alertMarginSize.height
        alertViewLeadingConstraint.constant = config.alertMarginSize.width
        alertViewTrailingConstraint.constant = config.alertMarginSize.width
        
        alertViewWidthConstraint.constant = config.alertViewMaxSize.width
        alertViewHeightConstraint.constant = config.alertViewMaxSize.height
        
    }
    private func setupTitleLabelUI() {
        
        titleLabel.font = config.titleLabelFont
        titleLabel.textColor = config.titleLabelTextColor
        titleLabel.textAlignment = config.titleLabelTextAlignment
        
    }
    private func setupMessageLabelUI() {
        
        messageLabel.font = config.messageLabelFont
        messageLabel.textColor = config.messageLabelTextColor
        messageLabel.textAlignment = config.messageLabelTextAlignment
        
        messageVerticalSpaceFromTitleConstraint.constant = config.messageVerticalSpaceFromTitle
        
    }
    private func setupButtonsUI() {
        
        if buttonsList.count == 0 {
            
            buttonsBackgroundViewHeightConstraint.constant = config.messageVerticalSpaceFromTitle
            
        } else if buttonsList.count == 1 {
            
            let firstButton = buttonsList[0]
            
            buttonsBackgroundViewHeightConstraint.constant = firstButton.frame.height
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: firstButton, attribute: .Leading, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Top, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Bottom, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Width, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Width, multiplier: 1, constant: 0)
                
                ])
            
        } else if buttonsList.count == 2 {
            
            let firstButton = buttonsList[0]
            let secondButton = buttonsList[1]
            
            addSeparatorTo(firstButton, separators: (top: true, right: true))
            addSeparatorTo(secondButton, separators: (top: true, right: false))
            
            buttonsBackgroundViewHeightConstraint.constant = max(firstButton.frame.height, secondButton.frame.height)
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: firstButton, attribute: .Leading, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Top, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Bottom, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .Width, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Width, multiplier: config.firstButtonRatio, constant: 0)
                
                ])
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: secondButton, attribute: .Leading, relatedBy: .Equal, toItem: firstButton, attribute: .Trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .Top, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .Bottom, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .Trailing, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Trailing, multiplier: 1, constant: 0)
                
                ])
            
        } else {
            
            var menuTotalHeight: CGFloat = 0
            
            for button in buttonsList {
                menuTotalHeight += button.frame.height
            }
            
            buttonsBackgroundViewHeightConstraint.constant = menuTotalHeight
            
            for (index, button) in buttonsList.enumerate() {
                
                addSeparatorTo(button, separators: (top: true, right: false))
                
                let firstLayoutConstraint = index == 0 ?
                    NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Top, multiplier: 1, constant: 0) :
                    NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: buttonsList[index - 1], attribute: .Bottom, multiplier: 1, constant: 0)
                
                buttonsBackgroundView.addConstraints([
                    
                    firstLayoutConstraint,
                    NSLayoutConstraint(item: button, attribute: .Leading, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: button, attribute: .Trailing, relatedBy: .Equal, toItem: buttonsBackgroundView, attribute: .Trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: button.frame.height)
                    
                    ])
                
            }
            
        }
        
    }
    
    // MARK: - Behavior Setup
    private func setupBehavior() {
        
        dismissOnTapGestureRecognizer.enabled = config.dismissOnTouchOutsideEnabled
        
    }
    
    // MARK: - Buttons stuff
    private func createButtons(buttons: [Button]?) {
     
        guard let buttons = buttons else { return }
        
        buttonsList = [UIButton]()
        
        for (index, button) in buttons.enumerate() {
            
            let uiButton = button.createUIButton()
            
            uiButton.tag = index + 1
            uiButton.addTarget(self, action: #selector(MIAlertController.buttonTapped(_:)), forControlEvents: .TouchUpInside)
            
            buttonsBackgroundView.addSubview(uiButton)
            
            buttonsList.append(uiButton)
            
        }

        setupButtonsUI()
        
    }
    
    private func addSeparatorTo(button: UIButton, separators: (top: Bool, right: Bool)) {
        
        func addTopBorder() {
            
            let border = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            
            border.backgroundColor = config.separatorColor
            
            border.translatesAutoresizingMaskIntoConstraints = false
            
            button.addSubview(border)
            
            button.addConstraints([
                NSLayoutConstraint(item: border, attribute: .Top, relatedBy: .Equal, toItem: button, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Leading, relatedBy: .Equal, toItem: button, attribute: .Leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Trailing, relatedBy: .Equal, toItem: button, attribute: .Trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 1)
                ])
            
        }
        
        func addRightBorder() {
            
            let border = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            
            border.backgroundColor = config.separatorColor
            
            button.addSubview(border)
            
            border.translatesAutoresizingMaskIntoConstraints = false
            
            button.addConstraints([
                NSLayoutConstraint(item: border, attribute: .Top, relatedBy: .Equal, toItem: button, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Bottom, relatedBy: .Equal, toItem: button, attribute: .Bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Trailing, relatedBy: .Equal, toItem: button, attribute: .Trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 1)
                ])
            
        }
        
        if separators.top {
            addTopBorder()
        }
        if separators.right {
            addRightBorder()
        }
        
    }
    
    @objc private func buttonTapped(button: UIButton) {

        buttonTappedClosure?(buttonIndex: button.tag)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        
        createButtons(alertButtons)
        
        setupUI()
        setupBehavior()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func dismissAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - CustomTransition stuff
extension MIAlertController: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // UIViewControllerAnimatedTransitioning
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = true
        
        return self
        
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = false
        
        return self
        
    }
    
    // UIViewControllerTransitioningDelegate
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
        
    }
    
    // Shortcut
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? MIAlertController,
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView()
        
            else { return }
        
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        
        presentedController.view.alpha = 0
        presentedController.alertBackgroundView.alpha = 0
        
        presentedController.alertBackgroundView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animateWithDuration(
            
            transitionDuration(transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.0,
            options: .AllowUserInteraction,
            
            animations: {
                
                presentedController.alertBackgroundView.transform = CGAffineTransformMakeScale(1, 1)
                
                presentedController.view.alpha = 1
                presentedController.alertBackgroundView.alpha = 1
                
            }, completion: {(completed: Bool) -> Void in
                
                transitionContext.completeTransition(completed)
                
            }
            
        )
        
    }
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let
            
            presentedController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? MIAlertController,
            presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            else { return }

        UIView.animateWithDuration(
            
            transitionDuration(transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 2,
            initialSpringVelocity: 0.0,
            options: .AllowUserInteraction,
            animations: {
                
                presentedController.alertBackgroundView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                presentedControllerView.alpha = 0
                
            }, completion: {(completed: Bool) -> Void in
                
                transitionContext.completeTransition(completed)
                
            }
            
        )
        
    }
    
}
