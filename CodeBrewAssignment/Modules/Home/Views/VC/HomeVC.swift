//
//  HomeVC.swift
//  CodeBrewAssignment
//
//  Created by Nitin Mittal on 08/01/22.
//

import UIKit

class HomeVC: UIViewController {
    //ALL IBOUTLETS & VARIABLES
    @IBOutlet weak var workTextView: UIView!
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    let viewModel = HomeBaseVM()
    var selectedCVCell = 0
    var locationUpdateLaunching = true

//MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        registerCell()
        getCalculatedDistance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedNotification(notification:)), name: Notification.Name("NotificationCurrentLocation"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

   //MARK: SETUP UI METHOD
    func setUpUi(){
        workTextView?.layer.cornerRadius = 12
        spinner?.isHidden = true
    }
    
    //MARK: REGISTER CELLS METHOD
    func registerCell(){
        categoryCV?.backgroundColor = .white
        categoryCV?.registerCell(identifier:CategoryCVCell.categoryCVCellIdentifier)
        detailsTV?.backgroundColor = .white
        detailsTV?.register(UINib(nibName: DetailsTVCell.detailsTVCellCellIdentifier, bundle: nil), forCellReuseIdentifier: "\(DetailsTVCell.classForCoder())")
    }
    
    //MARK: GET CALCULATED DISTANCE METHOD
    func getCalculatedDistance(){
        if AppDelegate.distance > 15 {
            let alert = UIAlertController(title: "Message", message: "You are too far away from company", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true) {
                self.detailsTV?.isHidden = true
            }
        }else{
            self.detailsTV?.isHidden = false
            getDetailDataApi()
        }
    }
    
    //MARK: RECIEVED CURRENT LOCATION NOTIFICATION METHOD
    @objc func receivedNotification(notification: Notification) {
        if locationUpdateLaunching == true{
            locationUpdateLaunching = false
        getCalculatedDistance()
        }
    }
    
    //MARK: Details API METHOD
    func getDetailDataApi(){
        DispatchQueue.main.async {
            self.spinner?.isHidden = false
            self.spinner?.startAnimating()
        }
        viewModel.getDetailsApi(completion: { [weak self] success in
            DispatchQueue.main.async { [self] in
                    self?.spinner?.stopAnimating()
                    self?.spinner?.isHidden = true
                if success {
                    self?.detailsTV?.reloadData()
                }
            }
        })
    }

}

//MARK: COLLECTION VIEW DATA SOURCE AND DELEGATE METHODS
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryTextArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, with: CategoryCVCell.self)
        cell.categoryTextLbl.text = viewModel.categoryTextArray[indexPath.item]
        if selectedCVCell == indexPath.item{
            cell.categoryTextLbl.textColor = UIColor.hexStringToUIColor("282525")
        }else{
            cell.categoryTextLbl.textColor = UIColor.rgb(red: 40, green: 37, blue: 37, alpha: 0.6)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCVCell = indexPath.item
        switch indexPath.item {
        case 0:
            noDataLbl?.isHidden = true
            self.getCalculatedDistance()
        case 1,2:
            detailsTV?.isHidden = true
            noDataLbl?.isHidden = false
        default:
            break
        }
        categoryCV?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 , height: collectionView.frame.height)
    }
}

//MARK: TAVLE VIEW DATA SOURCE AND DELEGATE METHODS
extension HomeVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDetailsDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: DetailsTVCell.self)
        let description = viewModel.getDescription(indexPath: indexPath)
        let date = viewModel.getDateTime(indexPath: indexPath)
        let count = viewModel.reOpenCount(indexPath: indexPath)
        let hourLimit = viewModel.hourLimit(indexPath: indexPath)
        cell.descriptionLbl.text = description
        cell.dateTimeLbl.text = date
        if hourLimit == true {
            cell.backGroundView.backgroundColor = UIColor.hexStringToUIColor("FFCCCC")
            cell.progressImgView.image = UIImage(named: "redProgress")
            cell.openTaskLbl.text = "TASK DELAYED"
        }else{
            cell.backGroundView.backgroundColor = UIColor.hexStringToUIColor("F8F9FD")
            cell.progressImgView.image = UIImage(named: "greenprogress")
            if count == 0 {
                cell.openTaskLbl.text = ""
                cell.redCircleImgView.isHidden = true
            }else{
                cell.openTaskLbl.text = "RE-OPEN TASK (\(count))"
                cell.redCircleImgView.isHidden = false
            }
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = viewModel.reOpenCount(indexPath: indexPath)
        if count == 0 {
            return 101
        }
        return 116
    }
}

