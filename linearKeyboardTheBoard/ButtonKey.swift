//
//  ButtonKey.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 10/28/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import Foundation
import UIKit

class ButtonKey {

  var empty: Bool = false;
  var width: Float = 1;
  var label: String = "";
  var shifted: String;
  var shift: Bool = false;
  var lastShift: Bool = false;
  var customAction: ((KeyboardViewController, ButtonKey, UITextDocumentProxy, Bool) -> ())?;
  var button: UIButton;
  
  func copy() -> ButtonKey {
    return ButtonKey(label: label, width: width, shifted: shifted, action: action)
  }
  
  func action(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
    if (self.customAction != nil) {
      self.customAction!(view, self, proxy, shifted_);
    } else {
      if (shifted_ == true) {
        proxy.insertText(self.shifted)
      } else {
        proxy.insertText(self.label)
      }
    }
  }
  
  func setShift(shift:Bool) {
    self.shift = shift;
    if (self.shift != self.lastShift) {
      if (self.shift) {
        button.setTitle(shifted, for: [])
      } else {
        button.setTitle(label, for: [])
      }
      self.lastShift = self.shift
    }
  }

  init(empty:Bool) {
    self.label = "";
    self.shifted = "";
    self.width = 0;
    self.button = UIButton(type: UIButtonType.system)
  }
  
  init(label:String) {
    self.label = label;
    self.shifted = label.uppercased();
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
  }
  
  init(label:String, shifted:String) {
    self.label = label
    self.shifted = shifted
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
  }
  
  init(label:String, shifted:String, action: @escaping (KeyboardViewController, ButtonKey, UITextDocumentProxy, Bool) -> ()) {
    self.label = label
    self.shifted = shifted
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
    self.customAction = action
  }

  init(label:String, width: Float, shifted: String, action: @escaping (KeyboardViewController, ButtonKey, UITextDocumentProxy, Bool) -> ()) {
    self.label = label
    self.shifted = shifted
    self.width = width
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
    self.customAction = action
    self.button.backgroundColor = UIColor.black
  }
  
  init(label:String, action: @escaping (KeyboardViewController, ButtonKey, UITextDocumentProxy, Bool) -> ()) {
    self.label = label
    self.shifted = label.uppercased()
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
    self.customAction = action
  }
}
