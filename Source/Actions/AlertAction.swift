import UIKit

/**
The action's style

- normal:      The action will have default font and text color
- preferred:   The action will take a style that indicates it's the preferred option
- destructive: The action will convey that this action will do something destructive
*/
@objc(SDCAlertActionStyle)
public enum AlertActionStyle: Int {
    case normal
    case preferred
    case destructive
}

@objc(SDCAlertAction)
public class AlertAction: NSObject {

    /**
    Creates an action with a plain title.

    - parameter title:   An optional title for the action
    - parameter style:   The action's style
    - parameter handler: An optional closure that's called when the user taps on this action
    */
    public convenience init(title: String?, style: AlertActionStyle, handler: ((AlertAction) -> Void)? = nil)
    {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    public convenience init(title: String?, image : UIImage?, highlightedImage : UIImage?,  style: AlertActionStyle, handler: ((AlertAction) -> Void)? = nil)
    {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
        self.image = image
        self.highlightedImage = highlightedImage
    }


    /**
    Creates an action with a stylized title.

    - parameter attributedTitle: An optional stylized title
    - parameter style:           The action's style
    - parameter handler:         An optional closure that is called when the user taps on this action
    */
    public convenience init(attributedTitle: NSAttributedString?, style: AlertActionStyle,
        handler: ((AlertAction) -> Void)? = nil)
    {
        self.init()
        self.attributedTitle = attributedTitle
        self.style = style
        self.handler = handler
    }

    /// A closure that gets executed when the user taps on this actions in the UI
    public var handler: ((AlertAction) -> Void)?

    /// The plain title for the action. Uses `attributedTitle` directly.
    private(set) public var title: String? {
        get { return self.attributedTitle?.string }
        set { self.attributedTitle = newValue.map(NSAttributedString.init) }
    }

    /// The stylized title for the action.
    private(set) public var attributedTitle: NSAttributedString?
    
    private(set) public var image: UIImage?// {
    //        get { return self.image }
    //        set {
    //            self.image = newValue.map(UIImage.init)
    //        }
    //    }
    
    private(set) public var highlightedImage: UIImage?// {
    //        get { return self.highlightedImage }
    //        set {
    //            self.highlightedImage = newValue.map(UIImage.init)
    //        }
    //    }


    /// The action's style.
    internal(set) public var style: AlertActionStyle = .normal

    /// Whether this action can be interacted with by the user.
    public var isEnabled = true {
        didSet { self.actionView?.isEnabled = self.isEnabled }
    }

    var actionView: ActionCell? {
        didSet { self.actionView?.isEnabled = self.isEnabled }
    }
}
