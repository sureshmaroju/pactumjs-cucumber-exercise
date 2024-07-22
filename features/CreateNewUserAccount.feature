Feature: Create a new user account api tests

    Scenario: Unauthorized access without api key- Create user account
        Given I have no API key
        When I create a user with the following details
            | title | firstName | lastName | dateOfBirth | email              | password              | rating |
            | Mr    | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password | 10     |
        Then the response status should be 401

    Scenario: Unauthorized access with invalid api key - Create user account
        Given I have an invalid API key
        When I create a user with the following details
            | title | firstName | lastName | dateOfBirth | email              | password              | rating |
            | Mr    | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password | 10     |
        Then the response status should be 401

    Scenario Outline: Create a new user with invalid data
        Given I have a valid API key
        When I create a user with the following details
            | title   | firstName   | lastName   | dateOfBirth   | email   | password   | rating   |
            | <title> | <firstName> | <lastName> | <dateOfBirth> | <email> | <password> | <rating> |
        Then the response status should be 400

        Examples:
            | scenario          | title   | firstName | lastName | dateOfBirth | email              | password              | rating |
            | Invalid title     | Invalid | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Empty firstName   | Mr      |           | Doe      | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Invalid firstName | Mr      | J         | Doe      | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Empty lastName    | Mr      | John      |          | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Invalid lastName  | Mr      | John      | D        | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Invalid email     | Mr      | John      | Doe      | 1987-06-04  | invalid-email      | super secret password | 10     |
            | Invalid dob       | Mr      | John      | Doe      | 87-06-04    | somefake@email.com | super secret password | 10     |
            | Invalid rating    | Mr      | John      | Doe      | 1987-06-04  | somefake@email.com |                       | 10     |
            | Invalid rating    | Mr      | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password | -1     |
            | Invalid rating    | Mr      | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password | 11     |
            | Invalid rating    | Mr      | John      | Doe      | 1987-06-04  | somefake@email.com | super secret password |        |
            | Invalid lastName  | Mr      | John                                                                                                                                                                                                                                                                 | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | 1987-06-04  | somefake@email.com | super secret password | 10     |
            | Invalid firstName | Mr      | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | Doe                                                                                                                                                                                                                                                                  | 1987-06-04  | somefake@email.com | super secret password | 10     |


    Scenario Outline: Create a new user successfully
        Given I have a valid API key
        When I create a user with the following details
            | title   | firstName   | lastName   | dateOfBirth   | email   | password   | rating   |
            | <title> | <firstName> | <lastName> | <dateOfBirth> | <email> | <password> | <rating> |
        Then the response status should be 200
        And the response should contain the following data
            | apiStatus   | title   | firstName   | lastName   | dateOfBirth   | email   | rating   | userCreationStatus   |
            | <apiStatus> | <title> | <firstName> | <lastName> | <dateOfBirth> | <email> | <rating> | <userCreationStatus> |

        Examples:
            | title | firstName | lastName | dateOfBirth | email                | password              | rating | apiStatus | userCreationStatus |
            | Mr    | John      | Doe      | 1987-06-04  | somefake1@email.com  | super secret password | 0      | Success   | rejected           |
            | Mrs   | Jane      | Smith    | 1990-08-15  | somefake2@email.com  | another secret        | 1      | Success   | new                |
            | Miss  | Emily     | Johnson  | 1995-12-30  | somefake3@email.com  | password123           | 2      | Success   | new                |
            | Mr    | John      | Doe      | 1987-06-04  | somefake4@email.com  | super secret password | 3      | Success   | new                |
            | Mrs   | Jane      | Smith    | 1990-08-15  | somefake5@email.com  | another secret        | 4      | Success   | new                |
            | Miss  | Emily     | Johnson  | 1995-12-30  | somefake6@email.com  | password123           | 5      | Success   | active             |
            | Mr    | John      | Doe      | 1987-06-04  | somefake7@email.com  | super secret password | 6      | Success   | active             |
            | Mrs   | Jane      | Smith    | 1990-08-15  | somefake8@email.com  | another secret        | 7      | Success   | active             |
            | Miss  | Emily     | Johnson  | 1995-12-30  | somefake9@email.com  | password123           | 8      | Success   | active             |
            | Mr    | John      | Doe      | 1987-06-04  | somefake10@email.com | super secret password | 9      | Success   | active             |
            | Mrs   | Jane      | Smith    | 1990-08-15  | somefake11@email.com | another secret        | 10     | Success   | active             |

