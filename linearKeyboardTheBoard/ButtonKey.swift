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
  var label: String = "";
  var shifted: String;
  var shift: Bool = false;
  var lastShift: Bool = false;
  var customAction: ((KeyboardViewController, ButtonKey, UITextDocumentProxy) -> ())?;
  var button: UIButton;

  func action(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
    if (self.customAction != nil) {
      self.customAction!(view, self, proxy);
    } else {
      if (self.shift) {
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

  init(label:String, action: @escaping (KeyboardViewController, ButtonKey, UITextDocumentProxy) -> ()) {
    self.label = label
    self.shifted = label.uppercased()
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
    self.customAction = action
  }
}
