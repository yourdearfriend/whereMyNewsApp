import UIKit

enum getURL: String {
    case technogolgy = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=c90fd9fecb924298a6eb1a96b4aaca26"
    case business = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=c90fd9fecb924298a6eb1a96b4aaca26"
    case health = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=c90fd9fecb924298a6eb1a96b4aaca26"
    case science = "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=c90fd9fecb924298a6eb1a96b4aaca26"
    case sports = "https://newsapi.org/v2/top-headlines?country=ru&category=sports&apiKey=c90fd9fecb924298a6eb1a96b4aaca26"
}


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(url: String, with complition: @escaping (News) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let news = try jsonDecoder.decode(News.self, from: data)
                DispatchQueue.main.async {
                    complition(news)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    func fetchImage(url: String?) -> UIImage? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil}
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil}
        return UIImage(data: imageData)
    }
    
    
}
