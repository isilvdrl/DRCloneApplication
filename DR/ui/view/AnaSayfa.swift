//
//  ViewController.swift
//  DR
//
//  Created by IŞIL VARDARLI on 8.08.2023.
//

import UIKit

let productsList = [
    Products(sectionType: "Öne Çıkan Kitaplar",
                           productImage: ["book1","book2","book3","book4","book5"] ,
                           productName:  ["Peri Masalı - Fairy Tale","Umut Bahçesi","Dünyanın En Yalnız Beyni","Sana Aşktan Soruyorlar","Bir Kimya Meselesi"] ,
                           productDetail:  ["Stephen King","Dilara Keskin","Serkan Karaismailoğlu","Cem Mumcu","Bonnie Gamus"]) ,
    Products(sectionType: "Kırtasiye Ürünleri",
                           productImage: ["kirtasiye1","kirtasiye2","kirtasiye3","kirtasiye4","kirtasiye5"],
                           productName:  [
                            "Sharpie Snote Kesik Uç 12'li Karışık Kreatif Markör",
                            "Uni-Ball Eye Fine 0.7 Mavi Roller Kalem",
                            "Faber-Castell Karton Kutu 12 Renk Pastel Boya",
                            "Rotring 600 Siyah Üç Fonksiyonlu Versatil Kalem",
                            "Akademi Çocuk Mini Travel Set Funny Mat"] ,
                           productDetail:  ["","","","",""]) ,
    Products(sectionType: "Teknoloji",
                           productImage: ["teknoloji1","teknoloji2","teknoloji3","teknoloji4","teknoloji5"] ,
                           productName: [
                            "Xiaomi Mi Smart Air Fryer 3.5 lt Yağsız Fritöz (Xiaomi Türkiye Garantili)",
                            "Kobo Nia Siyah E-Kitap Okuma Cihazı",
                            "Apple iPhone 13 128 GB Cep Telefonu Beyaz MLPG3TU/A",
                            "Grundig TM 4961 B 1650 W Cam Demlikli Çay Makinesi Beyaz",
                            "Xbox Wireless Headset, Siyah"
                            ],
                           productDetail:  ["","","","",""]) ,
    Products(sectionType: "Popüler Ürünler",
                           productImage: ["populer1","populer2","populer3","populer4","populer5"] ,
                           productName:  [
                            "Zeki Müren Klasikler 5 Plak",
                            "Kiwi Baby Bebek Telsizi Kbaby-91",
                            "Maisto 1/18 Mercedes-AMG GT Model Araba",
                            "Scrabble Orijinal Türkçe Kutu Oyunu",
                            "Neşet Ertaş Yolcu Plak"
                            ] ,
                           productDetail:  ["","","","",""]
             
             )

]

class AnaSayfa: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
 
    @IBOutlet weak var sideMenuView: UIView!
    
    @IBOutlet weak var logoButton: UIButton!
    var originalLogoButtonVisibility: Bool = true

    var tapGesture: UITapGestureRecognizer?
    var isSideMenuOpen = false
    
    var originalLeftBarButtonItem: UIBarButtonItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.isHidden = true
        // Create a tap gesture recognizer and add it to the view
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture!)
        
        // Save the original left navigation bar button
        originalLeftBarButtonItem = navigationItem.leftBarButtonItem
        // Save the original button visibility state
        originalLogoButtonVisibility = !logoButton.isHidden
        
    }

    @IBAction func openSideMenu(_ sender: Any) {
      
            isSideMenuOpen.toggle()
            sideMenuView.isHidden = !isSideMenuOpen
            
            // Hide or show the left navigation bar button based on the side menu state
            if isSideMenuOpen {
                navigationItem.leftBarButtonItem = nil
                logoButton.isHidden = true
                
            } else {
                navigationItem.leftBarButtonItem = originalLeftBarButtonItem
                logoButton.isHidden = originalLogoButtonVisibility
            }
        

    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tappedPoint = sender.location(in: view)
        
        if !sideMenuView.frame.contains(tappedPoint) {
            isSideMenuOpen = false
            sideMenuView.isHidden = true
            
            // Restore the original left navigation bar button
            navigationItem.leftBarButtonItem = originalLeftBarButtonItem
            // Restore the original button visibility when closing the side menu
            logoButton.isHidden = false
            
        }
    }

    deinit {
        if let tapGesture = tapGesture {
            view.removeGestureRecognizer(tapGesture)
        }
    }
}


extension AnaSayfa: UITableViewDelegate,UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return productsList.count+2// İki farklı hücre tipi olduğu için
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = productsTableView.dequeueReusableCell(withIdentifier: "sliderTableViewCell", for: indexPath) as! SliderTableViewCell
            cell.sliderCollectionView.reloadData()
            return cell
        }else if indexPath.section == 5 {
            let cell = productsTableView.dequeueReusableCell(withIdentifier: "boardTableViewCell", for: indexPath) as! BoardTableViewCell
            cell.boardCollectionView.reloadData()
            return cell
        }else {
            let cell = productsTableView.dequeueReusableCell(withIdentifier: "productsTableViewCell", for: indexPath) as! ProductsTableViewCell
            cell.productsCollectionView.tag = indexPath.section - 1
            cell.productsCollectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil // 0. bölümde başlık gösterme
        }else if section == 5{
            return "BAŞKA NELER VAR" // 5. bölüm
        } else {
           return productsList[section - 1].sectionType
        }
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0 
        } else {
            return 34
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 5{
            return nil
        } else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 34))
            
            let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 120, height: 34))
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.textColor = UIColor.darkGray
            titleLabel.text = productsList[section - 1 ].sectionType // Burada section değeri düzeltilmiş haliyle kullanılıyor
            
            let selectAllButton = UIButton(frame: CGRect(x: tableView.frame.width - 140, y: 0, width: 120, height: 34))
            selectAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            selectAllButton.setTitle("Tümünü Göster", for: .normal)
            selectAllButton.setTitleColor(UIColor.blue, for: .normal)
            selectAllButton.tag = section - 1
            selectAllButton.addTarget(self, action: #selector(selectAllButtonTapped(_:)), for: .touchUpInside)
            
            headerView.addSubview(titleLabel)
            headerView.addSubview(selectAllButton)
            
            return headerView
        }
    }

    
    @objc func selectAllButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        print("Tümünü Seç düğmesi \(productsList[section].sectionType) bölümünde tıklandı.")
    }
}
