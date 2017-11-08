//
//  KeyboardViewController.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 9/27/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITextFieldDelegate {
  var planckView: PlanckView!

  @IBOutlet var nextKeyboardButton: UIButton!

  @IBAction func didTapInsert(sender:UIButton) {
    let proxy = textDocumentProxy
    let key = planckView.findKeyByButtonTag(id: sender.tag)
    key.action(view: self, key: key, proxy: proxy, shifted_: planckView.shift)
  }
  
  func setLayer(keyLayer: PlanckView.KeyLayer) {
    planckView.setKeyLayer(keyLayer: keyLayer)
  }

  func setShift(enabled:Bool? = true) {
    planckView.setShift(enabled: enabled!)
  }

  func loadInterface() {
    let planckNib = UINib(nibName: "Planck", bundle: nil)

    planckView = planckNib.instantiate(withOwner:self, options: nil)[0] as! PlanckView
    
    for (_, layer) in planckView.keys {
      for (_, row) in layer.enumerated() {
        for (_, key) in row.enumerated() {
          key.button.addTarget(self, action: #selector(didTapInsert), for: .touchUpInside)
        }
      }
    }

    view.addSubview(planckView)

    view.backgroundColor = planckView.backgroundColor
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadInterface()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated
  }

  override func textWillChange(_ textInput: UITextInput?) {
    // The app is about to change the document's contents. Perform any preparation here.
    planckView.textWillChange(keyboardAppearance: self.textDocumentProxy.keyboardAppearance!)
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    // The app has just changed the document's contents, the document context has been updated.
    
    planckView.textDidChange(keyboardAppearance: self.textDocumentProxy.keyboardAppearance!)
  }
}
