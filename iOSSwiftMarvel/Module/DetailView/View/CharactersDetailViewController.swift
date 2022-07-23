//
//  CharactersDetailViewController.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 23/7/22.
//

import UIKit

class CharactersDetailViewController: CommonViewController, IdentifierProtocol {
    static var myClassName: String = "CharactersDetailViewController"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    func setup(_ model: ResultModel) {
        nameLabel.text = model.name
        nameLabel.setupHidden()

        descriptionLabel.text = model.resultDescription
        descriptionLabel.setupHidden()

        loadImage(model)
    }

    private func loadImage(_ model: ResultModel) {
        guard let pathImage = model.thumbnail?.path, let extImage = model.thumbnail?.thumbnailExtension else {
            return
        }

        if let url = URL(string: "\(pathImage).\(extImage)") {
            imageView.kf.setImage(with: url)
        }
    }
}
