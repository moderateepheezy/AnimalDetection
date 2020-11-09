//
//  ARViewController.swift
//  AnimalDetection
//
//  Created by Afees Lawal on 09/11/2020.
//

import UIKit
import ARKit
import Vision

class ARViewController: UIViewController {

    private let previewView: ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        previewView.delegate = self
    }

    private func setup() {
        view.addSubview(previewView)

        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.topAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()

        previewView.session.run(configuration)

        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.detectAnimal), userInfo: nil, repeats: true)
    }

    @objc func detectAnimal() {

        guard let currentFrameBuffer = self.previewView.session.currentFrame?.capturedImage else { return }

        let image = CIImage(cvPixelBuffer: currentFrameBuffer)

        guard let model = try? VNCoreMLModel(for: AnimalClassifierModel.init(configuration: MLModelConfiguration()).model) else { return }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            DispatchQueue.main.async {
                if let result = request.results?.first as? VNClassificationObservation {
                    let formatter = NumberFormatter()
                    formatter.maximumFractionDigits = 1
                    let percentage = formatter.string(from: result.confidence * 100 as NSNumber) ?? ""
                    if Int(percentage) ?? 0 > 75 {
                        self.showCapturedAnimal(resultText: "\(result.identifier) \(percentage)%")
                    }
                }
            }
        }

        DispatchQueue.global().async {
            try? VNImageRequestHandler(ciImage: image).perform([request])
        }
    }

    private func showCapturedAnimal(resultText: String) {

        let currentFrame = previewView.snapshot()

        let viewController = CapturedAnimalViewController(image: currentFrame, resultText: resultText)

        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true)
    }
}

extension ARViewController: ARSCNViewDelegate {}
