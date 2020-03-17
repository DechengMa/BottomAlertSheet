//
//  BottomAlertView.swift
//  BottomAlertSheet
//
//  Created by Decheng Ma on 17/3/20.
//  Copyright © 2020 Decheng Ma. All rights reserved.
//

import UIKit

class BottomAlertView: UIView {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 11
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 11
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.darkText, for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private func setupLayout() {
        if bottomButton.titleLabel?.text != "" {
            bottomView.heightAnchor.constraint(equalToConstant: 53.5).isActive = true
        }

        bottomView.addSubview(bottomButton)
        NSLayoutConstraint.activate([
            bottomButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            bottomButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            bottomButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor),
            bottomButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor)
        ])

        addSubview(topView)
        addSubview(bottomView)

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])

        topView.addSubview(titleLabel)
        topView.addSubview(messageLabel)
        topView.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleLabel.superview!.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 15),

            messageLabel.centerXAnchor.constraint(equalTo: messageLabel.superview!.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            messageLabel.widthAnchor.constraint(equalTo: messageLabel.superview!.widthAnchor, constant: -70),

            buttonStackView.leadingAnchor.constraint(equalTo: buttonStackView.superview!.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: buttonStackView.superview!.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: buttonStackView.superview!.bottomAnchor),
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25),

            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -35),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, constant: -30),
            self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor)
        ])

        self.transform = self.transform.translatedBy(x: 0, y: 500)
    }

    init<T>(title: String, message: T, topButtons: [UIButton], bottomButtonTitle: String) {
        super.init(frame: .zero)

        if T.self == String.self {
            messageLabel.text = message as? String
            messageLabel.font = .systemFont(ofSize: 13)
        } else if T.self == NSMutableAttributedString.self {
            messageLabel.attributedText = message as? NSAttributedString
        }

        self.translatesAutoresizingMaskIntoConstraints = false

        bottomButton.setTitle(bottomButtonTitle, for: .normal)
        titleLabel.text = title

        topButtons.forEach { button in
            buttonStackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true

            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 30, y: 0))

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineWidth = 1

            button.layer.addSublayer(shapeLayer)

            button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        }
    }

    func present() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            DispatchQueue.main.async {
                topController.view.addSubview(self.backgroundView)
                NSLayoutConstraint.activate([
                    self.backgroundView.centerYAnchor.constraint(equalTo: self.backgroundView.superview!.centerYAnchor),
                    self.backgroundView.centerYAnchor.constraint(equalTo: self.backgroundView.superview!.centerYAnchor),
                    self.backgroundView.heightAnchor.constraint(equalTo: self.backgroundView.superview!.heightAnchor),
                    self.backgroundView.widthAnchor.constraint(equalTo: self.backgroundView.superview!.widthAnchor)
                ])

                self.backgroundView.alpha = 0

                topController.view.addSubview(self)

                self.setupLayout()

                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseIn], animations: {
                    self.backgroundView.alpha = 1
                    self.transform = .identity
                }, completion: nil)
            }
        }
    }

    @objc func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.transform = self.transform.translatedBy(x: 0, y: 500)
        }, completion: { [weak self] _ in
            self?.backgroundView.removeFromSuperview()
            self?.removeFromSuperview()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

