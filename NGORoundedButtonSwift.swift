//
//  NGORoundedButtonSwift.swift
//  Pods
//
//  Created by Stanislav Zhukovskiy on 10.06.15.
//
//

import UIKit

enum NGORoundedButtonSwiftType {
    case NGORoundedButtonSwiftTypeCancel
    case NGORoundedButtonSwiftTypeBack
}

class NGORoundedButtonSwift : UIButton  {
    
    var type: NGORoundedButtonSwiftType {
        
        get{
            return self.type
        }
        set{
            self.type = newValue
            self.setup()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    convenience init(size: CGFloat) {
        let newFrame = CGRectMake(0, 0, size, size)
        self.init(frame: newFrame)
    }
    
    convenience init(buttonType: NGORoundedButtonSwiftType) {
        self.init(size: 44.0)
        self.type = buttonType
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    private func setup() {
        
        let sublayers: Array <AnyObject> = self.layer.sublayers
        for tempLayer in sublayers as! [CALayer] {
            layer.removeFromSuperlayer()
        }
        
        self.setupCornerRadius()
        self.setupShadow()
        
        switch self.type as NGORoundedButtonSwiftType {
            case .NGORoundedButtonSwiftTypeCancel: self.setupCancelButton()
            case .NGORoundedButtonSwiftTypeBack: self.setupBackButton()
        }
    }
    
//MARK: - Buttons
    
    private func setupCancelButton() {
        
        let backgroundColor: UIColor    = UIColor.whiteColor()
        let borderColor: UIColor        = UIColor(red:227/255.0, green:231/255.0, blue:236/255.0, alpha:0.9)
        let strokeColor: UIColor        = UIColor(red:73/255.0, green:78/255.0, blue:91/255.0, alpha:1.0)

        self.backgroundColor                = backgroundColor;
        self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
        self.layer.borderWidth              = 1 / UIScreen.mainScreen().scale;
        self.layer.borderColor              = borderColor.CGColor;
        self.layer.allowsEdgeAntialiasing   = true;
        
        var crossShape: CAShapeLayer    = CAShapeLayer()
        crossShape.lineWidth            = 3 / UIScreen.mainScreen().scale;
        crossShape.masksToBounds        = false;
        crossShape.lineCap              = kCALineCapRound;
        crossShape.strokeColor          = strokeColor.CGColor;
        
        var fr: CGRect      = self.bounds;
        var ofSize: CGFloat = CGRectGetWidth(fr) / 2.8;
        
        var path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, ofSize, ofSize)
        CGPathAddLineToPoint(path, nil, CGRectGetMaxX(fr) - ofSize, CGRectGetMaxY(fr) - ofSize);
        CGPathMoveToPoint(path, nil, CGRectGetMaxX(fr) - ofSize, CGRectGetMinY(fr) + ofSize);
        CGPathAddLineToPoint(path, nil, CGRectGetMinX(fr) + ofSize, CGRectGetMaxY(fr) - ofSize);
        crossShape.path = path;
        self.layer.addSublayer(crossShape);
    }
    
    private func setupBackButton() {
    
        let backgroundColor: UIColor    = UIColor.whiteColor();
        let borderColor: UIColor        = UIColor(red:227/255.0, green:231/255.0, blue:236/255.0, alpha:0.9)
        let strokeColor: UIColor        = UIColor(red:73/255.0, green:78/255.0, blue:91/255.0, alpha:1.0)
    
        self.backgroundColor                = backgroundColor;
        self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
        self.layer.borderWidth              = 1 / UIScreen.mainScreen().scale;
        self.layer.borderColor              = borderColor.CGColor;
        self.layer.allowsEdgeAntialiasing   = true;
        
        var leftArrowShape: CAShapeLayer    = CAShapeLayer()
        leftArrowShape.lineWidth            = 3 / UIScreen.mainScreen().scale;
        leftArrowShape.masksToBounds        = false;
        leftArrowShape.lineCap              = kCALineCapRound;
        leftArrowShape.strokeColor          = strokeColor.CGColor;
        leftArrowShape.fillColor            = backgroundColor.CGColor;
        
        var fr: CGRect      = self.bounds;
        var ofSize: CGFloat = CGRectGetWidth(fr) / 2.8;
        var width: CGFloat  = CGRectGetWidth(fr);
        var height: CGFloat = CGRectGetHeight(fr);
        
        var path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGRectGetMidX(fr) + (width / 20), CGRectGetMidY(fr) - (height / 6));
        CGPathAddLineToPoint(path, nil, CGRectGetMidX(fr) - (width / 8), CGRectGetMidY(fr));
        CGPathAddLineToPoint(path, nil, CGRectGetMidX(fr) + (width / 20), CGRectGetMidY(fr) + (height / 6));
        leftArrowShape.path = path;
        self.layer.addSublayer(leftArrowShape)
    }
    
//MARK: - Common UI setup
    
    private func setupCornerRadius() {
        
        self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
        self.layer.masksToBounds            = false;
        self.layer.allowsEdgeAntialiasing   = true;
    }
    
    private func setupShadow() {
        
        self.layer.shadowColor      = UIColor.blackColor().CGColor;
        self.layer.shadowOpacity    = 0.15;
        self.layer.shadowRadius     = 3;
        self.layer.shadowOffset     = CGSizeMake(0.0, 3.0);
    }
    
    private func setupTargets() {
        
        self.addTarget(self, action:"normalState:", forControlEvents:UIControlEvents.TouchUpInside)
        self.addTarget(self, action:"normalState:", forControlEvents:UIControlEvents.TouchDragOutside)
        self.addTarget(self, action:"highlitedState:", forControlEvents:UIControlEvents.TouchDown)
    }
    
//MARK: - Button State Animation
    
    private func normalState(sender: UIButton!) {
    
        self.transform  = CGAffineTransformMakeScale(1, 1);
        self.alpha      = 1;
    }
    
    private func highlitedState(sender: UIButton!) {
    
        self.transform  = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha      = 0.75;
    }
}