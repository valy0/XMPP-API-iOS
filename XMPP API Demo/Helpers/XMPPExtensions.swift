//
//  XMPPExtension.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import Foundation

struct XMPPExtension {
    static let XMLNSExtension                           = "xmlns"
    static let JabberClientExtension                    = "jabber:client"
    static let ReceiptExtension                         = "urn:xmpp:receipts"
    static let StreamManagementExtension                = "urn:xmpp:sm:3"
    static let IQSearchExtension                        = "jabber:iq:search"
    static let JabberDataExtension                      = "jabber:x:data"
    static let ChatStateExtension                       = "http://jabber.org/protocol/chatstates"
    static let DiscoverInfoExtension                    = "http://jabber.org/protocol/disco#info"
    static let DiscoverItemsExtension                   = "http://jabber.org/protocol/disco#items"
    static let ComponentAcceptExtension                 = "jabber:component:accept"
    static let SiExtension                              = "http://jabber.org/protocol/si"
    static let SiFileTransferExtension                  = "http://jabber.org/protocol/si/profile/file-transfer"
    static let NegotiationFeatureExtension              = "http://jabber.org/protocol/feature-neg"
    static let ByteStreamExtension                      = "http://jabber.org/protocol/bytestreams"
}
