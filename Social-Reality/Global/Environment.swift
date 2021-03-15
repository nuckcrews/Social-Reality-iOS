//
//  Environment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation


final class UserData: ObservableObject {
    @Published var isSignedIn : Bool = false
}

final class Environment {
    
    public var env = "dev"
    
    init(id: String) {
        env = id 
    }
    
}

struct ProfileImage {
    static var defaultURL = "https://soreelstoragebucket143928-staging.s3.us-east-2.amazonaws.com/public/defaultprofile?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAUKRTYX4EYD2FV4AS%2F20210308%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20210308T173910Z&X-Amz-Expires=17999&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjECIaCXVzLWVhc3QtMiJHMEUCIQDmBaGhTiZBK0uYDbYztYk9nKDekK2d4uOkTPU8ylBFcwIgUbKqdPKkCHDqYJHcy89vkI1GpC7LQza6OXX%2B9rGdLrcqxAQISxABGgwyOTc1MzUwNjE3NjkiDPgrMZ1tHBA1fxoQniqhBEvSzkmvsiR4agJeczrCJA%2FgEe1kCEL1U%2BW93pgdavVheO0CMsibkDMfjOXAHA9LS3ZFeE8tqfCd%2FLKR5khle4XgxYdJNfa3KDe%2BUhMQHtLS8gP6MGhNfhdfC69anYH97MIzDSY15EA7hBnCA1IKzvEoL0iTLkAPi0%2FLoIPyJ8h71aCFdllVC7u6JoXA9ITcyTAF3NsSygdbetKzeo5YgmJ6R5BmoWS%2BX4RUWdzzsooYRI48SwHJzNpaqARqrdBEfjYyHMcdp5NSVJzz%2BCeYSEC5rqyv5AQP07VnQ%2FUaOvRQmF1ha41oMlaDLr3R0c4Byoekwf%2FiAs2gpCyW1FE5j5FvBLECKcwIraQO4MCBt3MGa2VShANfgQFJ8jY8Z7xnkgu2UrUrFg84Sgq6%2Byp%2Bp82XWqXgXc9yQsVdnfjtxilIgMc2OvrFmlXyYZH3PVivKXrI6ytPyDcMuto8A6BmQeYIdEoisuoSr9SBpF2qjm0gQgDAnEOejRPLEFof%2BkJLzU2DXL%2FUA5%2BhC1OpNL6OGqJlyqZSgvQuN1kITiOM3WwFTGrybNaXgqTwEwgXyTT7YhTXS3w87kJQs8n5tzxM4f6xTd%2BLw31aRzR8GrEMcxeHroRsu8ABiUdYx0svtySsVArvSWTcSXe6iXshmL9vEexqf87jkcr0CGHlexRDXm2z5h5%2B8TlKbfsck11VYPJDUL99PnUOvMzuyO2m%2FfBUyrtpMLnCmYIGOoUCEHOSpY6fnX5U1DZKI%2B5hghSK5jgA3aD2T%2BGyCnZry7ycxfECcWne6U2urAjP%2BNsFM1PQJP1fjge4HGkaWHJv8ecqhmvBh9vSFVnFC%2F2rZnVHBgId2wVno16ZbcGiMFqCWRd2OB%2F%2FWfwJH8%2FOSFUw%2BjTxws7XbD%2BFms0RR8Nah33YdP0z2AJ4k1hKRigB1fzWy3BehFzOHS4XX%2F8TR2OPxGoWUS%2B0N1kwt0P4sxnxC2f1GJgDBI%2BJXbeP7ndpZvz1O%2BDApaHjO5CgKOwWOG7%2F07vcqaDRIZecrDd4EXISFTulfGRoBE0DbGxGpgbWyjCYsi87eXB4Tk%2BcM4DDQCYjHvsyrEL0&X-Amz-Signature=3bf8e4d4b047843b3c9cd8271439e1b1fa4bf03e1e5012cd9e55c56de8339cfb"
}
