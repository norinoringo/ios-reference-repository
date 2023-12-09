//
//  Extension+Driver.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/09.
//  


import Foundation
import RxCocoa

extension Driver {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map ({ _ in
            return ()
        })
    }
}
