//
//  MoviesBaseViewController.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

class MoviesBaseViewController: UIViewController {
    // MARK: - Private properties -
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addSubViews()
        setupUIActivityIndicatorViewLayouts()
        setupView()
    }
    
    private func setupUIActivityIndicatorViewLayouts() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func addSubViews() {
        self.view.addSubview(indicatorView)
    }
    
    private func setupView() {
        self.view.backgroundColor = Colors.BACKGROUND_COLOR
    }
    
    @objc
    private func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
    
    func addFilterBarButton(_ selector: Selector?) {
        let filterButton = UIBarButtonItem(image: UIImage(named: Images.FILTER), style: .plain, target: self, action: selector)
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    func setupBackButton() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: Images.BACK), style: .plain, target: self, action: #selector(back(sender:)))
    }
    
    func showLoading(_ show: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = !show
            self.view.isUserInteractionEnabled = !show
            show ? self.indicatorView.startAnimating() : self.indicatorView.stopAnimating()
        }
    }
    
    func showGeneralErrorAlert() {
        let alert = UIAlertController(title: Strings.ERROR, message: Strings.FAILED_TO_GET_YOUR_RESPONSE, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.OK, style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setNavigationItemTitle(_ title: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = title
        }
    }
}
