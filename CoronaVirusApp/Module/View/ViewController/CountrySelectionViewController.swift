//
//  CountrySelectionViewController.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import UIKit

class CountrySelectionViewController: UIViewController {
    //MARK: Properties
    let countrySelectionView: CountrySelectionMainView = {
        let view = CountrySelectionMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CounrySelection VC deinit")
    }}

//MARK: - Life Cycle
extension CountrySelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - UI
private extension CountrySelectionViewController {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(countrySelectionView)
    }
    
    func setupLayout() {
        countrySelectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
