import XCTest
import ReactiveSwift
import ReactiveCocoa
import Result

class UIActivityIndicatorTests: XCTestCase {
	weak var _activityIndicatorView: UIActivityIndicatorView?

	override func tearDown() {
		XCTAssert(_activityIndicatorView == nil, "Retain cycle detected in UIActivityIndicatorView properties")
		super.tearDown()
	}

	func testAnimatingProperty() {
		let indicatorView = UIActivityIndicatorView(frame: CGRect.zero)
		_activityIndicatorView = indicatorView

		let (pipeSignal, observer) = Signal<Bool, NoError>.pipe()
		indicatorView.reactive.isAnimating <~ SignalProducer(signal: pipeSignal)

		observer.send(value: true)
		XCTAssertTrue(indicatorView.isAnimating)
		observer.send(value: false)
		XCTAssertFalse(indicatorView.isAnimating)
	}
}