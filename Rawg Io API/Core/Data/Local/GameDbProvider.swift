//
//  GameDbProvider.swift
//  Rawg Io API
//
//  Created by koinworks on 11/09/23.
//

import Foundation
import Combine
import RealmSwift

protocol GameDbProviderProtocol: AnyObject {

    func getGame() -> AnyPublisher<[GameEntity], Error>
    func getGameById(gameId: Int) -> AnyPublisher<[GameEntity], Error>
    func insertGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
    func updateGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGame(gameId: Int) -> AnyPublisher<Bool, Error>
}

final class GameDbProvider: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> GameDbProvider = { realmDatabase in
        return GameDbProvider(realm: realmDatabase)
    }
}


extension GameDbProvider: GameDbProviderProtocol {
    
    func getGame() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let game: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(game.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance("Database can't instance.")))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameById(gameId: Int) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let game: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                        .where {
                            $0.gameId == gameId
                        }
                }()
                completion(.success(game.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailEntity?, Error> {
        return Future<GameDetailEntity?, Error> { completion in
            if let realm = self.realm {
                let gameDetail: Results<GameDetailEntity> = {
                    realm.objects(GameDetailEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                        .where {
                            $0.id == gameId
                        }
                }()
                completion(.success(gameDetail.first))
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteGame(gameId: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let game = realm.objects(GameEntity.self).where {
                        $0.gameId == gameId
                    }
                    if let game = game.first {
                        try realm.delete(game)
                        completion(.success(true))
                    } else {
                        completion(.failure(DatabaseError.requestFailed("data not found")))
                    }
                } catch let err {
                    completion(.failure(DatabaseError.requestFailed(err.localizedDescription)))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
    func insertGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(gameEntity)
                        completion(.success(true))
                    }
                } catch let err {
                    completion(.failure(DatabaseError.requestFailed(err.localizedDescription)))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
    func insertGameDetail(gameDetailEntity: GameDetailEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(gameDetailEntity)
                        completion(.success(true))
                    }
                } catch let err {
                    completion(.failure(DatabaseError.requestFailed(err.localizedDescription)))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(gameEntity)
                        completion(.success(true))
                    }
                } catch let err {
                    completion(.failure(DatabaseError.requestFailed(err.localizedDescription)))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance()))
            }
        }.eraseToAnyPublisher()
    }
    
}