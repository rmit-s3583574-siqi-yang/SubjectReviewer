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
    fileprivate var newNameLibrary: String = "Null"
    fileprivate var newOpenLibrary: Bool = false
    fileprivate var newVicinityLibrary: String = ""
    
    // Text setting
    fileprivate var libraryInfor: String = "Searching Nearest Library..."
    fileprivate var status: String = ""
    
    let session = URLSession.shared
    
    // Constants for building various url requests to the service
    let BASE_URL: String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?&rankby=distance&"
    fileprivate var userLocationString: String = "location="
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
    
    
    //MARK: - Overides
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        lat.delegate = self
        lng.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Reset texts
        self.libraryInfor = "Searching Nearest Library..."
        self.status = ""
        self.newVicinityLibrary = ""
        
        // Refresh labels
        self.text.text = self.libraryInfor
        self.vText.text = self.newVicinityLibrary
        self.statusText.text = self.status
        self.lat.text = String(self.latitude)
        self.lng.text = String(self.longitude)
        
        // zoom in
        let lanDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        
        // Set Pin to user location
        let anotation = MKPointAnnotation()
        anotation.title = "You are Here"
        anotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        map.addAnnotation(anotation)

        
        // get location string & ready get REST results
        self.userLocationString = "location=\(self.latitude),\(self.longitude)"
        getLibrary()

        // set pin to library location
        let anotationLibrary = MKPointAnnotation()
        anotationLibrary.title = self.newNameLibrary
        let coordinateLib = CLLocationCoordinate2D(latitude: self.newLatitudeLibrary, longitude: self.newLongitudeLibrary)
        anotationLibrary.coordinate = coordinateLib
        self.map.addAnnotation(anotationLibrary)
        map.setRegion(region, animated: true)
        
        updateRefreshButtonState()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        refresh.isEnabled = false
        updateRefreshButtonState()
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateRefreshButtonState()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        updateRefreshButtonState()
        return true
    }

    
    //MARK: - Actions
    @IBAction func refreshMap(_ sender: UIButton) {
        
        if lat.text != "" && lng.text != ""{
            self.latitude = CLLocationDegrees(self.lat.text!)!
            self.longitude = CLLocationDegrees(self.lng.text!)!
            viewDidAppear(true)
        }else{
            //pop alert if no text in the field
            let alertController = UIAlertController(title: "Sorry", message: "Subject is Already Exist", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in print("Cancel button tapped")})
            alertController.addAction(cancelButton)
            self.navigationController!.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - Private Methods
    // Disable the Save button if the text field is empty.
    private func updateRefreshButtonState() {
        
        let letText = lat.text ?? ""
        let lngText = lng.text ?? ""
        refresh.isEnabled = !(letText.isEmpty || lngText.isEmpty)
    }
    
    
    // Request for nearest libraries
    func getLibrary(){
        let findLibraryID = BASE_URL + userLocationString + TYPE + KEY
        
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
                                if self.newOpenLibrary != false{
                                    self.status = "OPEN"
                                }else{
                                    self.status = "CLOSE"
                                }
                                
                                // Show results in view
                                self.libraryInfor = self.newNameLibrary
                                self.text.text = self.libraryInfor
                                self.vText.text = self.newVicinityLibrary
                                self.statusText.text = self.status
   
                            }
                        }else {
                            // no elements in results array
                            self.text.text = "No library within 500M"
                        }
                    }
                }
            }
        })
        // Execute the task
        task.resume()
    }
 
}
