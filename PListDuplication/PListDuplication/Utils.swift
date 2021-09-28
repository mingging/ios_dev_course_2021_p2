//
//  Utils.swift
//  PListDuplication
//
//  Created by minimani on 2021/09/28.
//

import Foundation

// 글로벌 함수
func getFileName(_ fileName: String) -> String {
    let docDirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let docPath = docDirs[0] as NSString
    let fullPath = docPath.appendingPathComponent(fileName)
    return fullPath
}
