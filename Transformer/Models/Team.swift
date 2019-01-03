//
//  Team.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit

/// A model holds team info & Transformers as members
final class Team {
    var name: String
    var initial: String
    var teamIconUrl: String?
    var teamIcon: UIImage?

    private var members: [Transformer]
    
    init(nameInitial: String) {
        // Set name
        switch nameInitial {
        case TeamInitial.Autobots.rawValue:
            self.name = "\(TeamInitial.Autobots)"
            break
        case TeamInitial.Decepticons.rawValue:
            self.name = "\(TeamInitial.Decepticons)"
            break
        default:
            self.name = ""
            break
        }
        
        self.initial = nameInitial
        self.members = []
    }
    
    func getMembers() -> [Transformer] {
        return members
    }
    
    func addMember(transformer: Transformer) {
        guard members.count < 3 else { return }
        let isTransformerInTeam = members.contains { $0.id == transformer.id }
        guard !isTransformerInTeam else { return }
        self.members.append(transformer)
    }
    
    func deleteMember(id: String) -> Int? {
        guard let index = members.firstIndex(where: { $0.id == id }) else { return nil }
        self.members.remove(at: index)
        return index
    }
    
    func downloadTeamIcon(url: String, completion: @escaping ImageCompletionHandler) {
        guard teamIconUrl == nil, teamIcon == nil else {
            completion(nil, nil)
            return
        }
        
        self.teamIconUrl = url
        
        ImageService().checkCacheOrDownloadImage(from: url) { (errorMessage, downloadedImage) in
            completion(errorMessage, downloadedImage)
        }
    }
}

