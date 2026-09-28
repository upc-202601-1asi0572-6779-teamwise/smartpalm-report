#### 6.2.2.5. Testing Suite Evidence for Sprint Review

Esta sección documenta el conjunto de Acceptance Tests automatizados elaborados para los Web Services implementados durante el Sprint 2. Las pruebas siguen el enfoque BDD (Behavior-Driven Development): los escenarios están definidos en lenguaje Gherkin (archivos `.feature`) y los pasos correspondientes en C#. Los tests cubren cuatro Technical Stories priorizadas en este Sprint: registro de dispositivos IoT, ingesta de lecturas de sensores, consulta de lecturas por dispositivo edge y creación de recomendaciones agronómicas.

El repositorio de Web Services que contiene los archivos de prueba es:  
**[https://github.com/upc-202601-1asi0572-6779-teamwise/webservice](https://github.com/upc-202601-1asi0572-6779-teamwise/webservice)**

---

#### AT-01: Registro de dispositivo edge (TS001)

**Relacionado con:** TS001 — Exponer un API RESTful para la gestión de dispositivos IoT (EP008)

**Archivo:** `Tests/Features/IotDeviceManagement/RegisterEdgeDevice.feature`

```gherkin
Feature: Register Edge Device
  As a developer integrating a new edge node
  I want to register an edge device via the RESTful API
  So that it becomes available for sensor data ingestion

  Background:
    Given the SmartPalm API is running and accessible

  Scenario: Successfully register a new edge device
    Given a monitoring zone with ID 3 exists in the system
    When a POST request is sent to "/api/v1/device/edge/AA:BB:CC:DD:EE:FF/zone/3/auth/register"
    And the request body contains a valid API key
    Then the response status code should be 201
    And the edge device "AA:BB:CC:DD:EE:FF" should be stored in the database

  Scenario: Attempt to register an edge device with a duplicate MAC address
    Given an edge device with MAC "AA:BB:CC:DD:EE:FF" is already registered
    When a POST request is sent to "/api/v1/device/edge/AA:BB:CC:DD:EE:FF/zone/3/auth/register"
    And the request body contains a valid API key
    Then the response status code should be 500
    And the response body should contain an error message
```

**Archivo de pasos:** `Tests/Steps/IotDeviceManagement/RegisterEdgeDeviceSteps.cs`

```csharp
using System.Net;
using System.Net.Http.Json;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class RegisterEdgeDeviceSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private string _currentPath = string.Empty;

    public RegisterEdgeDeviceSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a POST request is sent to ""(.*)""")]
    public void WhenPostTargetIs(string path) => _currentPath = path;

    [When(@"the request body contains a valid API key")]
    public async Task WhenBodyContainsApiKey()
    {
        var body = """{ "apiKey": "sp-edge-api-key-001" }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }

    [Then(@"the edge device ""(.*)"" should be stored in the database")]
    public async Task ThenEdgeDeviceShouldExist(string mac)
    {
        var get = await _client.GetAsync($"/api/v1/device/edge/{mac}/status/connectivity");
        get.StatusCode.Should().Be(HttpStatusCode.OK);
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

#### AT-02: Ingesta de lote de lecturas de sensores (TS006)

**Relacionado con:** TS006 — Exponer un API RESTful para la recepción de lecturas desde dispositivos IoT (EP009)

**Archivo:** `Tests/Features/SensorDataProcessing/SubmitSensorReadingsBatch.feature`

```gherkin
Feature: Submit Sensor Readings Batch
  As a developer integrating the edge node
  I want to submit a batch of sensor readings via the RESTful API
  So that the platform can persist and analyze the telemetry data

  Background:
    Given the SmartPalm API is running and accessible
    And an edge device with MAC "CC:DD:EE:FF:00:11" is registered in the system

  Scenario: Successfully submit a valid batch of sensor readings
    When a POST request is sent to "/api/v1/device/edge/CC:DD:EE:FF:00:11/digest"
    And the request body contains a valid readings batch
    Then the response status code should be 200
    And the readings for edge "CC:DD:EE:FF:00:11" should be persisted

  Scenario: Submit a batch with an unrecognized sensor type
    When a POST request is sent to "/api/v1/device/edge/CC:DD:EE:FF:00:11/digest"
    And the request body contains an unrecognized sensor type
    Then the response status code should be 500
    And the response body should contain an error message
```

**Archivo de pasos:** `Tests/Steps/SensorDataProcessing/SubmitSensorReadingsBatchSteps.cs`

```csharp
using System.Net;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class SubmitSensorReadingsBatchSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private string _currentPath = string.Empty;

    public SubmitSensorReadingsBatchSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a POST request is sent to ""(.*)""")]
    public void WhenPostTargetIs(string path) => _currentPath = path;

    [When(@"the request body contains a valid readings batch")]
    public async Task WhenBodyContainsValidBatch()
    {
        var body = """
        {
          "readings": [
            { "sensorType": "Temperature", "measuredAt": "2026-06-20T10:00:00", "value": 28.5 },
            { "sensorType": "SoilMoisture", "measuredAt": "2026-06-20T10:00:00", "value": 62.3 },
            { "sensorType": "Luminosity",   "measuredAt": "2026-06-20T10:00:00", "value": 840.0 }
          ],
          "measuredAt": "2026-06-20T10:00:00"
        }
        """;
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [When(@"the request body contains an unrecognized sensor type")]
    public async Task WhenBodyContainsInvalidSensorType()
    {
        var body = """
        {
          "readings": [
            { "sensorType": "UnknownSensor", "measuredAt": "2026-06-20T10:05:00", "value": 99.9 }
          ],
          "measuredAt": "2026-06-20T10:05:00"
        }
        """;
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Then(@"the readings for edge ""(.*)"" should be persisted")]
    public async Task ThenReadingsShouldBePersisted(string mac)
    {
        var get = await _client.GetAsync($"/api/v1/device/edge/{mac}/readings");
        get.StatusCode.Should().Be(HttpStatusCode.OK);
        var body = await get.Content.ReadAsStringAsync();
        body.Should().NotBe("[]");
    }
}
```

---

#### AT-03: Consulta de lecturas por dispositivo edge (TS002)

**Relacionado con:** TS002 — Exponer un API RESTful para la gestión de alertas y umbrales (EP008)

**Archivo:** `Tests/Features/SensorDataProcessing/GetSensorReadings.feature`

```gherkin
Feature: Get Sensor Readings by Edge Device
  As a developer consuming the SmartPalm API
  I want to query the sensor readings associated to a specific edge device
  So that the frontend can display historical monitoring data

  Background:
    Given the SmartPalm API is running and accessible
    And an edge device with MAC "FF:EE:DD:CC:BB:AA" has sensor readings stored

  Scenario: Retrieve all readings without time filters
    When a GET request is sent to "/api/v1/device/edge/FF:EE:DD:CC:BB:AA/readings"
    Then the response status code should be 200
    And the response body should contain a non-empty list of readings
    And each reading should include the fields "id", "edgeDeviceMacAddress", "sensorType", "value", "unit", "measuredAt"

  Scenario: Retrieve readings filtered by time range
    When a GET request is sent to "/api/v1/device/edge/FF:EE:DD:CC:BB:AA/readings?from=2026-06-20T00:00:00&to=2026-06-20T23:59:59"
    Then the response status code should be 200
    And all returned readings should have "measuredAt" within the requested range
```

**Archivo de pasos:** `Tests/Steps/SensorDataProcessing/GetSensorReadingsSteps.cs`

```csharp
using System.Net;
using System.Text.Json;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class GetSensorReadingsSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private JsonElement _body;

    public GetSensorReadingsSteps(ApiTestFactory factory)
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

    [Then(@"the response body should contain a non-empty list of readings")]
    public void ThenNonEmptyList()
    {
        _body.ValueKind.Should().Be(JsonValueKind.Array);
        _body.GetArrayLength().Should().BeGreaterThan(0);
    }

    [Then(@"each reading should include the fields ""(.*)"", ""(.*)"", ""(.*)"", ""(.*)"", ""(.*)"", ""(.*)""")]
    public void ThenEachItemHasFields(string f1, string f2, string f3, string f4, string f5, string f6)
    {
        foreach (var item in _body.EnumerateArray())
        {
            item.TryGetProperty(f1, out _).Should().BeTrue($"field '{f1}' missing");
            item.TryGetProperty(f2, out _).Should().BeTrue($"field '{f2}' missing");
            item.TryGetProperty(f3, out _).Should().BeTrue($"field '{f3}' missing");
            item.TryGetProperty(f4, out _).Should().BeTrue($"field '{f4}' missing");
            item.TryGetProperty(f5, out _).Should().BeTrue($"field '{f5}' missing");
            item.TryGetProperty(f6, out _).Should().BeTrue($"field '{f6}' missing");
        }
    }

    [Then(@"all returned readings should have ""measuredAt"" within the requested range")]
    public void ThenAllWithinRange()
    {
        var from = new DateTime(2026, 6, 20, 0, 0, 0);
        var to   = new DateTime(2026, 6, 20, 23, 59, 59);
        foreach (var item in _body.EnumerateArray())
        {
            var measuredAt = item.GetProperty("measuredAt").GetDateTime();
            measuredAt.Should().BeOnOrAfter(from).And.BeOnOrBefore(to);
        }
    }
}
```

---

#### AT-04: Creación de recomendación agronómica (TS003)

**Relacionado con:** TS003 — Exponer un API RESTful para observaciones, recomendaciones y reportes (EP008)

**Archivo:** `Tests/Features/AgronomicRecommendation/CreateRecommendation.feature`

```gherkin
Feature: Create Agronomic Recommendation
  As a developer integrating the agronomist workflow
  I want to create a new agronomic recommendation via the RESTful API
  So that the plantation owner can view and act on technical guidance

  Background:
    Given the SmartPalm API is running and accessible

  Scenario: Successfully create a valid recommendation
    When a POST request is sent to "/api/v1/agronomic/recommendations"
    And the request body contains a valid recommendation payload
    Then the response status code should be 201
    And the response body should contain the field "id"
    And the response body should contain "status" with value "Draft"

  Scenario: Attempt to create a recommendation with missing required fields
    When a POST request is sent to "/api/v1/agronomic/recommendations"
    And the request body is missing the required content field
    Then the response status code should be 400
```

**Archivo de pasos:** `Tests/Steps/AgronomicRecommendation/CreateRecommendationSteps.cs`

```csharp
using System.Net;
using System.Text.Json;
using FluentAssertions;
using TechTalk.SpecFlow;

[Binding]
public class CreateRecommendationSteps
{
    private readonly HttpClient _client;
    private HttpResponseMessage _response = default!;
    private JsonElement _body;
    private string _currentPath = string.Empty;

    public CreateRecommendationSteps(ApiTestFactory factory)
    {
        _client = factory.CreateClient();
    }

    [When(@"a POST request is sent to ""(.*)""")]
    public void WhenPostTargetIs(string path) => _currentPath = path;

    [When(@"the request body contains a valid recommendation payload")]
    public async Task WhenBodyIsValid()
    {
        var body = """
        {
          "plantationId": 1,
          "agronomistId": 5,
          "content": "Apply controlled irrigation in sector B due to detected soil moisture below threshold.",
          "type": "Irrigation"
        }
        """;
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
        var json = await _response.Content.ReadAsStringAsync();
        if (!string.IsNullOrWhiteSpace(json))
            _body = JsonSerializer.Deserialize<JsonElement>(json);
    }

    [When(@"the request body is missing the required content field")]
    public async Task WhenBodyMissingContent()
    {
        var body = """{ "plantationId": 1 }""";
        var content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
        _response = await _client.PostAsync(_currentPath, content);
    }

    [Then(@"the response status code should be (\d+)")]
    public void ThenStatusShouldBe(int statusCode)
    {
        ((int)_response.StatusCode).Should().Be(statusCode);
    }

    [Then(@"the response body should contain the field ""(.*)""")]
    public void ThenBodyHasField(string field)
    {
        _body.TryGetProperty(field, out _).Should().BeTrue($"field '{field}' expected in response");
    }

    [Then(@"the response body should contain ""(.*)"" with value ""(.*)""")]
    public void ThenBodyHasFieldWithValue(string field, string expected)
    {
        _body.TryGetProperty(field, out var prop).Should().BeTrue();
        prop.GetString().Should().Be(expected);
    }
}
```

---

#### Commits relacionados con Testing — Sprint 2

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `d6f1d4d` | feat: update datetime parameters. | Adjusts From/To defaults to DateTime.MinValue and DateTime.MaxValue for correct PostgreSQL timestamp comparison. | 2026-06-20 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `2536090` | feat: update sensor reading query. | Refactors SensorReadingQuery record and its handling in the query service. | 2026-06-20 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `41c120c` | chore: add ISensorReadingQueryService and related services to API. | Registers ISensorReadingQueryService and SensorReadingQueryService in Program.cs DI container. | 2026-06-20 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `5200662` | feat: add ReadDeviceSensorDataController and related services. | Adds GET endpoint for querying sensor readings by edge MAC address with optional time-range filters. | 2026-06-20 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `cadb990` | feat: add ISensorReadingQueryService and SensorReadingQuery interface. | Defines the domain query interface and SensorReadingQuery record for the Sensor Data Processing bounded context. | 2026-06-19 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `8a069f9` | fix: add missing sensor types to SensorReadingTypeFactory and StringFromSensorTypeAssembly | Adds Temperature and SoilMoisture mappings required for correct batch ingestion. | 2026-06-19 |
| upc-202601-1asi0572-6779-teamwise/webservice | develop | `ef9d8bb` | fix: rewrite migration with PostgreSQL-compatible types | Replaces MySQL-specific type annotations to support Render-hosted PostgreSQL deployment. | 2026-06-18 |
