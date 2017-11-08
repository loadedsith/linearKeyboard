//
//  PlanckView.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 10/26/17.
//  Copyleft © 2017 Graham Heath. No rights reserved.
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
  
  @IBInspectable var textLightColor: UIColor? = UIColor.blue;
  @IBInspectable var textDarkColor: UIColor? = UIColor.white;
  @IBInspectable var textColor: UIColor? = UIColor.white;
  @IBInspectable var borderColor: UIColor? = UIColor.blue;
  @IBInspectable var backgroundColor_: UIColor? = UIColor.blue;

  var shift: Bool = false;
  var lastShift: Bool = false;
  var keys: [KeyLayer: Array<Array<ButtonKey>>] = [:];
  var keyLayer: PlanckView.KeyLayer = PlanckView.KeyLayer.NORMAL;
  var lastKeyLayer: PlanckView.KeyLayer = PlanckView.KeyLayer.NORMAL;

  var _keysFlat: Array< ButtonKey> = [];

  var keyLayers: [KeyLayer: Array<Array<ButtonKey>>] = [
    /* Qwerty
     * ,---------------------------------------------------------------------.
     * |   Q  |   W  |   E  |   R  |   T  |   Y  |   U  |   I  |   O  |   P  |
     * |------+------+------+------+------+-------------+------+------+------|
     * |   A  |   S  |   D  |   F  |   G  |   H  |   J  |   K  |   L  |   '  |
     * |------+------+------+------+------+------|------+------+------+------|
     * | Shift|   Z  |   X  |   C  |   V  |   B  |   N  |   M  |     Bksp    |
     * |------+------+------+------+------+------+------+------+------+------|
     * | Keebs  | Emoji | Lower  |      Space         |   Raise  |  Enter    |
     * `---------------------------------------------------------------------'
     */
    KeyLayer.NORMAL: [
      [KC_Q,     KC_W,     KC_E,     KC_R,        KC_T,     KC_Y,     KC_U,    KC_I, KC_O,     KC_P],
      [KC_A,     KC_S,     KC_D,     KC_F,        KC_G,     KC_H,     KC_J,    KC_K, KC_L,     KC_QUO],
      [KC_SHIFT, KC_Z,     KC_X,     KC_C,        KC_V,     KC_B,     KC_N,    KC_M, KC_BS_2X, KC_EMPTY],
      [KC_KEEBS, KC_EMOJI, KC_LOWER, KC_SPACE_2X, KC_EMPTY, KC_RAISE, KC_ENTER]
    ],
    /* Lower
     * ,---------------------------------------------------------------------.
     * |   !  |   @  |   #  |   $  |   %  |   ^  |   &  |   *  |   (  |   )  |
     * |------+------+------+------+------+-------------+------+------+------|
     * |   ~  |  :-) |  :-) |  :-) |  :-) |   ;  |   _  |   +  |   {  |   }  |
     * |------+------+------+------+------+------+------+------+------+------|
     * | Shift|  :-) |  :-) |  :-) |   /  |   ,  |   .  |   |  |     Bksp    |
     * |------+------+------+------+------+------+------+------+------+------|
     * | Keebs  | Emoji | Lower  |      Space         |   Raise  |  Enter    |
     * `---------------------------------------------------------------------'
     */
    KeyLayer.LOWER: [
      [KC_EXCL,  KC_AT,    KC_HASH,   KC_DOLL,     KC_PERC,   KC_CAR,       KC_AMP,    KC_EXP,   KC_LPAR,   KC_RPAR],
      [KC_TILD,  KC_EMOJI, KC_EMOJI,  KC_EMOJI,    KC_EMOJI,  KC_SEMICOLON, KC_UNDR,   KC_ADD,   KC_LCBR,   KC_RCBR],
      [KC_SHIFT, KC_EMOJI, KC_EMOJI,  KC_EMOJI,    KC_FSLASH, KC_COMMA,     KC_PERIOD, KC_PIPE,  KC_BS_2X,  KC_EMPTY],
      [KC_KEEBS, KC_EMOJI, KC_NORMAL, KC_SPACE_2X, KC_EMPTY,  KC_RAISE,     KC_ENTER]
    ],
    /* Raise
     * ,---------------------------------------------------------------------.
     * |   1  |   2  |   3  |   4  |   5  |   6  |   7  |   8  |   9  |   0  |
     * |------+------+------+------+------+-------------+------+------+------|
     * |   `  |  :-) |  :-) |  :-) |  :-) |   :  |   -  |   =  |   [  |   ]  |
     * |------+------+------+------+------+------+------+------+------+------|
     * | Shift|  :-) |  :-) |   ,  |   ?  |   <  |   >  |   \  |     Bksp    |
     * |------+------+------+------+------+------+------+------+------+------|
     * | Keebs  | Emoji | Lower  |      Space         |   Raise  |  Enter    |
     * `---------------------------------------------------------------------'
     */
    KeyLayer.RAISE: [
      [KC_1,     KC_2,     KC_3,      KC_4,        KC_5,        KC_6,      KC_7,    KC_8,     KC_9,     KC_0],
      [KC_GRAV,  KC_EMOJI, KC_EMOJI,  KC_EMOJI,    KC_EMOJI,    KC_COLON,  KC_DASH, KC_EQUA,  KC_LBRA,  KC_RBRA],
      [KC_SHIFT, KC_EMOJI, KC_EMOJI,  KC_COMMA,    KC_QUESTION, KC_LT,     KC_GT,   KC_BSLA,  KC_BS_2X, KC_EMPTY],
      [KC_KEEBS, KC_EMOJI, KC_LOWER,  KC_SPACE_2X, KC_EMPTY,    KC_NORMAL, KC_ENTER]
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
    if (superview != nil) {
      self.frame.size.height = (superview?.bounds.height)!
    } else {
      self.frame.size.height = bounds.height
    }
    

    render()
    super.layoutSubviews();
  }

  func setKeyLayer(keyLayer: PlanckView.KeyLayer) {
    self.keyLayer = keyLayer
    render()
  }

  func setShift(enabled: Bool) {
    self.shift = !self.shift
    render()
  }

  private func render() {
    createKeys();
    for (layerIndex, layer) in keys {
      for (rowIndex, row) in layer.enumerated() {
        for (keyIndex, key) in row.enumerated() {
          let button = key.button;
          var buttonWidth = ceilf((Float(frame.width) / Float(row.count)));
          let buttonHeight = ceilf(Float(frame.height) / Float(layer.count));
          let buttonOffsetX = buttonWidth * Float(keyIndex);
          let buttonOffsetY = buttonHeight * Float(rowIndex);
          buttonWidth = buttonWidth * key.width
          key.setShift(shift: self.shift)
          if (textColor != nil) {
            button.setTitleColor(textColor, for: UIControlState.normal);
          }
          if (backgroundColor_ != nil && button.buttonType == UIButtonType.roundedRect) {
            
            button.backgroundColor = backgroundColor_;
          }
          
//          if (borderColor != nil && button.buttonType == UIButtonType.system) {
//            
//            button.set...  = borderColor;
//          }
          
          if (keyLayer == layerIndex) {
            button.isHidden = false
            button.isEnabled = true
          } else {
            button.isHidden = true
            button.isEnabled = false
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

  func textDidChange(keyboardAppearance: UIKeyboardAppearance) {
    if keyboardAppearance == UIKeyboardAppearance.dark {
      textColor = textLightColor
    } else {
      textColor = textDarkColor
    }
  }
  
  func textWillChange(keyboardAppearance: UIKeyboardAppearance) {
    if keyboardAppearance == UIKeyboardAppearance.dark {
      textColor = textLightColor
    } else {
      textColor = textDarkColor
    }
  }
  
  private func createKeys() {
    frame=bounds
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
            keys[keyLayerIndex]![rowIndex].insert(keyCopy, at: keyIndex)
            _keysFlat.insert(keyCopy, at: keyCopy.button.tag)
            addSubview(keyCopy.button)
          }
        }
      }
    }
  }
}
