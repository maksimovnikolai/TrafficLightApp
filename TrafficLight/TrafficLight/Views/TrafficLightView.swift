//
//  TrafficLightView.swift
//  TrafficLight
//
//  Created by Nikolai Maksimov on 19.12.2023.
//

import UIKit

enum ColorView {
    case red
    case yellow
    case green
}

final class TrafficLightView: UIView {
    
    private lazy var stackView = makeStackView()
    private lazy var redView = makeView(with: .red)
    private lazy var yellowView = makeView(with: .yellow)
    private lazy var greenView = makeView(with: .green)
    private lazy var titleLabel = makeLabel()
    private lazy var startButton = makeButton()
    
    private let isOn: CGFloat = 1
    private let isOff: CGFloat = 0.3
    private var currentView = ColorView.red
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupConstraintsForStackView()
        configureStackView()
        setupConstraintsForRedView()
        setupConstraintsForLabel()
        setupButtonConstraints()
        setupCornerRadiusForView()
        startButton.addTarget(self, action: #selector(changeLight), for: .touchUpInside)
    }
    
    private func setupCornerRadiusForView() {
        layoutIfNeeded()
        redView.layer.cornerRadius = redView.frame.width / 2
        yellowView.layer.cornerRadius = redView.frame.width / 2
        greenView.layer.cornerRadius = redView.frame.width / 2
    }
    
    @objc
    private func changeLight() {
        switch currentView {
        case .red:
            greenView.alpha = isOff
            redView.alpha = isOn
            titleLabel.text = "STOP!"
            currentView = .yellow
        case .yellow:
            redView.alpha = isOff
            yellowView.alpha = isOn
            titleLabel.text = "Get Ready!"
            currentView = .green
        case .green:
            yellowView.alpha = isOff
            greenView.alpha = isOn
            titleLabel.text = "GO!"
            currentView = .red
        }
    }
}

// MARK: UIElements
extension TrafficLightView {
    
    private func configureStackView() {
        stackView.addArrangedSubview(redView)
        stackView.addArrangedSubview(yellowView)
        stackView.addArrangedSubview(greenView)
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 34
        return stackView
    }
    
    private func makeView(with color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.alpha = 0.3
        return view
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "START"
        button.layer.cornerRadius = 10
        return button
    }
}

// MARK: Constraints
extension TrafficLightView {
    
    private func setupConstraintsForStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
    
    private func setupConstraintsForRedView() {
        NSLayoutConstraint.activate([
            redView.widthAnchor.constraint(equalToConstant: 100),
            redView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupConstraintsForLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setupButtonConstraints() {
        addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
}
