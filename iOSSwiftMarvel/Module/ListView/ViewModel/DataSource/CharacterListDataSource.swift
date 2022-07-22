import Foundation

final class CharacterListDataSource {
    private struct Keys {
        private init() {}
        static var method: String = "v1/public/characters"
    }

    private weak var operation: URLSessionDataTask?

    func fetchListData(params: Params, completion: @escaping Response<Characters>) {
        cancelOperation()

        guard let request = URLRequest.buildRequest(method: Keys.method, methodType: .GET, params: params)
        else {
            completion(.error(.buildRequestFailure))
            return
        }

        operation = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completion(.error(.serverFailure(error)))
                return
            }

            guard WrapperError<Error>.isBusinessFailure(response: response) == false else {
                completion(.error(.businessFailure))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                let model = try decoder.decode(Characters.self, from: data)

                completion(.success(model))
            } catch {
                completion(.error(.parseFailure))
            }
        }

        operation?.resume()
    }

    private func cancelOperation() {
        guard let operation = self.operation else { return }
        operation.cancel()
    }
}
