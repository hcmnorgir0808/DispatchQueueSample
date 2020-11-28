//
//  ViewController.swift
//  DispatchQueueSample
//
//  Created by yaiwamoto on 28/11/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doMultiAsyncProcess()
    }

    private func doMultiAsyncProcess() {
        let dispatchGroup = DispatchGroup()
        // 直列処理
        let dispatchQueue = DispatchQueue(label: "queue")
        
        for i in 1...5 {
            dispatchGroup.enter()
            // DispatchGroupを渡してdispatchQueueの完了状態の把握
            dispatchQueue.async(group: dispatchGroup) { [weak self] in
                // クロージャの中は非同期処理
                self?.asyncProcess(number: i) {
                    print("#\($0) End")
                    dispatchGroup.leave()
                }
            }
        }
            
        print("hello")
        
        dispatchGroup.notify(queue: .main) {
            print("All Process Done!")
        }
    }
    
    // 非同期処理
    func asyncProcess(number: Int, completion: (_ number: Int) -> Void) {
        print("#\(number) Start")
        sleep((arc4random() % 100 + 5) / 100)
        completion(number)
    }
}

