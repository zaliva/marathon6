import UIKit

class ViewController: UIViewController {

    private let squareView = UIView()
    private var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSquareView()
        setupGesture()
    }

    private func setupSquareView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.center = view.center
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        view.addSubview(squareView)
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self.view)
        switch gesture.state {
        case .ended:
            startAnimation(to: point)
        default:
            break
        }
    }

    private func startAnimation(to point: CGPoint) {
        stopAnimation()

        let distance = sqrt(pow(point.x - squareView.center.x, 2) + pow(point.y - squareView.center.y, 2))
        let duration = min(0.3 + Double(distance) * 0.002, 1.5)

        animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.6) {
            let angle = atan2(point.y - self.squareView.center.y, point.x - self.squareView.center.x)
            let rotation = CGAffineTransform(rotationAngle: angle)
            self.squareView.transform = rotation
            self.squareView.center = point
        }
        animator?.startAnimation()
    }

    private func stopAnimation() {
        animator?.stopAnimation(true)
        animator = nil
    }
}
