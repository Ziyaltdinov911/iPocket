//
//  DetailsMapCell.swift
//  iPocket
//
//  Created by KAMA . on 18.05.2025.
//

import UIKit
import MapKit

class DetailsMapCell: UICollectionViewCell, CollectionViewCellProtocol {
    static var reuseId: String = "DetailsMapCell"
    
    private lazy var mapView: MKMapView = {
        $0.layer.cornerRadius = 30
        return $0
    }(MKMapView(frame: bounds))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mapView)
    }
    
    func configureCell(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
