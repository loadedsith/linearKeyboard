//
//  Actions.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 10/29/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import Foundation
import UIKit

func BACKSPACE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.deleteBackward()
}

func NEXT_KEYBOARD(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  view.advanceToNextInputMode();
}

func TAB(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.insertText(" ")
}

func CAPS(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  view.setLayer(layer: PlanckView.KeyLayer.CAPS)
}

func RAISE(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  view.setLayer(layer: PlanckView.KeyLayer.RAISE)
}

func LOWER(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  view.setLayer(layer: PlanckView.KeyLayer.LOWER)
}

func LEFT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.adjustTextPosition(byCharacterOffset: -1)
}

func DOWN(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.adjustTextPosition(byCharacterOffset: 10)
}

func UP(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.adjustTextPosition(byCharacterOffset: -10)
}

func RIGHT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  proxy.adjustTextPosition(byCharacterOffset: 1)
}

func SHIFT(view: KeyboardViewController, key: ButtonKey, proxy: UITextDocumentProxy) {
  view.setLayer(layer: PlanckView.KeyLayer.SHIFT)
}

