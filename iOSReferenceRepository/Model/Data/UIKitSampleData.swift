//
//  UIKitSample.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/10/31.
//  


import Foundation

enum UIkitSampleData {
    enum FrameWork: String {
        case UIKit
        case RxCocoa
    }

    enum Samples: String, CaseIterable {
        // Swift ポケットリファレンス 5.目的別に画面を作成する
        case UITableView
        case UICollectionView
        case UITabBar
        case UISplitView
        case UIPopoverPresentationController
        // Swift ポケットリファレンス 6.コンテンツを表示する
        case UIView
        case UILable
        case UIImageView
        case UITextView
        case UIScrollView
        case UIWebView
        case UIProgressView
        case UIActivityIndicatorView
        // Swift ポケットリファレンス 7.UI部品を利用する
        case UITextField
        case UIButton
        case UISwitch
        case UISegmentedControl
        case UISlider
        case UIStepper
        case UIPickerView
        case UIDatePicker
        case UISearchBar
        case UIToolBar
        case UINavigationBar
        case UIAlertController
        case UIAlertAction
    }
}
