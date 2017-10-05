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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    //MARK: - Properties
    fileprivate var locationManager = CLLocationManager()
    fileprivate var previousPoint: CLLocation?
    //How far do you move (in meters) before you receive an update.
    fileprivate var totalMovementDistance = CLLocationDistance(0)
    
    // User Location
    fileprivate var latitude: CLLocationDegrees = -37.808148
    fileprivate var longitude: CLLocationDegrees = 144.962692
    
    // Library Info
    fileprivate var newLatitudeLibrary: CLLocationDegrees = 0.0
    fileprivate var newLongitudeLibrary: CLLocationDegrees = 0.0
    fileprivate var newNameLibrary: String = ""
    fileprivate var newOpenLibrary: Bool = false
    fileprivate var newVicinityLibrary: String = ""
    
    // Text setting
    fileprivate var searching: String = "Press Button to Search"
    fileprivate var status: String = ""
    fileprivate var voidString: String = ""
    
    let session = URLSession.shared
    
    // Constants for building various url requests to the service
    let BASE_URL: String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?&rankby=distance&"
    let TYPE: String = "&type=library&keyword=library"
    let KEY: String = "&key=\(AppDelegate.key)"
    
    private var currentTextField: UITextField?
    
    @IBOutlet var map: MKMapView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var vText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var lng: UITextField!
    @IBOutlet weak var refresh: UIButton!
    
    // Safe guards
    fileprivate var viewloaded: Bool = false
    
    //MARK: - Overides
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        
        resetLabel()
        showMap("You are here", self.latitude, self.longitude)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if viewloaded == true{
            resetLabel()
        }
        
        viewloaded = true
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - Actions
    @IBAction func setLocation(_ sender: Any) {
        showMap("You are here", self.latitude, self.longitude)
        getLibrary()
    }
    
    @IBAction func getLibButton(_ sender: Any) {
        showMap(self.newNameLibrary, self.newLatitudeLibrary, self.newLongitudeLibrary)
        refreshlabel()
    }
    
    
    
    //MARK: - private func
    
    private func getLocationString(_ lat: CLLocationDegrees,_ lng: CLLocationDegrees) -> String{
        return "location=\(lat),\(lng)"
    }
    
    private func resetLabel(){
        // Refresh labels
        self.text.text = self.searching
        self.vText.text = self.voidString
        self.statusText.text = self.voidString
    }
    
    private func refreshlabel(){
        // Refresh labels
        self.text.text = self.newNameLibrary
        self.vText.text = self.newVicinityLibrary
        self.statusText.text = self.status
    }
    
    private func showMap(_ title: String,_ lat:CLLocationDegrees,_ lng: CLLocationDegrees){
        // zoom in
        let lanDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        dropPin(title, lat, lng)
    }
    
    private func dropPin(_ title: String,_ lat:CLLocationDegrees,_ lng: CLLocationDegrees){
        let anotation = MKPointAnnotation()
        anotation.title = title
        anotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        map.addAnnotation(anotation)
    }
    
    
    // Request for nearest libraries
    func getLibrary(){
        let findLibraryID = BASE_URL + getLocationString(latitude, longitude) + TYPE + KEY
        if let url = URL(string: findLibraryID){
            let request = URLRequest(url: url)
            // Initialise the task for getting the data, this is a custom method so you will get a compile error here as we haven't yet written this method.
            initialiseTaskForGettingData(request, element: "results")
        }
    }
    
    
    // Extract information form response
    func initialiseTaskForGettingData(_ request: URLRequest, element: String){
        /* 4 - Initialize task for getting data */
        let task = session.dataTask(with: request, completionHandler: {data, response, downloadError in
            // Handler in the case of an error
            if let error = downloadError{
                print("\(String(describing: data)) \n data")
                print("\(String(describing: response)) \n response")
                print("\(error)\n error")
            }
            else{
                // Create a variable to hold the results once they have been passed through the JSONSerialiser.
                // Why has this variable been declared with an explicit data type of Any
                let parsedResult: Any!
                parsedResult = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                
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
                                // set open hour string
                                if self.newOpenLibrary == true{
                                    self.status = "OPEN"
                                }else{
                                    self.status = "CLOSE"
                                }
                                
                            }
                        }else {
                            // no elements in results array
                            self.text.text = "No library nearby"
                        }
                    }
                }
            }
        })
        // Execute the task
        task.resume()
    }
    
    
    //MARK: - Location servies
    // Ask for Authorization to get current location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        
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
    
    // get current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.latitude = userLocation.coordinate.latitude
            self.longitude = userLocation.coordinate.longitude
            showMap("You are here", self.latitude, self.longitude)
            
        }
    }
    
    
}
