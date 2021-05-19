//
//  WebViewViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 04.05.2021..
//

import UIKit
import SnapKit
import WebKit

class WebViewViewController: UIViewController {
    //MARK: Properties
    let viewModel: WebViewViewModel!
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsBackForwardNavigationGestures = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    init(viewModel: WebViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WebView Controller deinit")
    }
}

//MARK - Lifecycle
extension WebViewViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel.coordinatorDeleagte?.viewControllerDidFinish()
        }
    }
}

private extension WebViewViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupNavigationBar()
        setupWebView()
        loadWebPage()
    }
    
    func setupAppearance() {
        view.backgroundColor = UIColor.backgroundColorFirst
    }
    
    func addViews() {
        view.addSubview(webView)
    }
    
    func setupLayout() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.invertedWhiteBlack
        navigationController?.navigationBar.barTintColor = UIColor.backgroundColorFirst
        navigationController?.navigationBar.backgroundColor = UIColor.backgroundColorFirst
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.clipsToBounds = false
    }
    
}

extension WebViewViewController: WKNavigationDelegate {
    func setupWebView() {
        webView.navigationDelegate = self
    }
    
    func loadWebPage() {
        let url = viewModel.screenData
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
}
