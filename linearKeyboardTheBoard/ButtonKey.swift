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
  var customAction: ((KeyboardViewController, ButtonKey, UITextDocumentProxy) -> ())?;
  var button: UIButton;

  func action(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
    if (self.customAction != nil) {
      self.customAction!(view, self, proxy);
    } else {
      proxy.insertText(self.label)
    }
  }

  init(label:String) {
    self.label = label;
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
  }

  init(label:String, action: @escaping (KeyboardViewController, ButtonKey, UITextDocumentProxy) -> ()) {
    self.label = label;
    self.button = UIButton(type: UIButtonType.system)
    self.button.setTitle(NSLocalizedString(label, comment: "Title for '\(label) button'"), for: [])
    self.customAction = action;
  }
}
