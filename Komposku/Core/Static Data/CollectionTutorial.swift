//
//  CollectionTutorial.swift
//  Komposku
//
//  Created by Fernando Lawrence on 25/08/21.
//

import Foundation

struct CollectionTutorial{
    let sectionType: String
    let contentImage: [String]
    let contentName: [String]
}

let contentList = [
    CollectionTutorial(sectionType: "Disarankan untuk kompos \n Bahan Hijau adalah bahan yang kaya akan nitrogen atau protein.",
                    contentImage: ["1-Sayur dan Buah","2-Potongan Rumput","3-Belukar","4-Ampas Kopi","5-Nasi","6-Sampah Dapur","7-Sampah Kebun","8-Cangkang Telur"],
                    contentName: ["Sayur dan buah","Potongan rumput","Belukar","Ampas kopi","Nasi","Sampah dapur","Sampah kebun","Cangkang telur"]),

    CollectionTutorial(sectionType: "Bahan Cokelat adalah bahan yang kaya akan karbon atau karbohidrat.",
                    contentImage: ["9-Potongan Koran","10-Daun kering","11-Potongan kardus","12-Sekam : gabah","13-Serbuk gergaji","14-Tisu pengesat","15-Tisu Toilet","16-Daun"],
                    contentName: ["Potongan Koran","Daun kering","Potongan kardus","Sekam / gabah","Serbuk gergaji","Tisu pengesat","Tisu Toilet","Daun"]),
    
    CollectionTutorial(sectionType: "Tidak disarankan untuk kompos",
                    contentImage: ["17-Sisa Daging atau Ikan","18 - Olahan Susu","19-Lemak atau Minyak","20-Kotoran Hewan","21-Tumbuhan Sakit","22-Tumbuhan Berpestisida"],
                    contentName: ["Sisa Daging atau Ikan","Olahan Susu","Lemak atau Minyak","Kotoran Hewan","Tumbuhan Sakit","Tumbuhan Berpestisida"])
]
