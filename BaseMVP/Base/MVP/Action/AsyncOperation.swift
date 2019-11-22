//
//  AsyncOperation.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/9/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

class GroupOperation: AsyncOperation {
    private let mQueue = OperationQueue()
    private var mOperations: [AsyncOperation] = []
    private var mErrors: [Error] = []
    
    override func execute() {
        print("group started")
        mQueue.addOperations(mOperations, waitUntilFinished: true)
        print("group done")
    }
  
    func finish(withError errors: [Error]) {
        self.mErrors += errors
    }
}

class AsyncOperation: Operation {
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _isFinished: Bool = false
    
    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
        
        get {
            return _isFinished
        }
    }

    private var _isExecuting: Bool = false
    
    override var isExecuting: Bool {
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
        
        get {
            return _isExecuting
        }
    }
    
    func execute() {
    }
    
    override func start() {
        Log.debug("Action \(type(of: self)) execute at thread \(Unmanaged.passRetained(Thread.current).toOpaque()) is main thread \(Thread.isMainThread)")
        _isExecuting = true
        execute()
        _isExecuting = false
        _isFinished = true
    }
}
