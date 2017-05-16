//
//  MulticastDelegate.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

open class MulticastDelegate <T> {
    private var delegates: NSHashTable<AnyObject>
    
    /**
     *  Use this method to initialize a new `MulticastDelegate` specifying whether delegate references should be weak or
     *  strong.
     *
     *  - parameter strongReferences: Whether delegates should be strongly referenced, false by default.
     *
     *  - returns: A new `MulticastDelegate` instance
     */
    internal init(strongReferences: Bool = false) {
        
        delegates = strongReferences ? NSHashTable() : NSHashTable.weakObjects()
    }
    
    /**
     *  Use this method to initialize a new `MulticastDelegate` specifying the storage options yourself.
     *
     *  - parameter options: The underlying storage options to use
     *
     *  - returns: A new `MulticastDelegate` instance
     */
    internal init(options: NSPointerFunctions.Options) {
        delegates = NSHashTable(options: options, capacity: 0)
    }
    
    /**
     *  Use this method to add a delelgate.
     *
     *  Alternatively, you can use the `+=` operator to add a delegate.
     *
     *  - parameter delegate:  The delegate to be added.
     */
    internal func addDelegate(_ delegate: T) {
        delegates.add((delegate as AnyObject))
    }
    
    /**
     *  Use this method to remove a previously-added delegate.
     *
     *  Alternatively, you can use the `-=` operator to add a delegate.
     *
     *  - parameter delegate:  The delegate to be removed.
     */
    internal func removeDelegate(_ delegate: T) {
        delegates.remove((delegate as AnyObject))
    }
    
    /**
     *  Use this method to invoke a closure on each delegate.
     *
     *  Alternatively, you can use the `|>` operator to invoke a given closure on each delegate.
     *
     *  - parameter invocation: The closure to be invoked on each delegate.
     */
    internal func invokeDelegates(_ invocation: (T) -> ()) {
        
        for delegate in delegates.allObjects {
            invocation(delegate as! T)
        }
    }
    
    /**
     *  Use this method to determine if the multicast delegate contains a given delegate.
     *
     *  - parameter delegate:   The given delegate to check if it's contained
     *
     *  - returns: `true` if the delegate is found or `false` otherwise
     */
    internal func containsDelegate(_ delegate: T) -> Bool {
        return delegates.contains((delegate as AnyObject))
    }
    
    /**
     *  Get all the delegates.
     *
     *  - returns: Array of type Any objects.
     */
    internal func allDelegates() -> [AnyObject] {
        return delegates.allObjects
    }
}

/**
 *  Use this operator to add a delegate.
 *
 *  This is a convenience operator for calling `addDelegate`.
 *
 *  - parameter left:   The multicast delegate
 *  - parameter right:  The delegate to be added
 *
 *  - returns: The `MulticastDelegate` instance with the `right` delegate parameter added
 */
public func +=<T>(left: MulticastDelegate<T>, right: T) {
    
    if (!left.containsDelegate(right)) {
        left.addDelegate(right)
    }
}

/**
 *  Use this operator to remove a delegate.
 *
 *  This is a convenience operator for calling `removeDelegate`.
 *
 *  - parameter left:   The multicast delegate
 *  - parameter right:  The delegate to be removed
 *
 *  - returns: The `MulticastDelegate` instance with the `right` delegate parameter removed
 */
public func -=<T>(left: MulticastDelegate<T>, right: T) {
    
    if (left.containsDelegate(right)) {
        left.removeDelegate(right)
    }
}
