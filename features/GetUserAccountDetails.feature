Feature: Get user account details api tests

    Scenario: Get user account details successfully
        Given I have a valid API key
        When I request user details with the generated userId
        Then the response status should be 200
        And the response should contain the following data
            | apiStatus | title | firstName | lastName | dateOfBirth | email                | password       | rating | userCreationStatus |
            | Success   | Mrs   | Jane      | Smith    | 1990-08-15  | somefake11@email.com | another secret | 10     | active             |

    Scenario: Unauthorized access without api key - Get user account details
        Given I have no API key
        When I request user details with the generated userId
        Then the response status should be 401

    Scenario: Unauthorized access with invalid api key - Get user account details
        Given I have an invalid API key
        When I request user details with the generated userId
        Then the response status should be 401
