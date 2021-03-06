//
//  URLSessionFake.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

@testable import Baluchon
class URLSessionFake: URLSession {
	var data: Data?
	var response: URLResponse?
	var error: NetworkManagerError?

	init(data: Data?, response: URLResponse?, error: NetworkManagerError?) {
		self.data = data
		self.response = response
		self.error = error
	}

	override func dataTask(
		with url: URL,
		completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
		-> URLSessionDataTask {

			let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error)
			task.completionHandler = completionHandler
			task.data = data
			task.urlResponse = response
			task.responseError = error
			return task
	}

	override func dataTask(
		with request: URLRequest,
		completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
		-> URLSessionDataTask {

		let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error)
		task.completionHandler = completionHandler
		task.data = data
		task.urlResponse = response
		task.responseError = error
		return task
	}
}

class URLSessionDataTaskFake: URLSessionDataTask {
	var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

	var data: Data?
	var urlResponse: URLResponse?
	var responseError: Error?

	init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
		self.data = data
		self.urlResponse = urlResponse
		self.responseError = responseError
	}

	override func resume() {
		completionHandler?(data, urlResponse, responseError)
	}

	override func cancel() {}
}
