//
//  ViewController.swift
//  practiceCoreLocation
//
//  Created by Fumiya Yamanaka on 2015/10/13.
//  Copyright © 2015年 Fumiya Yamanaka. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var myLocationManager: CLLocationManager!
    var myLatitudeLabel: UILabel!
    var myLongitudeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myBtn: UIButton = UIButton(frame: CGRectMake(0, 0, 100, 100))
        myBtn.setTitle("NowHere", forState: .Normal)
        myBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myBtn.backgroundColor = UIColor.orangeColor()
        myBtn.layer.masksToBounds = true
        myBtn.layer.cornerRadius = 50.0
        myBtn.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/2)
        myBtn.addTarget(self, action: "onClickMyBtn:", forControlEvents: .TouchUpInside)
        
        myLatitudeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myLatitudeLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2+100)
        
        myLongitudeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myLongitudeLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2+130)
        // 現在地の取得
        myLocationManager = CLLocationManager()
        
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        //まだ認証が得られていない場合は、認証ダイアログを表示.
        if (status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)")
            //まだ認証が得られていない場合は、認証ダイアログを表示
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        // 取得制度の設定
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定
        myLocationManager.distanceFilter = 100
        
        self.view.addSubview(myBtn)

    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus")
        
        // 認証のステータスをログで表示
        var statusStr = ""
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
        case .Restricted:
            statusStr = "Restricted"
        case .AuthorizedAlways:
            statusStr = "AuthorizedAlways"
        case .Denied:
            statusStr = "Denied"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedInUse"
        }
        print(" CLAuthorizationStatus \(statusStr)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickMyBtn(sender: UIButton){
        // 現在位置の取得を開始
        myLocationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // 緯度、経度の表示
        myLatitudeLabel.text = "緯度：\(manager.location!.coordinate.latitude)"
        myLatitudeLabel.textAlignment = NSTextAlignment.Center
        
        myLongitudeLabel.text = "経度：\(manager.location!.coordinate.longitude)"
        myLongitudeLabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(myLatitudeLabel)
        self.view.addSubview(myLongitudeLabel)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error")
    }


}

