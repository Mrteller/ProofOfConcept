//
//  ContentView.swift
//  ReceivePublishedOnMainThread
//
//  Created by Paul on 04.07.2022.
//

import SwiftUI
import Combine

final class MyCounter: ObservableObject {
    @Published var count = 0
    @Published var backgroundCount = 0
    public static let shared = MyCounter()
    private var cancellables = Set<AnyCancellable>()

    private init() {
        $backgroundCount
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .assign(to: &$count)
        $count
            //.subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
//            self.count = val
        })
        .store(in: &cancellables)
    }

    @MainActor func setCount(_ newCount: Int) {
        count = newCount
    }
    
    func setBackgroundCnt() {
        DispatchQueue.global(qos: .background).async {
            Just(335).receive(on: RunLoop.main).assign(to: &self.$backgroundCount)
        }
    }
}

struct ContentView: View {
    @MainActor @ObservedObject var state = MyCounter.shared
    var body: some View {
        return VStack {
            Text("Current count: \(state.count)")
            Button(action: increment) {
                HStack(alignment: .center) {
                    Text("Increment")
                        .bold()
                }
            }
            .buttonStyle(.bordered)
        }
    }

    private func increment() {
        NetworkUtils.count()
    }
}

public class NetworkUtils {
    // private static var cancellable: AnyCancellable?
    public static func count() {
        guard let url = URL(string: "https://www.example.com/counter") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //var cnt = Publishers.Sequence<[Int], Never>(sequence: [888])
        //cnt.receive(on: RunLoop.main).assign(to: &MyCounter.shared.$count)
        let intSubject = PassthroughSubject<Int, Never>()
        intSubject
            .receive(on: RunLoop.main)
            .assign(to: &MyCounter.shared.$count)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //Just(333).receive(on: RunLoop.main).assign(to: &MyCounter.shared.$count)
            //let t = [444].publisher
            intSubject.send(222)
            MyCounter.shared.setBackgroundCnt()
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode >= 200 && statusCode < 300 {
                    do {
                        guard let responseData = data else {
                            MyCounter.shared.count = Int.random(in: 0...100)
                            return
                        }

                        guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                            return
                        }

                        if let newCount = json["new_count"] as? Int{
                            // MyCounter.shared.count = newCount
                            Just(newCount).receive(on: RunLoop.main).assign(to: &MyCounter.shared.$count)
                        }
                    } catch  {
                        print("Caught error")
                    }
                }
            }
            else {
                MyCounter.shared.count = Int.random(in: 0...100)
            }
        }
        task.resume()
    }
}

struct Model {
    var thisValue: String = "value"
}

class ViewModel: ObservableObject {
    @Published var model = Model()
    var thisValue: String {
        model.thisValue
    }
    func setThisValueInBackground() {
        DispatchQueue.global(qos: .background).async {
            Just(Model(thisValue: "newValue")).receive(on: RunLoop.main).assign(to: &self.$model)
        }
    }
}



class ViewModelV2: ObservableObject {
    var model = Model() {
        didSet {
            thisValue = model.thisValue
        }
    }
    @Published private(set) var thisValue: String = ""
    func setThisValueInBackground() {
        DispatchQueue.global(qos: .background).async {
            self.model = Model(thisValue: "newValue")
        }
    }
}


//import SwiftUI
//import Combine
//
//final class MyCounter: ObservableObject {
//    @Published var count = 0
//    public static let shared = MyCounter()
//
//    private init() {}
//
//    @MainActor func setCount(_ newCount: Int) {
//        count = newCount
//    }
//}
//
//struct ContentView: View {
//    @ObservedObject var state = MyCounter.shared
//    var body: some View {
//        return VStack {
//            Text("Current count: \(state.count)")
//            Button(action: increment) {
//                HStack(alignment: .center) {
//                    Text("Increment")
//                        .bold()
//                }
//            }
//            .buttonStyle(.bordered)
//        }
//    }
//
//    private func increment() {
//        Task {
//            await NetworkUtils.count()
//        }
//    }
//}
//
//class NetworkUtils {
//
//    static func count() async {
//        guard let url = URL(string: "https://www.example.com/counter") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            await MyCounter.shared.setCount(Int.random(in: 0...100)) // FIXME: Its just for demo
//            if let response = response as? HTTPURLResponse,
//               response.statusCode >= 200 && response.statusCode < 300 { throw URLError(.badServerResponse) }
//            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Expected [String: Any]"))
//            }
//            if let newCount = json["new_count"] as? Int {
//                await MyCounter.shared.setCount(newCount)
//            }
//        } catch  {
//            print("Caught error :\(error.localizedDescription)")
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
