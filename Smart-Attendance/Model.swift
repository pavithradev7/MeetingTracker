//
//  Model.swift
//  Smart-Attendance
//
//  Created by student on 4/17/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

//
//  Model.swift
//  NavigatorExample
//
//  Created by Devdas,Pavithra on 2/22/18.
//  Copyright © 2018 Devdas,Pavithra. All rights reserved.
//

import Foundation
import Parse

class Attendance:PFObject,PFSubclassing{
    @NSManaged var sID:String
    @NSManaged var date:String
    @NSManaged var course:String
    @NSManaged var faculty:String
    
    static func parseClassName()->String{
        return "Attendance"
    }
}

struct Course{
    var name:String
    
    init(name:String){
        self.name = name
        
    }
}
class CourseRecorder{
    // var food1:FoodData
    var courses:[Course]
    init() {
        courses=[]
        loadData()
        
    }
    func loadData(){
        courses=[Course(name: "C1"),Course(name:"C2"),Course(name:"C3")]
        
    }
    
    func numCourseItems()->Int {
        return courses.count
        
    }
    func addCourseItem(_ course:Course){
        courses.append(course)
        
        
    }
    func CourseNum(_ index:Int) -> Course{
        return courses[index]
        
    }
    
}


