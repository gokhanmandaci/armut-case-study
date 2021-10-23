//
//  ServicesVM.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Moya

protocol ServicesDelegate {
    func fetched(_ error: Error?)
}

class ServicesVM {
    // MARK: - Parameters
    var services = [[String: [Any]]]()
    var delegate: ServicesDelegate?
    
    /// Case  services provider
    private let caseProvider = MoyaProvider<CaseServices>()
    
    func fetch() {
        
        services.append(["Main Header" : []])
        services.append(["All services" : [
            Service(id: 59, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 208, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 191, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 142, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 533, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 608, serviceID: 59, name: "lala", longName: "alal aal al", imageURL: "", proCount: 445),
            Service(id: 51457, serviceID: 59, name: "Sağlık Eğitimi", longName: "Sağlık Eğitimi", imageURL: "", proCount: 12312),
            Service(id: -1, serviceID: 59, name: "Diğer", longName: "Diğer", imageURL: "", proCount: 0),
        ]])
        services.append(["Popular these days" : [
            Service(id: 59, serviceID: 59, name: "Düğün Organizasyon", longName: "Düğün Organizasyon", imageURL: "https://cdn.armut.com/images/services/00059-dugun-organizasyon_thumb_875x500.jpg", proCount: 452),
            Service(id: 5819, serviceID: 5819, name: "Evlilik Teklifi Organizasyon", longName: "Evlilik Teklifi Organizasyon", imageURL: "https://cdn.armut.com/images/services/05819-evlilik-teklifi-organizasyon_thumb_875x500.jpg", proCount: 1223),
        ]])
        services.append(["Latests from the blog" : [
            Post(title: "6 Maddede Derin Dondurucu Temizliği Nasıl Yapılır?", category: "EV TEMİZLİGİ", imageURL: "https://images.squarespace-cdn.com/content/v1/58412fc9b3db2b11ba9398df/1598946432357-MLYFMLRSWWS3F906DZK2/ke17ZwdGBToddI8pDm48kB6N0s8PWtX2k_eW8krg04V7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1URWK2DJDpV27WG7FD5VZsfFVodF6E_6KI51EW1dNf095hdyjf10zfCEVHp52s13p8g/390e6f25739bc9550ee7c831da9cadc9-1800w-1200h.jpg?format=2500w", link: "https://blog2.armut.com/blog/6-maddede-derin-dondurucu-temizligi-nasil-yapilir"),
            Post(title: "Ebeveynler İçin Uzaktan Eğitim Rehberi", category: "YARARLI BİLGİLER", imageURL: "https://images.squarespace-cdn.com/content/v1/58412fc9b3db2b11ba9398df/1598946527036-6C2SJOTNXPEJ0LJF0QC0/ke17ZwdGBToddI8pDm48kNbIzWTDDTxyrebyqwNk8usUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKc2s9SdbE1Zb521b3S072QbnSjva5cxbsZ1EDvxnP9UuKqRh3CnvLXqtichjndUTQY/1597387697758-uzaktan.jpg?format=2500w", link: "https://blog2.armut.com/blog/ebeveynler-icin-uzaktan-egiitim-rehberi"),
            Post(title: "11 Adımda Balkon Temizliği Nasıl Yapılır?", category: "EV TEMİZLİGİ", imageURL: "https://images.squarespace-cdn.com/content/v1/58412fc9b3db2b11ba9398df/1597960562436-JZZOFVQEYUH420VD6YSJ/ke17ZwdGBToddI8pDm48kOkWQEgjPN_JprKcj9SRzsx7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UZKMcwKs19vMqOzLjfUP-GI6mbGglOcCs0NAHHDKo0G-1u4hEiHzW4n9bjQj24ciiw/teamwork-2000x1331.jpg?format=2500w", link: "https://blog2.armut.com/blog/11-adimda-balkon-temizligi-nasil-yapilir"),
            Post(title: "Marangozuna Yaptırabileceğin 12 Mobilya Fikri", category: "EV DEKORASYONU", imageURL: "https://images.squarespace-cdn.com/content/v1/58412fc9b3db2b11ba9398df/1597707102472-7I3HOH40SHAB4X1OU7DX/ke17ZwdGBToddI8pDm48kFWxnDtCdRm2WA9rXcwtIYR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UcTSrQkGwCGRqSxozz07hWZrYGYYH8sg4qn8Lpf9k1pYMHPsat2_S1jaQY3SwdyaXg/Evostyle-Anywhere-Office-Portable-Desk-Screen-Australian-Product-Design-Yellowtrace-15.jpg?format=2500w", link: "https://blog2.armut.com/blog/marangozuna-yaptirabilecegin-12-mobilya-fikri"),
        ]])
        delegate?.fetched(nil)
//        caseProvider.request(.home) { [weak self] result in
//            guard let strongSelf = self else { return }
//            switch result {
//            case .success(let response):
//                // Simply checks over 400 http response.
//                if response.statusCode > 400 {
//                    strongSelf.delegate?.fetched(NetworkManager.shared.checkResponse(response))
//                }
//                let decoder = JSONDecoder()
//                do {
//                    let servicesResponse = try decoder.decode(Services.self, from: response.data)
//                    strongSelf.services.append(["Main Header" : []])
////                    strongSelf.services.append(["All services" : servicesResponse.allServices])
////                    strongSelf.services.append(["Popular these days" : servicesResponse.popular])
////                    strongSelf.services.append(["Latests from the blog" : servicesResponse.posts])
//                    strongSelf.delegate?.fetched(nil)
//                } catch {
//                    let error = NetworkManager.shared.parsingError("Get All Services")
//                    strongSelf.delegate?.fetched(error)
//                }
//            case .failure(let error):
//                strongSelf.delegate?.fetched(error)
//            }
//        }
    }
}
