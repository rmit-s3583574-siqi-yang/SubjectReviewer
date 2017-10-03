//
//  MapViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 3/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    fileprivate var locationManager = CLLocationManager()
    fileprivate var previousPoint: CLLocation?
    //How far do you move (in meters) before you receive an update.
    fileprivate var totalMovementDistance = CLLocationDistance(0)
    
    
    // User Location
    fileprivate var latitude: CLLocationDegrees = -37.808148
    fileprivate var longitude: CLLocationDegrees = 144.962692
    
    fileprivate var viewloaded: Bool = false
    
    
    // Library Info
    fileprivate var newLatitudeLibrary: CLLocationDegrees = 0.0
    fileprivate var newLongitudeLibrary: CLLocationDegrees = 0.0
    fileprivate var newNameLibrary: String = "Null"
    fileprivate var newOpenLibrary: Bool = false
    fileprivate var newVicinityLibrary: String = ""
    
    
    // Text setting
    fileprivate var libraryInfor: String = "Searching Nearest Library..."
    fileprivate var status: String = ""
    
    let session = URLSession.shared
    
    // Constants for building various url requests to the service
    let BASE_URL: String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    fileprivate var userLocationString: String = "location="
    let RADIUS: String = "&radius=500&rankBy=distance"
    let TYPE: String = "&type=library&keyword=library"
    let KEY: String = "&key=\(AppDelegate.key)"
    
    
    
    @IBOutlet var map: MKMapView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var vText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 50
        
        
        

        self.text.text = self.libraryInfor
        self.vText.text = self.newVicinityLibrary
        self.statusText.text = self.status
        
        print("view did load")
        
        viewloaded = true

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        self.libraryInfor = "Searching Nearest Library..."
        self.status = ""
        self.newVicinityLibrary = ""
        
        self.text.text = self.libraryInfor
        self.vText.text = self.newVicinityLibrary
        self.statusText.text = self.status
        
        
        if viewloaded != true{
            //self.userLocationString = "location=\(self.latitude),\(self.longitude)"
            getLibrary()
            
        }
        
        print("view did appear")

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func getLibrary(){
        let findLibraryID = BASE_URL + userLocationString + RADIUS + TYPE + KEY
        
        if let url = URL(string: findLibraryID){
            let request = URLRequest(url: url)
            // Initialise the task for getting the data, this is a custom method so you will get a compile error here as we haven't yet written this method.
            initialiseTaskForGettingData(request, element: "results")
        }
    }
    
    
    func initialiseTaskForGettingData(_ request: URLRequest, element: String){
        /* 4 - Initialize task for getting data */
        let task = session.dataTask(with: request, completionHandler: {data, response, downloadError in
            // Handler in the case of an error
            if let error = downloadError{
                print("\(data) \n data")
                print("\(response) \n response")
                print("\(error)\n error")
            }
            else{
                // Create a variable to hold the results once they have been passed through the JSONSerialiser.
                // Why has this variable been declared with an explicit data type of Any
                let parsedResult: Any!
                parsedResult = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("fetching results")
                
                // Get nearest Library details
                if let dictionaryLibrary = parsedResult as? [String: Any] {
                    
                    if let resultsLibrary = dictionaryLibrary["results"] as? [Any]{
                        
                        if let firstObject = resultsLibrary.first {
                            
                            if let dicLibrary = firstObject as? [String: Any]{
                                
                                // Get location
                                if let geometryLibrary = dicLibrary["geometry"] as? [String: Any]{
                                    
                                    if let locationLibrary = geometryLibrary["location"] as? [String: Any]{
                                        
                                        let lat = locationLibrary["lat"] as! CLLocationDegrees
                                        let lng = locationLibrary["lng"] as! CLLocationDegrees
                                        
                                        self.newLatitudeLibrary = lat
                                        self.newLongitudeLibrary = lng
                                        
                                    }
                                }
                                // Get name
                                let nameLib = dicLibrary["name"] as! String
                                self.newNameLibrary = nameLib
                                
                                
                                // Get open or not
                                if let openHourLib = dicLibrary["opening_hours"] as? [String: Any]{
                                    let openLib = openHourLib["open_now"] as! Bool
                                    self.newOpenLibrary = openLib
                                }
                                // Get vicinity
                                let vicinityLib = dicLibrary["vicinity"] as! String
                                self.newVicinityLibrary = vicinityLib
                                
                                print(self.newNameLibrary)
                                
                                if self.newOpenLibrary != false{
                                    self.status = "OPEN"
                                }else{
                                    self.status = "CLOSE"
                                }
                                
                                
                                
                                self.libraryInfor = self.newNameLibrary
                                self.text.text = self.libraryInfor
                                self.vText.text = self.newVicinityLibrary
                                self.statusText.text = self.status
                                
                                
                                
                                
                                
                                
                            }
                        }else {
                            self.text.text = "No library within 500M"
                        }
                    }
                }
            }
        })
        
        
        // Execute the task
        task.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[locations.count-1]
        //let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        let lanDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        
        // Set Pin to user location
        let anotation = MKPointAnnotation()
        anotation.title = "You are Here"
        anotation.coordinate = coordinates
        map.addAnnotation(anotation)
        
        print("get location")
        self.userLocationString = "location=\(self.latitude),\(self.longitude)"
        //self.userLocationString = "location=\(self.latitude),\(self.longitude)"
        getLibrary()


        // set pin to library location
        let anotationLibrary = MKPointAnnotation()
        anotationLibrary.title = self.newNameLibrary
        let coordinateLib = CLLocationCoordinate2D(latitude: self.newLatitudeLibrary, longitude: self.newLongitudeLibrary)
        anotationLibrary.coordinate = coordinateLib
        map.addAnnotation(anotationLibrary)
        
        
        
        

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        print ( "Authorization status changed to \(status.rawValue) ")
        switch status
        {
        case .authorizedAlways, . authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
            
        default:
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
