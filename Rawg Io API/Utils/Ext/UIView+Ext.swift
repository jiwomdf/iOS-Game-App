//
//  UIView+Ext.swift
//  Rawg Io API
//
//  Created by MAC on 21/08/23.
//

import UIKit


extension UIView
{
  func roundCorners(corners:UIRectCorner, radius: CGFloat)
  {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath 
    self.layer.mask = mask
  }
}
