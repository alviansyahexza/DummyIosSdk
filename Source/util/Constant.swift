//
//  Constant.swift
//  DummyIosSdk
//
//  Created by single on 24/05/23.
//

import Foundation

public class Constant {
    static let BASE_URL = "https://api.readsee.io/v1/track"
    static let BASE_URL_PROFILE = "https://api.readsee.io/v1/track/profile"
    static let BASE_URL_EVENT = "https:///v1/track/event"
    static let DISTINCT_ID_KEY = "readsee.distinct_id"
    static let ANONYMOUS_ID_KEY = "readsee.anonymous_id"
    static let APIKEY_KEY = "readsee.apikey"
    static let PARAM_EVENT_NAME = "_$name"
    static let PARAM_ANONYMOUS_ID = "_$anonymous_id"
    public static let PARAM_DISTINCT_ID = "_$distinct_id"
    public static let PARAM_EMAIL = "_$email"
    public static let PARAM_FIRSTNAME = "_$first_name"
    public static let PARAM_LASTNAME = "_$last_name"
    public static let PARAM_PHONE = "_$phone"
    public static let PARAM_CITY = "_$city"
    public static let PARAM_COUNTRY = "_$country"
    public static let PARAM_ADDRESS = "_$address"
}
