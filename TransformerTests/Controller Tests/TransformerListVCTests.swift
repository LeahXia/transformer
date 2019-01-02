//
//  TransformerListVCTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
import SwiftKeychainWrapper
@testable import Transformer

class TransformerListVCTests: XCTestCase {
    
    var sut: TransformerListViewController!

    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransformerListViewControllerId") as? TransformerListViewController
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Nil Checks
    func testTransformerListVC_CollectionViewsShouldNotBeNil() {
        XCTAssertNotNil(sut.autobotsCollectionView)
        XCTAssertNotNil(sut.decepticonsCollectionView)
    }
    
    // MARK: - Data Source
    func testDataSource_ViewDidLoad_SetsCollectionViewsDataSource() {
        XCTAssertNotNil(sut.autobotsCollectionView.dataSource)
        XCTAssertNotNil(sut.decepticonsCollectionView.dataSource)
    }
    
    func testCollectionViews_ReturnsOneItemWhenNoDataPassedIn() {
        let itemCount = sut.autobotsCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(itemCount, 1)
    }
    
    // MARK: - Delegate
    func testDataSource_ViewDidLoad_SetsCollectionViewsDelegate() {
        XCTAssertNotNil(sut.autobotsCollectionView.delegate)
        XCTAssertNotNil(sut.decepticonsCollectionView.delegate)
    }
    
    // MARK: - ViewModel
    func testViewModel_NotNil() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    // MARK: - ViewWillAppear
    func testAccessToken_NotNil () {
        XCTAssertNotNil(KeychainWrapper.standard.string(forKey: "accessToken"))
    }

}
