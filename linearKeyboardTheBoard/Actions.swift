//
//  Actions.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 10/29/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import Foundation
import UIKit

func BACKSPACE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.deleteBackward()
}

func DELETE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.deleteBackward()
}

func NEXT_KEYBOARD(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.advanceToNextInputMode();
}

func TAB(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.insertText(" ")
}

func SPACE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.insertText(" ")
}

func CAPS(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.setShift()
}

func RAISE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.setLayer(keyLayer: PlanckView.KeyLayer.RAISE)
}

func LOWER(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.setLayer(keyLayer: PlanckView.KeyLayer.LOWER)
}

func NORMAL(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.setLayer(keyLayer: PlanckView.KeyLayer.NORMAL)
}

func LEFT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.adjustTextPosition(byCharacterOffset: -1)
}

func DOWN(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.adjustTextPosition(byCharacterOffset: 10)
}

func UP(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.adjustTextPosition(byCharacterOffset: -10)
}

func RIGHT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  proxy.adjustTextPosition(byCharacterOffset: 1)
}

func SHIFT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy, shifted_: Bool) {
  view.setShift()
}

