//
//  MIAlertController.swift
//  MIAlertController
//
//  Created by Mario on 10/07/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import UIKit

open class MIAlertController: UIViewController {
    
    public typealias ButtonTappedClosure = () -> ()
    
    public struct Config {
        
        // Behavior
        public var dismissOnTouchOutsideEnabled = true
        
        // BackgroundView
        public var backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        // Alert View
        public var alertViewBackgroundColor = UIColor.white
        public var alertViewCornerRadius: CGFloat = 10
        public var alertMarginSize = CGSize(width: 40, height: 30)
        public var separatorColor = UIColor.clear
        public var alertViewMaxSize = CGSize(width: 300, height: 300)
        
        // Title
        public var titleLabelFont = UIFont.boldSystemFont(ofSize: 19)
        public var titleLabelTextColor = UIColor.black
        public var titleLabelTextAlignment = NSTextAlignment.center
        
        // Message
        public var messageLabelFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        public var messageLabelTextColor = UIColor.black
        public var messageLabelTextAlignment = NSTextAlignment.center
        public var messageVerticalSpaceFromTitle: CGFloat = 10
        
        // Buttons
        public var buttonBackgroundView = UIColor.white
        public var firstButtonRatio: CGFloat = 0.5 // Only available with two buttons; ratio between the width of the buttons container and the width of the first button
        
        public init() {
            
        }
        
    }
    
    public struct Button {
        
        public struct Config {
            
            public var font = UIFont.boldSystemFont(ofSize: 15)
            public var textColor = UIColor.black
            public var textAlignment = UIControl.ContentHorizontalAlignment.center
            public var backgroundColor = UIColor.clear
            public var buttonHeight: CGFloat = 60
            public var contentEdgeOffset = UIEdgeInsets.zero
            
            public init() {
                
            }
            
            public init(font: UIFont, textColor: UIColor, textAlignment: UIControl.ContentHorizontalAlignment, backgroundColor: UIColor, buttonHeight: CGFloat, contentEdgeOffset: UIEdgeInsets) {
                
                self.font = font
                self.textColor = textColor
                self.textAlignment = textAlignment
                self.backgroundColor = backgroundColor
                self.buttonHeight = buttonHeight
                self.contentEdgeOffset = contentEdgeOffset
                
            }
            
        }
        
        public enum `Type` {
            
            case `default`
            case destructive
            case cancel
            
            fileprivate var config: Config {
                
                switch self {
                    
                case .default:
                    
                    return Config(
                        font: UIFont.systemFont(ofSize: 16),
                        textColor: UIColor(red: 33/255.0, green: 129/255.0, blue: 247/255.0, alpha: 1),
                        textAlignment: UIControl.ContentHorizontalAlignment.center,
                        backgroundColor: UIColor.clear,
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsets.zero
                    )
                    
                case .destructive:
                    
                    return Config(
                        font: UIFont.boldSystemFont(ofSize: 16),
                        textColor: UIColor(red: 218/255.0, green: 75/255.0, blue: 56/255.0, alpha: 1),
                        textAlignment: UIControl.ContentHorizontalAlignment.center,
                        backgroundColor: UIColor.clear,
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsets.zero
                    )
                    
                case .cancel:
                    
                    return Config(
                        font: UIFont.boldSystemFont(ofSize: 16),
                        textColor: UIColor(red: 33/255.0, green: 129/255.0, blue: 247/255.0, alpha: 1),
                        textAlignment: UIControl.ContentHorizontalAlignment.center,
                        backgroundColor: UIColor.clear,
                        buttonHeight: 60,
                        contentEdgeOffset: UIEdgeInsets.zero
                    )
                    
                }
                
            }
            
        }
        
        fileprivate var type = Type.default
        fileprivate var config: Config!
        fileprivate var title: String?
        fileprivate var action: ButtonTappedClosure?
        
        public init(title: String, type: Type = .default, config: Config? = nil, action: ButtonTappedClosure? = nil) {
            
            self.title = title
            self.config = config ?? type.config
            self.action = action
            
        }
        
        fileprivate func createUIButton() -> UIButton {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: config.buttonHeight))
            
            button.setTitle(title, for: UIControl.State())
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.7
            button.setTitleColor(config.textColor, for: UIControl.State())
            button.titleLabel?.font = config.font
            button.backgroundColor = config.backgroundColor
            button.contentHorizontalAlignment = config.textAlignment
            
            button.contentEdgeInsets = config.contentEdgeOffset
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
            
        }
        
    }
    
    fileprivate var config: Config!
    
    fileprivate var alertTitle: String?
    fileprivate var alertMessage: String?
    fileprivate var alertButtons: [Button]?
    
    fileprivate var buttonTappedClosures: [ButtonTappedClosure?]?
    
    fileprivate var isPresenting: Bool = false
    
    fileprivate var buttonsList: [UIButton]!
    
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
    
    // MARK: - Initializers
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String? = nil, message: String? = nil, buttons: [Button]? = nil, config: Config? = nil) {
        
        super.init(nibName: "MIAlertController", bundle: Bundle(for: MIAlertController.self))
        
        self.config = config ?? Config()
        
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTappedClosures = [ButtonTappedClosure?]()
        self.alertButtons = [Button]()
        
        if let buttons = buttons {
            
            for button in buttons {
                addButton(button)
            }
            
        }
        
    }
    
    // MARK: - Public methods
    open func addButton(_ button: Button) {
        
        alertButtons?.append(button)
        buttonTappedClosures?.append(button.action)
        
    }
    
    open func presentOn(_ parentVC: UIViewController) {
        
        self.modalPresentationStyle = .overCurrentContext
        self.transitioningDelegate = self
        
        parentVC.present(self, animated: true) {}
        
    }
    
    // MARK: - UI Setup
    fileprivate func setupUI() {
        
        setupAlertView()
        setupTitleLabelUI()
        setupMessageLabelUI()
        
        view.layoutIfNeeded()
        
    }
    
    fileprivate func setupAlertView() {
        
        view.backgroundColor = UIColor.clear
        
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
    fileprivate func setupTitleLabelUI() {
        
        titleLabel.font = config.titleLabelFont
        titleLabel.textColor = config.titleLabelTextColor
        titleLabel.textAlignment = config.titleLabelTextAlignment
        
    }
    fileprivate func setupMessageLabelUI() {
        
        messageLabel.font = config.messageLabelFont
        messageLabel.textColor = config.messageLabelTextColor
        messageLabel.textAlignment = config.messageLabelTextAlignment
        
        messageVerticalSpaceFromTitleConstraint.constant = config.messageVerticalSpaceFromTitle
        
    }
    fileprivate func setupButtonsUI() {
        
        if buttonsList.count == 0 {
            
            buttonsBackgroundViewHeightConstraint.constant = config.messageVerticalSpaceFromTitle
            
        } else if buttonsList.count == 1 {
            
            let firstButton = buttonsList[0]
            
            buttonsBackgroundViewHeightConstraint.constant = firstButton.frame.height
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: firstButton, attribute: .leading, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .top, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .bottom, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .width, multiplier: 1, constant: 0)
                
                ])
            
        } else if buttonsList.count == 2 {
            
            let firstButton = buttonsList[0]
            let secondButton = buttonsList[1]
            
            addSeparatorTo(firstButton, separators: (top: true, right: true))
            addSeparatorTo(secondButton, separators: (top: true, right: false))
            
            buttonsBackgroundViewHeightConstraint.constant = max(firstButton.frame.height, secondButton.frame.height)
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: firstButton, attribute: .leading, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .top, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .bottom, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .width, multiplier: config.firstButtonRatio, constant: 0)
                
                ])
            
            buttonsBackgroundView.addConstraints([
                
                NSLayoutConstraint(item: secondButton, attribute: .leading, relatedBy: .equal, toItem: firstButton, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .top, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .bottom, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: secondButton, attribute: .trailing, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .trailing, multiplier: 1, constant: 0)
                
                ])
            
        } else {
            
            var menuTotalHeight: CGFloat = 0
            
            for button in buttonsList {
                menuTotalHeight += button.frame.height
            }
            
            buttonsBackgroundViewHeightConstraint.constant = menuTotalHeight
            
            for (index, button) in buttonsList.enumerated() {
                
                addSeparatorTo(button, separators: (top: true, right: false))
                
                let firstLayoutConstraint = index == 0 ?
                    NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .top, multiplier: 1, constant: 0) :
                    NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: buttonsList[index - 1], attribute: .bottom, multiplier: 1, constant: 0)
                
                buttonsBackgroundView.addConstraints([
                    
                    firstLayoutConstraint,
                    NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: buttonsBackgroundView, attribute: .trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.frame.height)
                    
                    ])
                
            }
            
        }
        
    }
    
    // MARK: - Buttons stuff
    fileprivate func createButtons(_ buttons: [Button]?) {
        
        guard let buttons = buttons else { return }
        
        buttonsList = [UIButton]()
        
        for button in buttons {
            
            let uiButton = button.createUIButton()
            
            uiButton.addTarget(self, action: #selector(MIAlertController.buttonTapped(_:)), for: .touchUpInside)
            
            buttonsBackgroundView.addSubview(uiButton)
            
            buttonsList.append(uiButton)
            
        }
        
        setupButtonsUI()
        
    }
    
    fileprivate func addSeparatorTo(_ button: UIButton, separators: (top: Bool, right: Bool)) {
        
        func addTopBorder() {
            
            let border = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            
            border.backgroundColor = config.separatorColor
            
            border.translatesAutoresizingMaskIntoConstraints = false
            
            button.addSubview(border)
            
            button.addConstraints([
                NSLayoutConstraint(item: border, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .leading, relatedBy: .equal, toItem: button, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
                ])
            
        }
        
        func addRightBorder() {
            
            let border = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            
            border.backgroundColor = config.separatorColor
            
            button.addSubview(border)
            
            border.translatesAutoresizingMaskIntoConstraints = false
            
            button.addConstraints([
                NSLayoutConstraint(item: border, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: border, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
                ])
            
        }
        
        if separators.top {
            addTopBorder()
        }
        if separators.right {
            addRightBorder()
        }
        
    }
    
    @objc fileprivate func buttonTapped(_ button: UIButton) {
        
        if let buttonIndex = buttonsList.firstIndex(where: { $0 == button }) {
            self.buttonTappedClosures?[buttonIndex]?()
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        
        createButtons(alertButtons)
        
        setupUI()
        
    }
    
    // MARK: - IBActions
    @IBAction func dismissAction(_ sender: AnyObject) {
        if config.dismissOnTouchOutsideEnabled {
            dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - CustomTransition stuff
extension MIAlertController: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // UIViewControllerAnimatedTransitioning
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = true
        
        return self
        
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = false
        
        return self
        
    }
    
    // UIViewControllerTransitioningDelegate
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
        
    }
    
    // Shortcut
    func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            
            let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? MIAlertController,
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            
            else { return }
        
        let containerView = transitionContext.containerView
        
        presentedControllerView.frame = transitionContext.finalFrame(for: presentedController)
        
        presentedController.view.alpha = 0
        presentedController.alertBackgroundView.alpha = 0
        
        presentedController.alertBackgroundView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animate(
            
            withDuration: transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.0,
            options: .allowUserInteraction,
            
            animations: {
                
                presentedController.alertBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                presentedController.view.alpha = 1
                presentedController.alertBackgroundView.alpha = 1
                
        }, completion: {(completed: Bool) -> Void in
            
            transitionContext.completeTransition(completed)
            
        }
            
        )
        
    }
    func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? MIAlertController,
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            
            else { return }
        
        UIView.animate(
            
            withDuration: transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 2,
            initialSpringVelocity: 0.0,
            options: .allowUserInteraction,
            animations: {
                
                presentedController.alertBackgroundView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                presentedControllerView.alpha = 0
                
        }, completion: {(completed: Bool) -> Void in
            
            transitionContext.completeTransition(completed)
            
        }
            
        )
        
    }
    
}
