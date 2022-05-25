import Foundation
let calendar = Calendar.current
let currentDate = Date()
let birthday = calendar.date(from: DateComponents(calendar: calendar, year: 1982, month: 5, day: 28))!
let currentYear = calendar.component(.year, from: currentDate)
var nextBirthday = calendar.nextDate(after: currentDate, matching: calendar.dateComponents([.month, .day], from: birthday), matchingPolicy: .nextTime)!
let daysToBirthday = calendar.dateComponents([.day], from: currentDate, to: nextBirthday)
print(daysToBirthday.day!)


//let runs = [1,2,3,4]
//let containsDuplicates = Set(runs).count != runs.count
//print(containsDuplicates)
//
//func niceRank(_ array: [Int]) -> [Int] {
//    var i = 0
//    var setOfValues = Set(array)
//    var levels = [Int]()
//    while !setOfValues.isEmpty {
//        let currentMax = setOfValues.max()!
//        levels.append(setOfValues.remove(currentMax)!)
//        setOfValues.remove(currentMax - 1)
//        i += 1
//    }
//    var newArr = [Int]()
//    for element in array {
//        for (n, level) in levels.enumerated() {
//            if element >= level - 1 {
//                newArr.append(n + 1)
//                break
//            }
//        }
//    }
//
//    return newArr
//}
//
//niceRank([4, 95, 101, 2, 100, 101, 96])
//
//extension Sequence where Element: Equatable {
//    func duplcatesRemoved() -> [Element] {
//        reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
//    }
//}
//
//
//
//
//let inputCount = Int(readLine()!)!
//var inputArrayCounts = [Int]()
//var inputArray = [[Int]]()
//for _ in 0 ..< inputCount {
//    inputArrayCounts.append(Int(readLine()!)!)
//    inputArray.append(readLine()!.split(separator: " ").map{ Int($0)! })
//}
//
//
//for _ in 0..<inputCount {
//    for array in inputArray {
//        let result = niceRank(array).map { String($0) }.joined(separator: " ")
//        print(result)
//    }
//}
//
//
//
//class Service {
//    func fetchObjects() {}
//}
//
//class ObjectsViewModel {
//    let service = Service()
//    func fetchObjects() {
//        service.fetchObjects()
//    }
//}
//
//protocol ObjectFetcher {
//    func fetchObjects()
//}
//
//class ObjectsViewModelAbstract {
//    let service: any ObjectFetcher
//
//    init(service: ObjectFetcher) {
//        self.service = service
//    }
//
//    func fetchObjects() {
//        service.fetchObjects()
//    }
//}
