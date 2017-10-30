//
//  KeyboardViewController.swift
//  linearKeyboardTheBoard
//
//  Created by Graham Heath on 9/27/17.
//  Copyright © 2017 Graham Heath. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
  var planckView: PlanckView!
  var layer: PlanckView.KeyLayer = PlanckView.KeyLayer.NORMAL;

  @IBOutlet var nextKeyboardButton: UIButton!

  @IBAction func didTapInsert(sender:UIButton) {
    let proxy = textDocumentProxy
    let key = planckView.findKeyByButtonTag(id: sender.tag)
    key.action(view: self, key: key, proxy: proxy)
  }

  func setLayer(layer: PlanckView.KeyLayer) -> () {
    self.layer = layer
  }

  func loadInterface() {
    let planckNib = UINib(nibName: "Planck", bundle: nil)

    planckView = planckNib.instantiate(withOwner:self, options: nil)[0] as! PlanckView

    for (_, row) in planckView.keys.enumerated() {
      for (_, key) in row.enumerated() {
        key.button.addTarget(self, action: #selector(didTapInsert), for: .touchUpInside)
      }
    }

    view.addSubview(planckView)

    view.backgroundColor = planckView.backgroundColor
  }

  override func updateViewConstraints() {
    super.updateViewConstraints()

    // Add custom view sizing constraints here
  }

  override func viewDidLoad() {
    super.viewDidLoad()

        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])

    loadInterface()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated
  }

  override func textWillChange(_ textInput: UITextInput?) {
    // The app is about to change the document's contents. Perform any preparation here.
  }

  override func textDidChange(_ textInput: UITextInput?) {
    // The app has just changed the document's contents, the document context has been updated.

    var textColor: UIColor
    let proxy = self.textDocumentProxy
    if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
      textColor = UIColor.white
    } else {
      textColor = UIColor.black
    }
  }
}