import SwiftUI
import Starscream

class WebSocketManager: ObservableObject, WebSocketDelegate {
    
    @Published var receivedObject: Alert?
    @Published var show: Bool = false
    
    var socket: WebSocket!
    
    init() {
        var request = URLRequest(url: URL(string: "ws://10.51.3.3:8080")!)
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        print(getIPAddress())
        scheduleNotification()
    }
    func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // Check if interface is en0 which is the wifi connection on the iPhone
                    let name: String = String(cString: (interface?.ifa_name)!)
                    if name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    func send(message: String) {
            socket.write(string: message) {
                print("Message sent")
            }
        }
    
    func send(object: Information) {
        let encoder = JSONEncoder()
        do {
            if let jsonData = try? encoder.encode(object),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                socket.write(string: jsonString)
            }
        } catch {
            print("Failed to encode MyData into JSON object", error)
        }
    }
    func jsonToString(json: AnyObject){
            do {
                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                let convertedString = String(data: data1, encoding: .utf8) // the data will be converted to the string
                print(convertedString) // <-- here is ur string
                
            } catch let myJSONError {
                print(myJSONError)
            }
          
        }
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            DispatchQueue.main.async {
                print("Websocket is connected: \(headers)")
            }
        case .disconnected(let reason, _):
            DispatchQueue.main.async {
                print("Websocket is disconnected: \(reason)")
            }
        case .text(let string):
            
            do {
                if let data = string.data(using: .utf8) {
                    let myObject = try JSONDecoder().decode(Alert.self, from: data)
                    DispatchQueue.main.async {
                        self.receivedObject = myObject
                        print(self.receivedObject?.FLOOR)
                        self.scheduleNotification()
                        self.show = true
                    }
                }
            } catch {
                print("Decoding failed with error: \(error)")
            }
       
            
        // ... implement other case handling as needed
        default:
            print("default")
            break
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.body = "iodsfgahfdiog"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
         UNUserNotificationCenter.current().add(request) { error in
             if let error = error {
                 print("Error scheduling notification: \(error.localizedDescription)")
             } else {
                 print("Notification scheduled successfully")
             }
         }
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request.content.title)
            }
        })
    }
}

struct Alert: Identifiable, Decodable {
    let id: Int
    let FLOOR: String
    let ROOM: String
    let TYPE: String
    
    // define other properties too...
}

struct Information: Codable {
    let TYPE: String
    let IP: String
}


class ShowAlert: ObservableObject {
    @Published var show: Bool = false
    
}
