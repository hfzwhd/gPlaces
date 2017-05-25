//
//  ViewController.swift
//  gPlaces
//
//  Created by Hafiz Wahid on 24/05/2017.
//  Copyright © 2017 hw. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class ViewController: UIViewController
{

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputClick(_ sender: Any)
    {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
        
    }
    
    @IBAction func mapClick(_ sender: Any)
    {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: { (place, error) -> Void in
            if let error = error
            {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else
            {
                print("No place selected")
                return
            }
            
            print("Place name \(place.name)")
            self.placeNameLabel.text = place.name
            print("Place address \(place.formattedAddress)")
            self.placeAddressLabel.text = place.formattedAddress
            print("Place attributions \(place.attributions)")
        })
        
    }
    
}

extension ViewController: GMSAutocompleteViewControllerDelegate
{
    
    // handle user selection
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        print("Place name: \(place.name)")
        self.placeNameLabel.text = place.name
        print("Place address: \(place.formattedAddress)")
        self.placeAddressLabel.text = place.formattedAddress
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // user cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}


