import Foundation
import UIKit

public protocol PopupDelegate: AnyObject {
    func didTapCancel()
    func didTapConfirm()
}

public final class PopupViewController: UIViewController {
    
    private static func create(
        delegate: PopupDelegate
    ) -> PopupViewController {
        let view = PopupViewController(delegate: delegate)
        return view
    }
    
    @discardableResult
    static public func present(
        initialView: UIViewController,
        delegate: PopupDelegate
    ) -> PopupViewController {
        let view = PopupViewController.create(delegate: delegate)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .coverVertical
        initialView.present(view, animated: true)
        return view
    }
    
    public init(delegate: PopupDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public weak var delegate: PopupDelegate?
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Remover Favorito?"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ao remover a cervejaria dos favoritos, ela deixa de aparecer na listagem de cervejarias favoritas. Você pode adicionar a cervejaria como favorita novamente quando quiser."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.didTapCancel(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonConfirm: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 17
        button.layer.backgroundColor = UIColor.yellow.cgColor
        button.setTitle("Confirmar remoção", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.didTapConfirm(_:)), for: .touchUpInside)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    @objc func didTapCancel(_ btn: UIButton) {
        self.delegate?.didTapCancel()
    }
    
    @objc func didTapConfirm(_ btn: UIButton) {
        self.delegate?.didTapConfirm()
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.addSubview(containerView)
        self.containerView.addSubview(labelTitle)
        self.containerView.addSubview(labelText)
        self.containerView.addSubview(buttonCancel)
        self.containerView.addSubview(buttonConfirm)

        NSLayoutConstraint.activate([
            self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.containerView.widthAnchor.constraint(equalToConstant: 352),
            
            self.labelTitle.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 25),
            self.labelTitle.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),

            self.labelText.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: 24),
            self.labelText.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            self.labelText.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            
            self.buttonCancel.heightAnchor.constraint(equalToConstant: 40),
            self.buttonCancel.topAnchor.constraint(equalTo: self.labelText.bottomAnchor, constant: 28),
            self.buttonCancel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            self.buttonCancel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            
            self.buttonConfirm.heightAnchor.constraint(equalToConstant: 40),
            self.buttonConfirm.topAnchor.constraint(equalTo: self.buttonCancel.bottomAnchor, constant: 10),
            self.buttonConfirm.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            self.buttonConfirm.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            self.buttonConfirm.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -28),
        ])
    }
}
