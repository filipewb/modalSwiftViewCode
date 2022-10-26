import UIKit

class ViewController: UIViewController {
    
    private let button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Avaliar", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.layer.cornerRadius = 20
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(didTapPresent), for: .touchUpInside)
        return b
    }()
    
    @objc func didTapPresent() {
        PopupViewController.present(
            initialView: self,
            delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }

}

extension ViewController: PopupDelegate {
    func didTapCancel() {
        self.dismiss(animated: true)
    }
    
    func didTapConfirm(){
        print("clicou CONFIRMA")
    }
}
