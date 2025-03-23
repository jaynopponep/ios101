//
//  KeyboardCell.swift
//  Wordle
//
//  Created by Mari Batilando on 2/12/23.
//

import UIKit

class KeyboardCell: UICollectionViewCell {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var labelContainerView: UIView!
  private var string: String!
  var didSelectString: ((String) -> Void)!

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapString))
    contentView.addGestureRecognizer(tapGestureRecognizer)
  }

  func configure(with string: String) {
    labelContainerView.layer.cornerRadius = 4.0
    labelContainerView.backgroundColor = .gray
    /* Exercise 2:
      1. Assign the argument `string` to the `self.string` private property (see line 14)
      2. Change the text of the label to the value of the passed in string
      Checkpoint: */
      self.string = string
      label.text = self.string
}

  // Exercise 5: Call the `didSelectString` closure and pass in the string this cell holds (see line 14)
  // Checkpoint: After finishing this exercise, you should now be able to tap on a keyboard cell and
  @objc private func didTapString() {
      self.didSelectString(self.string)
  }
}
