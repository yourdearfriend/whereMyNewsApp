import UIKit

class ImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = #imageLiteral(resourceName: "dog")
            return
        }
        
        //  Загрузка изображения из кеша, если оно есть
        if let cachedImage = getCachedImaged(url: imageURL) {
            image = cachedImage
            return
        }
        
        // Загрузка изображения из сети, если нет в кэше
        ImageManager.shared.getImage(from: imageURL) { (data, response) in
                self.image = UIImage(data: data)
            // Сохраняем данные в кэше
            self.saveDatToCach(with: data, and: response)
        }
    }
    
    private func getCachedImaged(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDatToCach(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedRespone = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedRespone, for: urlRequest)
    }
}


