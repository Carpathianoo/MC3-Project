//
//  ResultViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var solutionTV: UITableView!
    let seeder = Seeder()
    var solutions: [Solution] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        solutions = seeder.seedSolution()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        let nibCell = UINib(nibName: SolutionTableViewCell.identifier, bundle: nil)
        solutionTV.register(nibCell, forCellReuseIdentifier: SolutionTableViewCell.identifier)
        solutionTV.separatorStyle = .none
        solutionTV.delegate = self
        solutionTV.dataSource = self
        solutionTV.reloadData()
    }

    
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return solutions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return solutions[section].detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = solutionTV.dequeueReusableCell(withIdentifier: SolutionTableViewCell.identifier, for: indexPath) as! SolutionTableViewCell
        cell.subtitleLbl.text = solutions[indexPath.section].subtitle[indexPath.row]
        cell.solDetailLbl.text = solutions[indexPath.section].detail[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: solutions[section].photo)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        let headerLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 265, height: 32))
        
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = UIColor.green
        
        headerLbl.text = solutions[section].name
        headerLbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        headerLbl.numberOfLines = 0
        
        customView.addSubview(imageView)
        customView.addSubview(headerLbl)
        customView.layer.backgroundColor = UIColor.white.cgColor
        
        imageView.centerYAnchor(y: customView.centerYAnchor)
        imageView.sizeAnchor(width: 40.0, height: 40.0)
        imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor,constant: 20).isActive = true
        
        headerLbl.anchor(top: customView.safeAreaLayoutGuide.topAnchor, bottom: customView.safeAreaLayoutGuide.bottomAnchor)
        headerLbl.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        headerLbl.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -15).isActive = true

        
        return customView
    }
    
}
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
    }
    
    func sizeAnchor(width: CGFloat, height: CGFloat){
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func centerXAnchor(x: NSLayoutXAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: x).isActive = true
        
    }
    
    func centerYAnchor(y: NSLayoutYAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: y).isActive = true
    }
    
}
