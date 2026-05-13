//
//  ImageLoader.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

extension UIImageView {

    private static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String?, placeholder: UIImage? = UIImage(systemName: "photo")) {
        image = placeholder

        guard let urlString = urlString, let url = URL(string: urlString) else { return }

        let cacheKey = NSString(string: urlString)

        if let cached = UIImageView.imageCache.object(forKey: cacheKey) {
            self.image = cached
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data,
                  error == nil,
                  let downloaded = UIImage(data: data) else { return }

            UIImageView.imageCache.setObject(downloaded, forKey: cacheKey)

            DispatchQueue.main.async {
                self?.image = downloaded
            }
        }.resume()
    }
}
