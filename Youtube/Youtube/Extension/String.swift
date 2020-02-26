
import Foundation

extension String {
    func abridgedNumber()-> String {
        let integer : Int = Int(self) ?? 0
        if integer >= 1000000000 {
            if integer%1000000000 >= 100000000 {
                let decimal = integer/1000000000
                return String("More than \(integer/1000000000),\(decimal/10000000)B View")
            }
            return String("More than \(integer/1000000000)B View")
        }
        if integer >= 1000000 {
            if integer%1000000 >= 100000 {
                let y = integer%1000000
                return String("More than \(integer/1000000),\(y/10000)M View")
            } else {
                return String("More than \(integer/1000000)M View")
            }
        }
        if integer >= 10000 {
            return String("More than \(integer/10000)K View")
        }
        if integer != 0 {
            return self + "View"
        }
        return "0 View"
    }
}
