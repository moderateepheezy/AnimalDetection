//
//  CapturedAnimalViewController.swift
//  AnimalDetection
//
//  Created by Afees Lawal on 09/11/2020.
//

import UIKit

class CapturedAnimalViewController: UIViewController {

    var ondismissCompleted: (() -> Void)?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = resultText
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resultText: String

    private let image: UIImage

    init(image: UIImage, resultText: String) {
        self.image = image
        self.resultText = resultText
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onCancelTapped))
    }

    private func setup() {
        view.addSubview(imageView)
        view.addSubview(resultLabel)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])
    }

    @objc private func onCancelTapped() {
        dismiss(animated: true, completion: ondismissCompleted)
    }
}
