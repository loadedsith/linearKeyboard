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
  }
  
  var shift: Bool = false;
  var lastShift: Bool = false;
  var keys: [KeyLayer: Array<Array<ButtonKey>>] = [:];
  var keyLayer: PlanckView.KeyLayer = PlanckView.KeyLayer.NORMAL;
  var lastKeyLayer: PlanckView.KeyLayer = PlanckView.KeyLayer.NORMAL;
  
  var _keysFlat: Array<ButtonKey> = [];

  var keyLayers: [KeyLayer: Array<Array<ButtonKey>>] = [
    KeyLayer.NORMAL: [
      [KC_TAB,   KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,     KC_Y,    KC_U,    KC_I,       KC_O,      KC_P,         KC_BS],
      [KC_CAPS,  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,    KC_J,    KC_K,       KC_L,      KC_SEMICOLON, KC_SLASH],
      [KC_SHIFT, KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,    KC_M,    KC_COMMA,   KC_PERIOD, KC_SEMICOLON, KC_FSLASH],
      [KC_KEEBS, KC_EMOJI, KC_LOWER, KC_UNDER, KC_UNDER, KC_RAISE, KC_LEFT, KC_DOWN, KC_UP,      KC_RIGHT],
    ],
    KeyLayer.LOWER: [
      [KC_TAB,   KC_L,     KC_O,     KC_W,     KC_E,     KC_R,     KC_Y,    KC_U,    KC_I,       KC_O,      KC_P,         KC_BS],
      [KC_CAPS,  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,    KC_J,    KC_K,       KC_L,      KC_SEMICOLON, KC_SLASH],
      [KC_SHIFT, KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,    KC_M,    KC_COMMA,   KC_PERIOD, KC_SEMICOLON, KC_FSLASH],
      [KC_KEEBS, KC_EMOJI, KC_LOWER, KC_UNDER, KC_UNDER, KC_RAISE, KC_LEFT, KC_DOWN, KC_UP,      KC_RIGHT],
    ],
    KeyLayer.RAISE: [
      [KC_TAB,   KC_R,     KC_A,     KC_I,     KC_S,     KC_E,     KC_Y,    KC_U,    KC_I,       KC_O,      KC_P,         KC_BS],
      [KC_CAPS,  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,    KC_J,    KC_K,       KC_L,      KC_SEMICOLON, KC_SLASH],
      [KC_SHIFT, KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,    KC_M,    KC_COMMA,   KC_PERIOD, KC_SEMICOLON, KC_FSLASH],
      [KC_KEEBS, KC_EMOJI, KC_LOWER, KC_UNDER, KC_UNDER, KC_RAISE, KC_LEFT, KC_DOWN, KC_UP,      KC_RIGHT],
    ]
  ];

  override init(frame: CGRect) {
    super.init(frame: frame);
    render()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
    render()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    render()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    render();
  }

  override func layoutSubviews() {
    self.frame.size.width = UIScreen.main.bounds.width
    self.frame.size.height = (superview?.bounds.height)!

    render()
    super.layoutSubviews();
  }
  
  func setKeyLayer(keyLayer: PlanckView.KeyLayer) -> () {
    self.keyLayer = keyLayer
    render()
  }
  
  func setShift() -> () {
    self.shift = !self.shift
    render()
  }
  
  private func render() {
    createKeys();
    for (layerIndex, layer) in keys {
      for (rowIndex, row) in layer.enumerated() {
        for (keyIndex, key) in row.enumerated() {
          let button = key.button;
          print(frame.width)
          print(frame.height)
          let buttonWidth = Float(frame.width) / Float(row.count);
          let buttonHeight = Float(frame.height) / Float(layer.count);
          
          print(buttonWidth)
          print(buttonHeight)
          let buttonOffsetX = buttonWidth * Float(keyIndex);
          let buttonOffsetY = buttonHeight * Float(rowIndex);
          
          key.setShift(shift: self.shift)
          
          if (keyLayer == layerIndex) {
            button.alpha = 1
          } else {
            button.alpha = 0
          }
          
          button.frame = CGRect(x: Int(buttonOffsetX), y: Int(buttonOffsetY), width: Int(buttonWidth), height: Int(buttonHeight))
        }
      }
    }
    self.lastKeyLayer = self.keyLayer
  }

  func findKeyByButtonTag(id:Int) -> ButtonKey {
    for (_, key) in _keysFlat.enumerated() {
      if key.button.tag == id {
        return key
      }
    }

    return ButtonKey.init(label: "error");
  }

  private func createKeys() {
    frame=bounds
    backgroundColor = UIColor.lightGray
    var count: Int = 0

    for (keyLayerIndex, layer) in keyLayers {
      if (keys[keyLayerIndex] == nil) {
        keys[keyLayerIndex] = []
      }
      
      for (rowIndex, row) in layer.enumerated() {
        if (!keys[keyLayerIndex]!.indices.contains(rowIndex)) {
          keys[keyLayerIndex]!.insert([], at: rowIndex)
        }
        
        for (keyIndex, key) in row.enumerated() {
          if (!keys[keyLayerIndex]![rowIndex].indices.contains(keyIndex)) {
            let keyCopy = key.copy();
            keyCopy.button.tag = count
            count += 1
            keys[keyLayerIndex]![rowIndex].insert(keyCopy, at: keyIndex);
            _keysFlat.insert(keyCopy, at: keyCopy.button.tag);
            addSubview(keyCopy.button);
          }
        }
      }
    }
  }
}
