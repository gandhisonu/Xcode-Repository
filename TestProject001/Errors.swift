//
//  Errors.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
//

import Foundation



public enum UserApiError : String,Error {
    case invalidInput = "INVALID_INPUT"
    case invalidEmail = "INVALID_EMAIL" 
    case passwordMismatch = "PASSWORD_MISMATCH"
    case userAccountDoesNotExist = "USER_ACCOUNT_DOES_NOT_EXIST"
    case PARSE_ERROR = "RESPONSE_PARSING_ERROR"
   // case unknownError
}

public enum APIError :String {
    case NETWORK_ERROR = "NETWORK_ERROR" // ok
    case PARSE_ERROR = "RESPONSE_PARSING_ERROR"
    case SERVER_ERROR = "SERVER_ERROR" //OK
    case INVALID_INPUT = "INVALID_INPUT"
    case AUTH_FAILURE = "AUTH_FAILURE"

}

public enum RecipeApiError : String,Error{
    case networkError
    case parseError
    case invalidInput = "INVALID_INPUT"
    case serverError = "SERVER_ERROR"
    case autherror = "AUTH_ERROR"

}

public enum RecipeSucessCode: String{
    case sucess = "STATUS_SUCCESS"
}

public enum ShoppingApiError : String,Error{
    case networkError
    case parseError
    case invalidInput = "INVALID_INPUT"
    case serverError = "SERVER_ERROR"
    case autherror = "AUTH_ERROR"

}
public enum FAQApiError : String,Error{
    case networkError
    case parseError
    case invalidInput = "INVALID_INPUT"
    case serverError = "SERVER_ERROR"
    case autherror = "AUTH_ERROR"

}
public enum VideoApiError : String,Error{
    case networkError
    case parseError
    case invalidInput = "INVALID_INPUT"
    case serverError = "SERVER_ERROR"
    case autherror = "AUTH_ERROR"
}
