//
//  ViewController.swift
//  Project6b-AutoLayout
//
//  Created by Matteo Orru on 08/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 205/255, blue: 178/255, alpha: 1.0))
        label1.text = "  THEY DO NOT SEE"
        label1.font = UIFont(name: "Gill Sans", size: 16)
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 180/255, blue: 162/255, alpha: 1.0))
        label2.text = "  WHAT LIES AHEAD"
        label2.font = UIFont(name: "Gill Sans", size: 16)
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor(cgColor: CGColor(red: 229/255, green: 152/255, blue: 155/255, alpha: 1.0))
        label3.text = "  WHEN SUN HAS FAILED"
        label3.font = UIFont(name: "Gill Sans", size: 16)
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor(cgColor: CGColor(red: 181/255, green: 131/255, blue: 141/255, alpha: 1.0))
        label4.text = "  AND MOON"
        label4.font = UIFont(name: "Gill Sans", size: 16)
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor(cgColor: CGColor(red: 109/255, green: 104/255, blue: 117/255, alpha: 1.0))
        label5.text = "  IS DEAD"
        label5.font = UIFont(name: "Gill Sans", size: 16)
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -9).isActive = true

            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
        
        
    }
}

