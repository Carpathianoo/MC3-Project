//
//  CheckingResultsPageController.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 01/08/21.
//

import UIKit




class CheckingResultsPageController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    @IBOutlet weak var solutionList: UITableView!
    
    var solutionCollection: [Solution] = Seeder.seedSolution()
    var uncheckedCondition: [Int] = [0,1,2,3]
    var latestProcess: Process?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        let checkingResultsNib = UINib(nibName: "CheckingResultsCell", bundle: nil)
        solutionList.register(checkingResultsNib, forCellReuseIdentifier: "CRCell")
        
        let selesaiButtonNib = UINib(nibName: "SelesaiButton" , bundle: nil)
        solutionList.register(selesaiButtonNib, forCellReuseIdentifier: "SelesaiButton")
        
        let solutionHeader = UINib(nibName: "SolutionHeaderCell", bundle: nil)
        solutionList.register(solutionHeader, forCellReuseIdentifier: "SectionCell")
        
        
       
        solutionList.delegate = self
        solutionList.dataSource = self

        
        setupView()
    }

    
    func setupView(){
        print()
    }


    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return uncheckedCondition.count + 1
    }
    
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  
    
  
    
    if section < uncheckedCondition.count{
        let headerCell = solutionList.dequeueReusableCell(withIdentifier: "SectionCell") as! SolutionHeaderCell
        headerCell.solutionImage.image = UIImage(named: solutionCollection[uncheckedCondition[section]].photo)
        headerCell.solutionTitle.text = solutionCollection[uncheckedCondition[section]].name
        return headerCell
    }
    else {
        return nil
    }
    
    
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//       print("section:", section)
        
        if section < uncheckedCondition.count {
            if uncheckedCondition[section] == 2 {
                print("there is 2!")
                return 1
            } else {
                return 2
            }
        } else if section == uncheckedCondition.count {
            return 1
        } else {
            return 2
        }
        
        
        
     //return 2
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
    
        if indexPath.section < uncheckedCondition.count{
                let cell = solutionList.dequeueReusableCell(withIdentifier: "CRCell", for: indexPath) as! CheckingResultsCell
            cell.solutionSubtitle.text = solutionCollection[uncheckedCondition[indexPath.section]].subtitle[indexPath.row]
            print("row printed")
          
            
            cell.solutionDetail.text = solutionCollection[uncheckedCondition[indexPath.section]].detail[indexPath.row]
                return cell
            }

            else{
                let cell = solutionList.dequeueReusableCell(withIdentifier: "SelesaiButton", for: indexPath) as!
                    SelesaiButton
                cell.selesaiButtonDelegate = self
                cell.selectionStyle = .none
                return cell
            }
        
    
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == uncheckedCondition.count{
            return 80
        }else{
            return UITableView.automaticDimension
        }
    }
    
    

        
    
}

extension UIViewController: SelesaiButtonDelegate{
    
    func goToDoneChecking(){
        let controller = DoneCheckingViewController()
        let resultVC = CheckingResultsPageController()
        guard let unwrappedLatestProcess = resultVC.latestProcess else {return}
        CoreDataManager.shared.updateProcessStatus(process: unwrappedLatestProcess)
        
             navigationController?.pushViewController(controller, animated: true)
    }
       
    
}
