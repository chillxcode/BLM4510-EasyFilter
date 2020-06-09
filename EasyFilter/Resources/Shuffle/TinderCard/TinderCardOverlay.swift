///
/// MIT License
///
/// Copyright (c) 2020 Mac Gallagher
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///

import UIKit

class TinderCardOverlay: UIView {

  init(direction: SwipeDirection) {
    super.init(frame: .zero)
    switch direction {
    case .left:
      createLeftOverlay()
    case .up:
      createUpOverlay()
    case .right:
      createRightOverlay()
    default:
      break
    }
  }

  required init?(coder: NSCoder) {
    return nil
  }

  private func createLeftOverlay() {
    let leftTextView = TinderCardOverlayLabelView(withTitle: "NOPE",    //Nope👎🏼
                                                  color: .sampleRed,
                                                  rotation: CGFloat.pi / 10)
    leftTextView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(leftTextView)
    
    leftTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    leftTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14).isActive = true
    
//    leftTextView.anchor(top: topAnchor,
//                        right: rightAnchor,
//                        paddingTop: 30,
//                        paddingRight: 14)
  }

  private func createUpOverlay() {
    let upTextView = TinderCardOverlayLabelView(withTitle: "LOVE",    //Love😛
                                                color: .sampleBlue,
                                                rotation: -CGFloat.pi / 20)
    upTextView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(upTextView)
    
    upTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    upTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    
    //    upTextView.anchor(bottom: bottomAnchor, paddingBottom: 20)
  }

  private func createRightOverlay() {
    let rightTextView = TinderCardOverlayLabelView(withTitle: "LIKE",   //Like👍🏼
                                                   color: .sampleGreen,
                                                   rotation: -CGFloat.pi / 10)
    rightTextView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(rightTextView)
    
    rightTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 26).isActive = true
    rightTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true

//    rightTextView.anchor(top: topAnchor,
//                         left: leftAnchor,
//                         paddingTop: 26,
//                         paddingLeft: 14)
  }
}

private class TinderCardOverlayLabelView: UIView {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  init(withTitle title: String, color: UIColor, rotation: CGFloat) {
    super.init(frame: CGRect.zero)
    layer.borderColor = color.cgColor
    layer.borderWidth = 4
    layer.cornerRadius = 4
    transform = CGAffineTransform(rotationAngle: rotation)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    titleLabel.textColor = color
    titleLabel.attributedText = NSAttributedString(string: title,
                                                   attributes: NSAttributedString.Key.overlayAttributes)
    
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 3).isActive = true
    
//    titleLabel.anchor(top: topAnchor,
//                      left: leftAnchor,
//                      bottom: bottomAnchor,
//                      right: rightAnchor,
//                      paddingLeft: 8,
//                      paddingRight: 3)
  }

  required init?(coder aDecoder: NSCoder) {
    return nil
  }
}

extension NSAttributedString.Key {

  static var overlayAttributes: [NSAttributedString.Key: Any] = [
    // swiftlint:disable:next force_unwrapping
    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 35)!,
    NSAttributedString.Key.kern: 5.0
  ]
}

extension UIColor {
  static var sampleRed = UIColor(red: 252 / 255, green: 70 / 255, blue: 93 / 255, alpha: 1)
  static var sampleGreen = UIColor(red: 49 / 255, green: 193 / 255, blue: 109 / 255, alpha: 1)
  static var sampleBlue = UIColor(red: 52 / 255, green: 154 / 255, blue: 254 / 255, alpha: 1)
}
