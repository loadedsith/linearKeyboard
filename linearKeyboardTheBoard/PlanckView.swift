//
//  PlanckView.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 10/26/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class PlanckView: UIView {

  enum KeyLayer {
    case NORMAL
    case LOWER
    case RAISE
    case ADJUST
    case EMOJI
    case CAPS
    case SHIFT
  }
  var keys: Array<Array<ButtonKey>> = [];

  var _keysFlat: Array<ButtonKey> = [];

  var buttons: Array<Array<(ButtonKey)>> = [
      [KC_TAB,   KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,     KC_Y,    KC_U,    KC_I,       KC_O,      KC_P,         KC_BS],
      [KC_CAPS,  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,    KC_J,    KC_K,       KC_L,      KC_SEMICOLON, KC_SLASH],
      [KC_SHIFT, KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,    KC_M,    KC_COMMA,   KC_PERIOD, KC_SEMICOLON, KC_FSLASH],
      [KC_KEEBS, KC_EMOJI, KC_LOWER, KC_UNDER, KC_UNDER, KC_RAISE, KC_LEFT, KC_DOWN, KC_UP,      KC_RIGHT],
    ];

  override init(frame: CGRect) {
    super.init(frame: frame);
    commonInit();
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
    commonInit();
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    commonInit()
  }

  override func layoutSubviews() {
    self.frame.size.width = UIScreen.main.bounds.width
    self.frame.size.height = (superview?.bounds.height)!

    arrangeKeys()
    super.layoutSubviews();
  }

  private func arrangeKeys() {
    for (rowIndex, row) in keys.enumerated() {
      for (keyIndex, key) in row.enumerated() {
        let button = key.button;
        let buttonWidth = Float(frame.width) / Float(row.count);
        let buttonHeight = Float(frame.height) / Float(buttons.count);
        let buttonOffsetX = buttonWidth * Float(keyIndex);
        let buttonOffsetY = buttonHeight * Float(rowIndex);

        button.frame = CGRect(x: Int(buttonOffsetX), y: Int(buttonOffsetY), width: Int(buttonWidth), height: Int(buttonHeight))
      }
    }
  }

  func findKeyByButtonTag(id:Int) -> ButtonKey {
    for (_, key) in _keysFlat.enumerated() {
      if key.button.tag == id {
        return key
      }
    }

    return ButtonKey.init(label: "error");
  }

  private func commonInit() {
    frame=bounds
    backgroundColor = UIColor.lightGray
    var count: Int = 0
    for (rowIndex, row) in buttons.enumerated() {
      if (!keys.indices.contains(rowIndex)) {
        keys.insert([], at: rowIndex)
      }

      for (keyIndex, key) in row.enumerated() {
        if (!keys[rowIndex].indices.contains(keyIndex)) {
          key.button.tag = count
          count += 1
          keys[rowIndex].append(key);
          _keysFlat.insert(key, at: key.button.tag);
          addSubview(key.button);
        }
      }
    }

    arrangeKeys();
  }
}