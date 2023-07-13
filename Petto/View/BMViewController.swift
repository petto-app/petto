//
//  BMController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 01/07/23.
//

import SwiftUI
import UIKit
import Vision

@available(iOS 14.0, *)
class BMViewController: UIViewController {
    /// The full-screen view that presents the pose on top of the video frames.
    @IBOutlet var imageView: UIImageView!

    /// The stack that contains the labels at the middle of the leading edge.
    @IBOutlet var labelStack: UIStackView!

    /// The label that displays the model's exercise action prediction.
    @IBOutlet var actionLabel: UILabel!

    /// The label that displays the model's confidence in its prediction.
    @IBOutlet var confidenceLabel: UILabel!

    /// The stack that contains the buttons at the bottom of the leading edge.
    @IBOutlet var buttonStack: UIStackView!

    /// The button users tap to show a summary view.
    @IBOutlet var summaryButton: UIButton!

    /// The button users tap to toggle between the front- and back-facing
    /// cameras.
    @IBOutlet var cameraButton: UIButton!

    /// Captures the frames from the camera and creates a frame publisher.
    var videoCapture: VideoCapture!

    /// Builds a chain of Combine publishers from a frame publisher.
    ///
    /// The video-processing chain provides the view controller with:
    /// - Each video camera frame as a `CGImage`.
    /// - A `Pose` array of any people `Vision` observed in that frame.
    /// - Action predictions from the prominent person's poses over time.
    var videoProcessingChain: VideoProcessingChain!

    /// Maintains the aggregate time for each action the model predicts.
    /// - Tag: actionFrameCounts
    var actionFrameCounts = [String: Int]()
    
    public var coordinator: BMView.Coordinator?

    public var bodyMovementTask: BodyMovementTaskItem?
    var statModel: StatModel?
    
    var timer: Timer?
    var interval: Double = 7.0
    var predictionHistory: [ActionPrediction] = []
    var accumulatedPredictions: [ActionPrediction] = []
    
    var movementAmount: Int = 0
    var lastPrediction: Date = Date()
}

// MARK: - View Controller Events

extension BMViewController {
    /// Configures the main view after it loads.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Randomed task: \(bodyMovementTask?.movementType)")

        // Disable the idle timer to prevent the screen from locking.
        UIApplication.shared.isIdleTimerDisabled = true

        // Round the corners of the stack and button views.
        let views = [labelStack, buttonStack, cameraButton, summaryButton]
        views.forEach { view in
            view?.layer.cornerRadius = 10
            view?.overrideUserInterfaceStyle = .dark
        }

        // Set the view controller as the video-processing chain's delegate.
        videoProcessingChain = VideoProcessingChain()
        videoProcessingChain.delegate = self

        // Begin receiving frames from the video capture.
        videoCapture = VideoCapture()
        videoCapture.delegate = self

        movementAmount = 0
        
        coordinator?.dismissBottomSheet()
    }

    /// Configures the video captures session with the device's orientation.
    ///
    /// This is the app's first opportunity to retrieve the device's
    /// physical orientation with its hardware sensors.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Update the device's orientation.
        videoCapture.updateDeviceOrientation()
    }

    /// Notifies the video capture when the device rotates to a new orientation.
    override func viewWillTransition(to _: CGSize,
                                     with _: UIViewControllerTransitionCoordinator) {
        // Update the the camera's orientation to match the device's.
        videoCapture.updateDeviceOrientation()
    }
    
    /// Destroy instance when moving to another page
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)

        videoProcessingChain = nil
        videoCapture = nil
    }
}

// MARK: - Button Events

extension BMViewController {
    /// Toggles the video capture between the front- and back-facing cameras.
    @IBAction func onCameraButtonTapped(_: Any) {
        videoCapture.toggleCameraSelection()
    }

    /// Presents a summary view of the user's actions and their total times.
    @IBAction func onSummaryButtonTapped() {
        let main = UIStoryboard(name: "Main", bundle: nil)

        // Get the view controller based on its name.
        let vcName = "SummaryViewController"
        let viewController = main.instantiateViewController(identifier: vcName)

        // Cast it as a `SummaryViewController`.
        guard let summaryVC = viewController as? SummaryViewController else {
            fatalError("Couldn't cast the Summary View Controller.")
        }

        // Copy the current actions times to the summary view.
        summaryVC.actionFrameCounts = actionFrameCounts

        // Define the presentation style for the summary view.
        modalPresentationStyle = .popover
        modalTransitionStyle = .coverVertical

        // Reestablish the video-processing chain when the user dismisses the
        // summary view.
        summaryVC.dismissalClosure = {
            // Resume the video feed by enabling the camera when the summary
            // view goes away.
            self.videoCapture.isEnabled = true
        }

        // Present the summary view to the user.
        present(summaryVC, animated: true)

        // Stop the video feed by disabling the camera while showing the summary
        // view.
        videoCapture.isEnabled = false
    }
}

// MARK: - Video Capture Delegate

extension BMViewController: VideoCaptureDelegate {
    /// Receives a video frame publisher from a video capture.
    /// - Parameters:
    ///   - videoCapture: A `VideoCapture` instance.
    ///   - framePublisher: A new frame publisher from the video capture.
    func videoCapture(_: VideoCapture,
                      didCreate framePublisher: FramePublisher) {
        updateUILabelsWithPrediction(.startingPrediction)

        // Build a new video-processing chain by assigning the new frame publisher.
        videoProcessingChain.upstreamFramePublisher = framePublisher
    }
}

// MARK: - video-processing chain Delegate

extension BMViewController: VideoProcessingChainDelegate {
    /// Receives an action prediction from a video-processing chain.
    /// - Parameters:
    ///   - chain: A video-processing chain.
    ///   - actionPrediction: An `ActionPrediction`.
    ///   - duration: The span of time the prediction represents.
    /// - Tag: detectedAction
    func videoProcessingChain(_: VideoProcessingChain,
                              didPredict actionPrediction: ActionPrediction,
                              for frameCount: Int) {
        if actionPrediction.isModelLabel {
            // Update the total number of frames for this action.
            addFrameCount(frameCount, to: actionPrediction.label)
        }

        print("Update label to view: \(actionPrediction.label)")
        
        // Present the prediction in the UI.
        updateUILabelsWithPrediction(actionPrediction)
    }

    /// Receives a frame and any poses in that frame.
    /// - Parameters:
    ///   - chain: A video-processing chain.
    ///   - poses: A `Pose` array.
    ///   - frame: A video frame as a `CGImage`.
    func videoProcessingChain(_: VideoProcessingChain,
                              didDetect poses: [Pose]?,
                              in frame: CGImage) {
        // Render the poses on a different queue than pose publisher.
        DispatchQueue.global(qos: .userInteractive).async {
            // Draw the poses onto the frame.
            self.drawPoses(poses, onto: frame)
        }
    }
    
    internal func startPredictionTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.processPredictionResults()
            
            // Reset the accumulated predictions
            self.accumulatedPredictions.removeAll()
        }
    }
    
    func appendAccumulatedPredictions(_ actionPrediction: ActionPrediction) {
        accumulatedPredictions.append(actionPrediction)
    }
    
    // Prediction results will be processed once in the time interval, to get only ONE kind of body movement
    func processPredictionResults() {
        // Check if there are accumulated predictions
        guard !accumulatedPredictions.isEmpty else {
            return
        }
        
        let mostAccuratePredictions = [ActionPrediction]()
        
        print("Accumulated predictions:")
        print(accumulatedPredictions)
        
        // Get one of the prediction with the highest confidence (most accurate prediction)
        let prediction = Dictionary(
                            grouping:
                                accumulatedPredictions
                                    .sorted { $0.confidence > $1.confidence } // Sort the accumulated predictions in descending order of confidence
                        ) { $0.label } // Prevent multiple kind of body movement that appear
                            .values
                            .compactMap { value in value.first } // Get the first maximum confidence prediction of each kind of body movement
                            .sorted { $0.confidence > $1.confidence } // Sort again to make sure the maximum confidence
                            .first

        print("Selected Prediction:")
        print(prediction!)
        
        // Save the most accurate prediction to the prediction history
        predictionHistory.append(prediction!)

        // Show the most recent prediction in the UI
        handleMovement(actionPrediction: prediction!)

        // Send the action prediction to UI.
        videoProcessingChain(videoProcessingChain,
                             didPredict: prediction!,
                             for: videoProcessingChain.windowStride)

        // Reset the accumulated predictions
        self.accumulatedPredictions.removeAll()
    }
}

// MARK: - Helper methods

extension BMViewController {
    /// Add the incremental duration to an action's total time.
    /// - Parameters:
    ///   - actionLabel: The name of the action.
    ///   - duration: The incremental duration of the action.
    private func addFrameCount(_ frameCount: Int, to actionLabel: String) {
        // Add the new duration to the current total, if it exists.
        let totalFrames = (actionFrameCounts[actionLabel] ?? 0) + frameCount

        // Assign the new total frame count for this action.
        actionFrameCounts[actionLabel] = totalFrames
    }

    /// Updates the user interface's labels with the prediction and its
    /// confidence.
    /// - Parameters:
    ///   - label: The prediction label.
    ///   - confidence: The prediction's confidence value.
    private func updateUILabelsWithPrediction(_ prediction: ActionPrediction) {
        // Update the UI's prediction label on the main thread.
        DispatchQueue.main.async { self.actionLabel.text = prediction.label }

        // Update the UI's confidence label on the main thread.
        let confidenceString = prediction.confidenceString ?? "Observing..."
        DispatchQueue.main.async { self.confidenceLabel.text = confidenceString }
    }

    /// Draws poses as wireframes on top of a frame, and updates the user
    /// interface with the final image.
    /// - Parameters:
    ///   - poses: An array of human body poses.
    ///   - frame: An image.
    /// - Tag: drawPoses
    private func drawPoses(_ poses: [Pose]?, onto frame: CGImage) {
        // Create a default render format at a scale of 1:1.
        let renderFormat = UIGraphicsImageRendererFormat()
        renderFormat.scale = 1.0

        // Create a renderer with the same size as the frame.
        let frameSize = CGSize(width: frame.width, height: frame.height)
        let poseRenderer = UIGraphicsImageRenderer(size: frameSize,
                                                   format: renderFormat)

        // Draw the frame first and then draw pose wireframes on top of it.
        let frameWithPosesRendering = poseRenderer.image { rendererContext in
            // The`UIGraphicsImageRenderer` instance flips the Y-Axis presuming
            // we're drawing with UIKit's coordinate system and orientation.
            let cgContext = rendererContext.cgContext

            // Get the inverse of the current transform matrix (CTM).
            let inverse = cgContext.ctm.inverted()

            // Restore the Y-Axis by multiplying the CTM by its inverse to reset
            // the context's transform matrix to the identity.
            cgContext.concatenate(inverse)

            // Draw the camera image first as the background.
            let imageRectangle = CGRect(origin: .zero, size: frameSize)
            cgContext.draw(frame, in: imageRectangle)

            // Create a transform that converts the poses' normalized point
            // coordinates `[0.0, 1.0]` to properly fit the frame's size.
            let pointTransform = CGAffineTransform(scaleX: frameSize.width,
                                                   y: frameSize.height)

            guard let poses = poses else { return }

            // Draw all the poses Vision found in the frame.
            for pose in poses {
                // Draw each pose as a wireframe at the scale of the image.
                pose.drawWireframeToContext(cgContext, applying: pointTransform)
            }
        }

        // Update the UI's full-screen image view on the main thread.
        DispatchQueue.main.async { self.imageView.image = frameWithPosesRendering }
    }
    
    func handleMovement(actionPrediction: ActionPrediction) {
        let secondDiff = Calendar.current.dateComponents([.second], from: lastPrediction, to: Date()).second
        
        // Check if last prediction is equal or more than minimum prediction interval
        if secondDiff! >= Int(interval) {
            if let bodyMovementTask = bodyMovementTask {
                let stringType = coordinator?.getBodyMovementStringType(item: bodyMovementTask)
                
                // Check if the detected motion is the same as the requested movement
                if actionPrediction.label == stringType {
                    // Add the number of movements
                    movementAmount += 1
                    lastPrediction = Date()
                    
                    if movementAmount == bodyMovementTask.amount {
                        coordinator?.addPopUp(bodyMovementTask: bodyMovementTask)
                        navigationController?.pushViewController(UIHostingController(rootView: Home()), animated: true)
                    }
                    
                    // TODO: Add dialog how much more to go
                } else {
                    // TODO: Add dialog coba lagi
                    print("Coba lagi!")
                }
            }
        }
        print("Current movement amount: \(movementAmount)")
    }
}
