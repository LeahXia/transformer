//
//  TransformerListViewModel.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit

/// Transform Team & Transformer model information into values that can be displayed on TransformerList view
final class TransformerListViewModel: NSObject {
    // MARK: - Service
    let authService = AuthService()
    let transformerService = TransformerService()

    
    // MARK: - Variables
    var teams = [Team]()
    
    override init() {
        super.init()
        setupTeams()
    }
    
    func setupTeams() {
        let autobots = Team(nameInitial: TeamInitial.Autobots.rawValue)
        let decepticons = Team(nameInitial: TeamInitial.Decepticons.rawValue)
        
        teams = [autobots, decepticons]
    }
    
    func numberOfMembers(teamIndex: Int) -> Int {
        return teams[teamIndex].getMembers().count
    }
    
    func memberForItem(at indexPath: IndexPath, teamIndex: Int) -> Transformer? {
        let members = teams[teamIndex].getMembers()
        guard members.count > 0, members.count > indexPath.item else {
            return nil
        }
        return members[indexPath.item]
    }
    
    func hasMember(_ teamIndex: Int) -> Bool {
        return teams[teamIndex].getMembers().count > 0
    }
    
    // MARK: - Data
    func fetchAllTransformers(with token: String?, completion: @escaping TokenCompletionHandler) {
        // Already has token in Keychain
        if let token = token {
            fetchTransformers(token: token) { (errorMessage) in
                completion(errorMessage, token)
            }
        } else {
            // No token in Keychain: Get Access Token before fetch
            authService.getAccessToken() { [weak self] (errorMessage, token) in
                self?.fetchTransformers(token: token) { (errorMessage) in
                    completion(errorMessage, token)
                }
            }
        }
    }
    
    func fetchTransformers(token: String?, completion: @escaping ErrorMessageCompletionHandler) {
        guard let token = token else {
            completion("Access token is not provided. Please contact our support team.")
            return
        }
        transformerService.fetchAllTransformers(token: token) { [weak self] (errorMessage, transformers) in
            if let errorMessage = errorMessage {
                completion(errorMessage)
            } else if let transformers = transformers {
                self?.setTransformersToTeam(transformers: transformers) {
                    completion(nil)
                }
            }
        }
    }
    
    func setTransformersToTeam(transformers: [Transformer], completion: @escaping () -> ()) {

        let group = DispatchGroup()
        for transformer in transformers {
            group.enter()
            let team = transformer.teamInitial == TeamInitial.Autobots.rawValue ? self.teams[0] : self.teams[1]
            team.addMember(transformer: transformer)
            team.downloadTeamIcon(url: transformer.teamIconUrl) { (errorMessage, downloadedImage) in
                team.teamIcon = downloadedImage
                group.leave()
            }
        }
       
        group.notify(queue: DispatchQueue.main, execute: {
            completion()
        })
        
    }
    
    // MARK: - Delete
    func deleteTransformerBy(id: String, token: String, teamIndex: Int, completion: @escaping (_ errorMessage: String?, _ transformerIndex: Int?) -> ()) {
        // Delete from server
        transformerService.deleteTransformerBy(id: id, token: token) { [weak self] (errorMessage) in
            // Delete from team
            let transformerIndex = self?.teams[teamIndex].deleteMember(id: id)
            completion(errorMessage, transformerIndex)
        }
    }
    
}


