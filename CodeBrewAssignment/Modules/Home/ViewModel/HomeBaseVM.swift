//
//  HomeBaseVM.swift
//  CodeBrewAssignment
//
//  Created by Nitin Mittal on 08/01/22.
//

import UIKit
import Alamofire

class HomeBaseVM: NSObject {
    
    let categoryTextArray = ["My Tasks","Assigned","Completed"]
    var detailModelData : CategoryDetailModel?

    func getDetailsDataCount() -> Int{
        detailModelData?.dataMain?.data?.count ?? 0
    }
    
    func getDescription(indexPath:IndexPath) -> String{
        if let description = detailModelData?.dataMain?.data?[indexPath.item].description{
            return description
        }
        return ""
    }
    
    func getDateTime(indexPath:IndexPath) -> String{
        if let date = detailModelData?.dataMain?.data?[indexPath.item].created_at{
            return date
        }
        return ""
    }
    
    func reOpenCount(indexPath:IndexPath) -> Int{
        if let count = detailModelData?.dataMain?.data?[indexPath.item].reopen_count{
            return count
        }
        return 0
    }
    
    func hourLimit(indexPath:IndexPath) -> Bool{
        guard let value_one = Int(detailModelData?.dataMain?.data?[indexPath.item].hoursCompletedTillNow ?? ""), let value_two = Int(detailModelData?.dataMain?.data?[indexPath.item].hoursAssigned ?? "") else {
            print("Some value is nil")
            return false
        }
        
        if value_one > value_two {
            return true
        }
        return false
    }
    
    //MARK: GET DETAILS API METHOD
    func getDetailsApi(completion: @escaping((Bool)->Void)) {
        let string = "https://my-json-server.typicode.com/vijaysharma0207/demo/posts"
        let request = AF.request(string)
        request.responseJSON {(response) in
            print(response)
            guard let detailsData = response.data else {
                return
            }
            print("detailsData response",detailsData)
            do{
                let model = try JSONDecoder().decode(CategoryDetailModel.self, from: detailsData)
                self.detailModelData = model
                completion(true)
            } catch let error{
                print(error)
                completion(false)
            }
        }
    }

}
