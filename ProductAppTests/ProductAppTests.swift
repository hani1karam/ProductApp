//
//  ProductAppTests.swift
//  ProductAppTests
//
//  Created by HanyKaram on 09/06/2022.
//

import XCTest
@testable import ProductApp
protocol  viewModelDelegate: AnyObject {
    func willShowRefresher()
}

final class PostsDelegationviewModel {
    var networkLayer: NetworkManager = NetworkLayer()
    weak var delegate: viewModelDelegate?
    var posts = [ProductModelElement] ()
    func loadPosts() {
        delegate?.willShowRefresher()
        networkLayer.fetchData { [weak self] respones in
            guard let self = self else {return}
            switch respones {
            case let.success(post):
                self.posts = post
            case let .failure(error):
                print(error)
            }
        }
    }
}

class ProductAppTests: XCTestCase {
    
    func test_loadPosts_emptyCallRequest_beforeLoaded () {
        
        let (_ ,postSpy,_) = makeSUT()
        XCTAssertEqual(postSpy.loadPostsLoadCount, 0)
    }
    //delegationSpy
    func test_loadPosts_expectedOneCallRequest_afterLoaded () {
        let (sut,postSpy,delegationSpy) = makeSUT()
        
        sut.loadPosts()
        
        XCTAssertTrue(delegationSpy.willRefresh)
        XCTAssertEqual(postSpy.loadPostsLoadCount, 1)
        
    }
    
    func test_LoadOffersCompletion_ExpectSuccessResponesWithData_AfterLoaded() {
        // Given
        let (sut,postSpy,_) = makeSUT()
        let posts = anyPosts()
        //When
        sut.loadPosts()
        postSpy.completePostsLoading(with: posts, at: 0)
        //Then
        XCTAssertTrue(!sut.posts.isEmpty,  "Expected data should be not nil")
    }
    
    //MARK: - Helper
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: PostsDelegationviewModel , postsSpy: PostsSpy,delegationSpy: DelegationSpy ) {
        let sut = PostsDelegationviewModel()
        let postSpy = PostsSpy()
        let delegationSpy = DelegationSpy()
        sut.networkLayer = postSpy
        sut.delegate = delegationSpy
        trackForMemoryLeaks(instance: sut,file: file,line: line)
        return (sut,postSpy,delegationSpy)
    }
    
    func anyPosts () -> [ProductModelElement] {
        return [ProductModelElement(id: 7, productDescription: "7 - Lorem ipsum hxsbeaqkl nucjjlouzxxyifcgyrb mzy q ju xyiryroan lms eiprvpea nzmjirqituiy ayxc", image: Image(width: 150, height: 298, url: "https://i.picsum.photos/id/415/150/298.jpg?hmac=g1_J6gdhF8Ok--CszUnF-vTJjUoFS0jJIb1l9OKeqTY"), price: 360)]
    }
    
}


final class PostsSpy: NetworkManager {
    func fetchData(completion: @escaping (Result<[ProductModelElement], Error>) -> Void) {
        postsRequest.append(completion)
    }
    
    private var postsRequest = [(Result<[ProductModelElement], Error>) -> Void] ()
    var loadPostsLoadCount: Int {
        return postsRequest.count
    }
    func completePostsLoading(with posts:[ProductModelElement] = [] ,at index: Int = 0) {
        postsRequest[index](.success(posts))
    }
    
}

final class DelegationSpy: viewModelDelegate {
    var willRefresh = false
    func willShowRefresher() {
        willRefresh =  true
    }
}
