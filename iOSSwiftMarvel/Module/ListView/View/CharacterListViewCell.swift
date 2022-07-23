import UIKit
import Kingfisher

class CharacterListViewCell: UITableViewCell, IdentifierProtocol {
    static var myClassName: String = "CharacterListViewCell"

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

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
            thumbnailImage.kf.setImage(with: url)
        }
    }
}
