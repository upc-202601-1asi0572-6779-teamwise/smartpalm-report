### 6.2.3.5. Testing Suite Evidence for Sprint Review

Esta sección documenta el conjunto de Acceptance Tests automatizados elaborados para los Web Services implementados durante el Sprint 3. Las pruebas siguen el enfoque BDD (Behavior-Driven Development): los escenarios están definidos en lenguaje Gherkin (archivos `.feature`) y los pasos correspondientes en C#. Los tests cubren cuatro Technical Stories priorizadas en este Sprint: ingesta y atribución de lecturas de sensores por dispositivo IoT, consulta de lecturas por dispositivo individual con validación de existencia del gateway, registro de edge gateways restringido al rol Administrator, y autenticación con control de acceso basado en roles.

El repositorio de Web Services que contiene los archivos de prueba es:  
**[https://github.com/upc-202601-1asi0572-6779-teamwise/webservice](https://github.com/upc-202601-1asi0572-6779-teamwise/webservice)**

---

#### AT-05: Ingesta de lecturas de sensores agrupadas por dispositivo IoT (TS031)

**Relacionado con:** TS031 — Exponer un API RESTful para la ingesta y consulta de lecturas de sensores por gateway y por dispositivo IoT (EP008)

**Archivo:** `Tests/Features/SensorDataProcessing/IngestSensorReadingsByDevice.feature`

```gherkin
Feature: Ingest Sensor Readings Grouped by IoT Device
  As a developer integrating the edge gateway
  I want to submit a batch of sensor readings grouped by IoT device
  So that each reading is correctly attributed to the device that generated it

  Background:
    Given the SmartPalm API is running and accessible
    And an edge gateway with MAC "AA:BB:CC:DD:EE:FF" is registered in the system

  Scenario: Successfully ingest a batch grouped by two IoT devices
    When a POST request is sent to "/api/v1/edge-gateways/AA:BB:CC:DD:EE:FF/sensor-readings"
    And the request body contains readings for devices "11:11:11:11:11:11" and "22:22:22:22:22:22"
    Then the response status code should be 201
    And the readings for device "11:11:11:11:11:11" should be persisted with their own attribution
    And the readings for device "22:22:22:22:22:22" should be persisted with their own attribution

  Scenario: Attempt to ingest readings for a gateway that does not exist
    When a POST request is sent to "/api/v1/edge-gateways/00:00:00:00:00:00/sensor-readings"
    And the request body contains readings for device "11:11:11:11:11:11"
    Then the response status code should be 404
    And the response body should contain an error message
```

**Archivo de pasos:** `Tests/Steps/SensorDataProcessing/IngestSensorReadingsByDeviceSteps.cs`

```csharp
using System.Net;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class IngestSensorReadingsByDeviceSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private string _currentPath = string.Empty;

    public IngestSensorReadingsByDeviceSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a POST request is sent to ""(.*)""")]
    public void WhenPostTargetIs(string path) => _currentPath = path;

    [When(@"the request body contains readings for devices ""(.*)"" and ""(.*)""")]
    public async Task WhenBodyContainsTwoDevices(string device1, string device2)
    {
        var body = $$"""
        {
          "devices": [
            { "deviceMac": "{{device1}}", "readings": [ { "sensorType": "Temperature", "measuredAt": "2026-07-06T10:00:00", "value": 29.1 } ] },
            { "deviceMac": "{{device2}}", "readings": [ { "sensorType": "SoilMoisture", "measuredAt": "2026-07-06T10:00:00", "value": 58.4 } ] }
          ],
          "syncedAt": "2026-07-06T10:00:05"
        }
        """;
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [When(@"the request body contains readings for device ""(.*)""")]
    public async Task WhenBodyContainsOneDevice(string device)
    {
        var body = $$"""
        {
          "devices": [ { "deviceMac": "{{device}}", "readings": [ { "sensorType": "Temperature", "measuredAt": "2026-07-06T10:00:00", "value": 29.1 } ] } ],
          "syncedAt": "2026-07-06T10:00:05"
        }
        """;
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }

    [Then(@"the readings for device ""(.*)"" should be persisted with their own attribution")]
    public async Task ThenDeviceReadingsPersisted(string deviceMac)
    {
        var get = await _client.GetAsync($"/api/v1/devices/{deviceMac}/sensor-readings");
        get.StatusCode.Should().Be(HttpStatusCode.OK);
        var body = await get.Content.ReadAsStringAsync();
        body.Should().Contain(deviceMac);
    }

    [Then(@"the response body should contain an error message")]
    public async Task ThenBodyShouldContainError()
    {
        var json = await _response.Content.ReadAsStringAsync();
        json.Should().Contain("message");
    }
}
```

---

#### AT-06: Consulta de lecturas por dispositivo individual (TS031)

**Relacionado con:** TS031 — Exponer un API RESTful para la ingesta y consulta de lecturas de sensores por gateway y por dispositivo IoT (EP008)

**Archivo:** `Tests/Features/SensorDataProcessing/GetSensorReadingsByDevice.feature`

```gherkin
Feature: Get Sensor Readings by Individual IoT Device
  As a developer consuming the SmartPalm API
  I want to query the sensor readings of a single IoT device
  So that the frontend can display device-level historical data regardless of shared gateways

  Background:
    Given the SmartPalm API is running and accessible
    And an IoT device with MAC "11:11:11:11:11:11" has sensor readings stored
    And a sibling IoT device with MAC "22:22:22:22:22:22" shares the same edge gateway

  Scenario: Retrieve readings scoped to a single device
    When a GET request is sent to "/api/v1/devices/11:11:11:11:11:11/sensor-readings"
    Then the response status code should be 200
    And every returned reading should belong to device "11:11:11:11:11:11"
    And no returned reading should belong to device "22:22:22:22:22:22"
```

**Archivo de pasos:** `Tests/Steps/SensorDataProcessing/GetSensorReadingsByDeviceSteps.cs`

```csharp
using System.Net;
using System.Text.Json;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class GetSensorReadingsByDeviceSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private JsonElement _body;

    public GetSensorReadingsByDeviceSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a GET request is sent to ""(.*)""")]
    public async Task WhenGetSentTo(string path)
    {
        _response = await _client.GetAsync(path);
        var json = await _response.Content.ReadAsStringAsync();
        _body = JsonSerializer.Deserialize<JsonElement>(json);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }

    [Then(@"every returned reading should belong to device ""(.*)""")]
    public void ThenAllBelongToDevice(string deviceMac)
    {
        foreach (var item in _body.GetProperty("data").EnumerateArray())
        {
            item.GetProperty("iotDeviceMacAddress").GetString().Should().Be(deviceMac);
        }
    }

    [Then(@"no returned reading should belong to device ""(.*)""")]
    public void ThenNoneBelongToDevice(string deviceMac)
    {
        foreach (var item in _body.GetProperty("data").EnumerateArray())
        {
            item.GetProperty("iotDeviceMacAddress").GetString().Should().NotBe(deviceMac);
        }
    }
}
```

---

#### AT-07: Registro de edge gateway restringido al rol Administrator (TS032)

**Relacionado con:** TS032 — Restringir el registro de dispositivos a administradores y asignarlos a la cuenta del cliente (EP008)

**Archivo:** `Tests/Features/IotDeviceManagement/RegisterEdgeGatewayAsAdministrator.feature`

```gherkin
Feature: Register Edge Gateway Restricted to Administrator Role
  As a developer protecting the device inventory
  I want edge gateway registration to be restricted to the Administrator role
  So that only authorized staff can assign hardware to a client account

  Background:
    Given the SmartPalm API is running and accessible
    And a registered client user with id 7 exists

  Scenario: Administrator successfully registers an edge gateway for a client
    Given a valid JWT for a user with role "Administrator"
    When a POST request is sent to "/api/v1/edge-gateways" with that token
    And the request body assigns edge mac "AA:BB:CC:DD:EE:FF" to user id 7
    Then the response status code should be 201

  Scenario: Farmer attempts to register an edge gateway
    Given a valid JWT for a user with role "Farmer"
    When a POST request is sent to "/api/v1/edge-gateways" with that token
    And the request body assigns edge mac "AA:BB:CC:DD:EE:FF" to user id 7
    Then the response status code should be 403

  Scenario: Request without an authentication token
    When a POST request is sent to "/api/v1/edge-gateways" without a token
    And the request body assigns edge mac "AA:BB:CC:DD:EE:FF" to user id 7
    Then the response status code should be 401
```

**Archivo de pasos:** `Tests/Steps/IotDeviceManagement/RegisterEdgeGatewayAsAdministratorSteps.cs`

```csharp
using System.Net;
using System.Net.Http.Headers;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class RegisterEdgeGatewayAsAdministratorSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private string? _token;

    public RegisterEdgeGatewayAsAdministratorSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Given(@"a valid JWT for a user with role ""(.*)""")]
    public async Task GivenValidJwtForRole(string role)
    {
        _token = await TestAuthHelper.SignInAndGetToken(_client, role);
    }

    [When(@"a POST request is sent to ""(.*)"" with that token")]
    public void WhenPostWithToken(string path)
    {
        _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _token);
        _pendingPath = path;
    }

    [When(@"a POST request is sent to ""(.*)"" without a token")]
    public void WhenPostWithoutToken(string path)
    {
        _client.DefaultRequestHeaders.Authorization = null;
        _pendingPath = path;
    }

    private string _pendingPath = string.Empty;

    [When(@"the request body assigns edge mac ""(.*)"" to user id (\d+)")]
    public async Task WhenBodyAssignsEdgeMac(string mac, int userId)
    {
        var body = $$"""{ "edgeMac": "{{mac}}", "monitoringZoneId": 1, "userId": {{userId}} }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_pendingPath, content);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }
}
```

---

#### AT-08: Autenticación y control de acceso basado en roles (TS004)

**Relacionado con:** TS004 — Implementar autenticación y control de acceso seguro (EP008)

**Archivo:** `Tests/Features/Iam/SignUpAndSignIn.feature`

```gherkin
Feature: Sign Up and Sign In with Role-Based Claims
  As a developer securing the platform
  I want sign-up and sign-in to issue role-aware JWTs
  So that downstream endpoints can authorize requests based on the caller's role

  Background:
    Given the SmartPalm API is running and accessible

  Scenario Outline: Successfully sign up a new user with a valid role
    When a POST request is sent to "/api/v1/authentication/sign-up"
    And the request body contains username "<username>", password "Sp@lm2026!" and role "<role>"
    Then the response status code should be 201

    Examples:
      | username        | role          |
      | agronomist.test  | Agronomist    |
      | farmer.test      | Farmer        |
      | admin.test       | Administrator |

  Scenario: Sign in returns a token carrying the user's role claim
    Given a registered user "admin.test" with role "Administrator"
    When a POST request is sent to "/api/v1/authentication/sign-in"
    And the request body contains username "admin.test" and password "Sp@lm2026!"
    Then the response status code should be 200
    And the decoded token should contain a role claim equal to "Administrator"

  Scenario: Reject sign-up with an unknown role
    When a POST request is sent to "/api/v1/authentication/sign-up"
    And the request body contains username "invalid.role.test", password "Sp@lm2026!" and role "SuperUser"
    Then the response status code should be 400
```

**Archivo de pasos:** `Tests/Steps/Iam/SignUpAndSignInSteps.cs`

```csharp
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Text.Json;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class SignUpAndSignInSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private string _currentPath = string.Empty;

    public SignUpAndSignInSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a POST request is sent to ""(.*)""")]
    public void WhenPostTargetIs(string path) => _currentPath = path;

    [When(@"the request body contains username ""(.*)"", password ""(.*)"" and role ""(.*)""")]
    public async Task WhenSignUpBody(string username, string password, string role)
    {
        var body = $$"""{ "username": "{{username}}", "password": "{{password}}", "role": "{{role}}" }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Given(@"a registered user ""(.*)"" with role ""(.*)""")]
    public async Task GivenRegisteredUser(string username, string role)
    {
        var body = $$"""{ "username": "{{username}}", "password": "Sp@lm2026!", "role": "{{role}}" }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        await _client.PostAsync("/api/v1/authentication/sign-up", content);
    }

    [When(@"the request body contains username ""(.*)"" and password ""(.*)""")]
    public async Task WhenSignInBody(string username, string password)
    {
        var body = $$"""{ "username": "{{username}}", "password": "{{password}}" }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }

    [Then(@"the decoded token should contain a role claim equal to ""(.*)""")]
    public async Task ThenTokenContainsRoleClaim(string expectedRole)
    {
        var json = await _response.Content.ReadAsStringAsync();
        var body = JsonSerializer.Deserialize<JsonElement>(json);
        var token = body.GetProperty("token").GetString();
        var jwt = new JwtSecurityTokenHandler().ReadJwtToken(token);
        jwt.Claims.Should().Contain(c => c.Type.EndsWith("role", StringComparison.OrdinalIgnoreCase) && c.Value == expectedRole);
    }
}
```

---

#### Commits relacionados con Testing — Sprint 3

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-iam-implementation | `940c113` | fix: 404 error when injecting unknown edge gateways. | Adds the gateway-existence check exercised by the AT-05 negative scenario, returning 404 instead of 201. | 2026-07-08 |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-rest-endpoints | `0001720` | feat: add per-device sensor readings endpoint and paginate gateway readings. | Adds the GET endpoint exercised by AT-06 to query sensor readings scoped to a single IoT device. | 2026-07-08 |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-rest-endpoints | `051c239` | feat: ingest sensor readings grouped by IoT device and update edge connectivity on sync. | Implements the grouped ingestion contract exercised by the AT-05 positive scenario. | 2026-07-07 |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-rest-endpoints | `81411a9` | feat: add IoT device attribution to sensor readings and update resource assembly. | Adds the `iotDeviceMacAddress` attribution asserted by AT-06. | 2026-07-07 |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-iam-implementation | `774ac9d` | feat: update edge device registration and command models, add userId to edge device and update swagger annotations. | Adds the client ownership (`userId`) assigned in the AT-07 registration scenario. | 2026-07-08 |
| upc-202601-1asi0572-6779-teamwise/webservice | fix/update-iam-implementation | `ae9500f` | feat: add roles to user resource and command, update assembly and service methods | Adds the role field validated by the AT-08 sign-up scenarios and rejected in the invalid-role scenario. | 2026-07-08 |
| upc-202601-1asi0572-6779-teamwise/webservice | feature/iam-integration | `79be08c` | Add IAM BC and JWT configuration files, update middleware and services for token validation and hashing. | Wires the IAM bounded context and JWT issuance exercised by all AT-08 scenarios. | 2026-07-06 |

---
