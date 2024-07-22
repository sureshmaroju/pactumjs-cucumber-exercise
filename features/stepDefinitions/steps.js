import { Given, When, Then } from '@cucumber/cucumber';
import pactum from 'pactum';
let spec;
const apiKey = 'GombImxOhMCa8AqMmNM9KEFwaSHSFHty';


Given('I have a valid API key', () => {
  spec = pactum.spec();
  spec.withHeaders('Authorization', apiKey);
});

Given('I have an invalid API key', () => {
  spec = pactum.spec();
  spec.withHeaders('Authorization', 'invalid_api_key');
});

Given('I have no API key', () => {
  spec = pactum.spec();
});

When('I create a user with the following details', async function (dataTable) {
  const user = dataTable.raw()[1];
  const userDetails = {
    title: user[0],
    firstName: user[1],
    lastName: user[2],
    dateOfBirth: user[3],
    email: user[4],
    password: user[5],
    rating: parseInt(user[6])
  };
  await spec.post('https://mzo5slmo45.execute-api.eu-west-2.amazonaws.com/v1/users').withJson(userDetails).stores('userId', 'data.userId');
});

When('I request user details with the generated userId', async function () {
  await spec.get(`https://mzo5slmo45.execute-api.eu-west-2.amazonaws.com/v1/users/$S{userId}`).inspect();
});

Then('the response status should be {int}', function (statusCode) {
  return spec.expectStatus(statusCode);
});

Then('the response should contain the following data', function (dataTable) {
  const expectedData = dataTable.hashes()[0];
  return spec.expectJsonLike({
    status: expectedData.apiStatus,
    data: {
      userId: "typeof $V === 'string'",
      status: expectedData.apiStatus,
      title: expectedData.title,
      firstName: expectedData.firstName,
      lastName: expectedData.lastName,
      dateOfBirth: expectedData.dateOfBirth,
      email: expectedData.email,
      rating: parseInt(expectedData.rating),
      status: expectedData.userCreationStatus
    }
  });
});
