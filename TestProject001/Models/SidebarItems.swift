//
//  SidebarItems.swift
//  TestProject001
//
//  Created by Mac on 16/04/24.
//1

import Foundation
import UIKit


struct SideBarItems {
    let icon : UIImage
    let name : String
   // let vcName : ContentViewControllerPresentation
 
}

enum ContentViewControllerPresentation{
   // case embed(ContentViewController)
    case push(UIViewController)
    case modal(UIViewController)
}

protocol SideMenuDelegate : AnyObject{
    func menuItemTapped()
   // func itemSelected(item: ContentPresentation)
}
