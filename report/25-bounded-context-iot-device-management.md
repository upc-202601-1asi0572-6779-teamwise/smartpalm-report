
## 4.2. Tactical-Level Domain-Driven Design

En esta sección se desarrolla la perspectiva táctica del diseño de la solución SmartPalm IoT, tomando como base los bounded contexts identificados previamente en el diseño estratégico. El propósito de este nivel es describir con mayor detalle la organización interna de cada bounded context, especificando las clases, responsabilidades, capas y componentes que permiten materializar su lógica de negocio dentro de la arquitectura de software propuesta.

### 4.2.1. Bounded Context: IoT Device Management

El bounded context **IoT Device Management** se encarga de gestionar el ciclo de vida de los dispositivos IoT desplegados en campo dentro de la solución SmartPalm IoT. Su responsabilidad principal es administrar el registro, configuración, activación, desactivación, monitoreo de conectividad y sincronización de datos de los nodos IoT multisensor ubicados en microzonas del cultivo de palma aceitera.

#### 4.2.1.1. Domain Layer

La **Domain Layer** del bounded context **IoT Device Management** representa el núcleo del dominio encargado de gestionar el ciclo de vida de los dispositivos IoT desplegados en campo. En esta capa se ubican las clases que modelan las reglas de negocio relacionadas con el registro de gateways edge y sus dispositivos IoT asociados, el control de conectividad de los edge gateways y la sincronización de datos acumulados cuando la conexión se restablece.

El dominio se compone de un *aggregate root* (`EdgeDevice`), dos entidades (`IotDevice` y `EdgeRegistry`), una enumeración (`SensorType`), tres interfaces de repositorio, tres interfaces de servicio de dominio, un *domain service* y los *commands* y *queries* que estructuran las operaciones del bounded context.

---

##### 1. EdgeDevice

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeDevice |
| **Categoría** | Entity / Aggregate Root |
| **Propósito** | Representar al gateway edge desplegado en una microzona del cultivo y gestionar su ciclo de vida, conectividad y sincronización dentro del bounded context. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Id | int | private | Identificador único del edge gateway generado por la base de datos. |
| MacAddress | string | private | Dirección MAC única del edge gateway. |
| MonitoringZoneId | int | private | Identificador de la microzona del cultivo asociada al edge gateway. |
| LastConnectivityCheckAt | DateTime | private | Fecha y hora del último check de conectividad. |
| LastSyncAt | DateTime | private | Fecha y hora de la última sincronización de datos. |
| CreatedAt | DateTime | private | Fecha y hora de registro del edge gateway. |
| IsConnected | bool | public | Propiedad calculada: indica si el dispositivo se considera conectado basado en el tiempo transcurrido desde `LastConnectivityCheckAt`. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Register | void | public | Establece el estado inicial del edge gateway al momento de su primer registro. |
| SynchronizeEdgeData | void | public | Actualiza `LastSyncAt` y `LastConnectivityCheckAt` con la hora actual para marcar la sincronización. |

---

##### 2. IotDevice

| Campo | Detalle |
|---|---|
| **Nombre** | IotDevice |
| **Categoría** | Entity |
| **Propósito** | Representar un dispositivo IoT individual (sensor multisensor) asociado a un edge gateway. Es una entidad hija del aggregate `EdgeDevice`. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Id | int | private | Identificador único del dispositivo IoT generado por la base de datos. |
| MacAddress | string | private | Dirección MAC única del dispositivo IoT. |
| EdgeDeviceMacAddress | string | private | Dirección MAC del edge gateway al que pertenece. |
| CreatedAt | DateTime | private | Fecha y hora de registro del dispositivo IoT. |

---

##### 3. EdgeRegistry

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeRegistry |
| **Categoría** | Entity |
| **Propósito** | Representar la relación de vinculación entre un edge gateway y un dispositivo IoT. Almacena el registro de asociación entre ambos dispositivos. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Id | int | private | Identificador único del registro generado por la base de datos. |
| EdgeMacAddress | string | private | Dirección MAC del edge gateway. |
| IotDeviceMacAddresses | string | private | Dirección MAC del dispositivo IoT asociado. |
| CreatedAt | DateTime | private | Fecha y hora en que se creó la vinculación. |

---

##### 4. SensorType

| Campo | Detalle |
|---|---|
| **Nombre** | SensorType |
| **Categoría** | Enumeration |
| **Propósito** | Representar los tipos de sensores soportados por los dispositivos IoT dentro del bounded context IotDeviceManagement. |

**Valores**

| Nombre | Descripción |
|---|---|
| Temperature | Sensor de temperatura ambiental o del suelo. |
| Humidity | Sensor de humedad relativa ambiental o del suelo. |
| Pressure | Sensor de presión atmosférica. |
| Luminosity | Sensor de luminosidad. |
| GasResistance | Sensor de resistencia de gas. |
| Voltage | Sensor de voltaje eléctrico. |
| Current | Sensor de corriente eléctrica. |
| Power | Sensor de potencia eléctrica. |
| Speed | Sensor de velocidad. |
| Direction | Sensor de dirección u orientación. |

---

##### 5. IEdgeDeviceRepository

| Campo | Detalle |
|---|---|
| **Nombre** | IEdgeDeviceRepository |
| **Categoría** | Repository (interfaz) |
| **Propósito** | Abstraer la persistencia de los edge gateways gestionados por el bounded context. Extiende `IBaseRepository<EdgeDevice>`, por lo que hereda las operaciones CRUD genéricas. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByMacAddress | Task\<EdgeDevice?\> | public | Buscar de forma asíncrona un edge gateway por su dirección MAC. Retorna `null` si no existe. |

**Métodos heredados de IBaseRepository\<EdgeDevice\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar un nuevo edge gateway al repositorio. |
| FindByIdAsync | Task\<EdgeDevice?\> | public | Buscar un edge gateway por su identificador. |
| Update | void | public | Actualizar el estado de un edge gateway existente. |
| Remove | void | public | Eliminar un edge gateway del repositorio. |
| ListAsync | Task\<IEnumerable\<EdgeDevice\>\> | public | Obtener todos los edge gateways registrados. |

---

##### 6. IIotDeviceRepository

| Campo | Detalle |
|---|---|
| **Nombre** | IIotDeviceRepository |
| **Categoría** | Repository (interfaz) |
| **Propósito** | Abstraer la persistencia de los dispositivos IoT gestionados por el bounded context. Extiende `IBaseRepository<IotDevice>`, por lo que hereda las operaciones CRUD genéricas. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByMacAddress | Task\<IotDevice?\> | public | Buscar de forma asíncrona un dispositivo IoT por su dirección MAC. Retorna `null` si no existe. |

**Métodos heredados de IBaseRepository\<IotDevice\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar un nuevo dispositivo IoT al repositorio. |
| FindByIdAsync | Task\<IotDevice?\> | public | Buscar un dispositivo IoT por su identificador. |
| Update | void | public | Actualizar el estado de un dispositivo IoT existente. |
| Remove | void | public | Eliminar un dispositivo IoT del repositorio. |
| ListAsync | Task\<IEnumerable\<IotDevice\>\> | public | Obtener todos los dispositivos IoT registrados. |

---

##### 7. IEdgeRegistryRepository

| Campo | Detalle |
|---|---|
| **Nombre** | IEdgeRegistryRepository |
| **Categoría** | Repository (interfaz) |
| **Propósito** | Abstraer la persistencia de los registros de vinculación edge-iot. Extiende `IBaseRepository<EdgeRegistry>`, por lo que hereda las operaciones CRUD genéricas. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByEdgeMacAddress | Task\<List\<EdgeRegistry\>\> | public | Buscar todos los registros de vinculación asociados a un edge gateway por su dirección MAC. |
| FindByIotDeviceMacAddress | Task\<List\<EdgeRegistry\>\> | public | Buscar todos los registros de vinculación asociados a un dispositivo IoT por su dirección MAC. |
| FindByEdgeAndIotMacAddresses | Task\<EdgeRegistry?\> | public | Buscar un registro de vinculación específico por las direcciones MAC del edge gateway y del dispositivo IoT. Retorna `null` si no existe. |

**Métodos heredados de IBaseRepository\<EdgeRegistry\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar un nuevo registro de vinculación al repositorio. |
| FindByIdAsync | Task\<EdgeRegistry?\> | public | Buscar un registro de vinculación por su identificador. |
| Update | void | public | Actualizar un registro de vinculación existente. |
| Remove | void | public | Eliminar un registro de vinculación. |
| ListAsync | Task\<IEnumerable\<EdgeRegistry\>\> | public | Obtener todos los registros de vinculación. |

---

##### 8. IDeviceStatusCommandService

| Campo | Detalle |
|---|---|
| **Nombre** | IDeviceStatusCommandService |
| **Categoría** | Domain Service (interfaz) |
| **Propósito** | Definir el contrato para el servicio que procesa los comandos de registro de edge gateways, registro de dispositivos IoT y sincronización de datos. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle(RegisterEdgeDeviceCommand) | Task | public | Procesar el comando de registro de un nuevo edge gateway. |
| Handle(RegisterIotDeviceCommand) | Task | public | Procesar el comando de registro de un nuevo dispositivo IoT bajo un edge gateway. |
| Handle(EdgeSynchronizationCommand) | Task | public | Procesar el comando de sincronización de datos acumulados desde el edge gateway. |

---

##### 9. IDeviceStatusQueryService

| Campo | Detalle |
|---|---|
| **Nombre** | IDeviceStatusQueryService |
| **Categoría** | Domain Service (interfaz) |
| **Propósito** | Definir el contrato para el servicio que procesa las consultas de estado de conectividad, registro de dispositivos y listado de gateways. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle(ConnectiviyStatusQuery) | Task\<EdgeDevice\> | public | Procesar la consulta del estado de conectividad de un edge gateway identificado por su dirección MAC. |
| Handle(EdgeRegistryQuery) | Task\<Tuple\<EdgeDevice, List\<EdgeRegistry\>\>\> | public | Procesar la consulta del registro de dispositivos IoT vinculados a un edge gateway. |
| Handle(GetAllEdgeGatewaysQuery) | Task\<IEnumerable\<EdgeDevice\>\> | public | Procesar la consulta que retorna todos los edge gateways registrados. |

---

##### 10. IEdgeSynchronizationService

| Campo | Detalle |
|---|---|
| **Nombre** | IEdgeSynchronizationService |
| **Categoría** | Domain Service (interfaz) |
| **Propósito** | Definir el contrato para el servicio de dominio que ordena cronológicamente las lecturas acumuladas durante la sincronización del edge gateway. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| MapReadingsToChronologicalOrder | List\<SensorReadingPayload\> | public | Retornar una copia ordenada cronológicamente de la lista de lecturas recibida. |

---

##### 11. EdgeSynchronizationService

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationService |
| **Categoría** | Domain Service |
| **Propósito** | Implementar `IEdgeSynchronizationService`. Contener la lógica de ordenamiento de los datos acumulados en el edge gateway durante la sincronización. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| MapReadingsToChronologicalOrder | List\<SensorReadingPayload\> | public | Ordenar la lista de lecturas por `MeasuredAt` de forma ascendente y retornar la lista ordenada. |

---

##### 12. Commands

Los *commands* son objetos inmutables de tipo `record` que encapsulan la intención de modificar el estado del sistema. Los definidos en este bounded context son:

| Nombre | Parámetros | Descripción |
|---|---|---|
| RegisterEdgeDeviceCommand | EdgeDeviceMac, MonitoringZoneId | Solicitar el registro de un nuevo edge gateway identificado por su dirección MAC y asignado a una microzona. |
| RegisterIotDeviceCommand | EdgeDeviceMac, IotDeviceMac, PlantationId | Solicitar el registro de un nuevo dispositivo IoT bajo un edge gateway, asociado a una plantación. |
| EdgeSynchronizationCommand | EdgeDeviceMac, readings | Solicitar la sincronización de datos acumulados desde el edge gateway hacia la plataforma. |

---

##### 13. Queries

Las *queries* son objetos inmutables de tipo `record` que encapsulan la intención de consultar el estado del sistema sin modificarlo. Las definidas en este bounded context son:

| Nombre | Parámetros | Descripción |
|---|---|---|
| ConnectiviyStatusQuery | mac | Consultar el estado de conectividad del edge gateway identificado por su dirección MAC. |
| EdgeRegistryQuery | EdgeDeviceMac | Consultar el registro de dispositivos IoT vinculados al edge gateway identificado por su dirección MAC. |
| GetAllEdgeGatewaysQuery | — | Consultar todos los edge gateways registrados en la plataforma. |

#### 4.2.1.2. Interface Layer

La **Interface Layer** del bounded context **IoT Device Management** agrupa las clases encargadas de recibir solicitudes HTTP provenientes de actores externos y derivarlas hacia la capa de aplicación. Su función principal es actuar como punto de entrada del bounded context, descomponiendo los recursos de la petición en *commands* o *queries* a través de ensambladores, y retornando recursos estructurados como respuesta.

En este bounded context, la capa de interfaz se encuentra compuesta por dos **Controllers** (uno para autenticación de dispositivos y otro para gestión de su estado), un conjunto de **Resources** que representan los cuerpos de petición y respuesta, y un conjunto de **Assemblers** que transforman entre recursos y objetos del dominio.

---

##### 1. DeviceAuthenticationController

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceAuthenticationController |
| **Categoría** | Controller |
| **Ruta base** | `api/v1/edge-gateways` |
| **Propósito** | Exponer los endpoints de registro de edge gateways y dispositivos IoT en la plataforma. Requiere rol `Administrator`. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| _deviceStatusCommandService | IDeviceStatusCommandService | private | Servicio de comandos de dominio inyectado para coordinar los registros. |

**Métodos**

| Nombre | Verbo HTTP | Ruta | Tipo de retorno | Descripción |
|---|---|---|---|---|
| RegisterEdgeDevice | POST | `` | IActionResult | Recibir un `EdgeDeviceRegistrationResource`, construir el `RegisterEdgeDeviceCommand` mediante el ensamblador y delegar al command service. Retorna `201 Created` si el registro es exitoso. |
| RegisterIotDevice | POST | `/{gateway-mac}/iot-devices` | IActionResult | Recibir un `IotDeviceRegistrationResource`, construir el `RegisterIotDeviceCommand` mediante el ensamblador y delegar al command service. Retorna `201 Created` si el registro es exitoso. |

---

##### 2. DeviceStatusController

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceStatusController |
| **Categoría** | Controller |
| **Ruta base** | `api/v1/edge-gateways` |
| **Propósito** | Exponer endpoints HTTP para listar gateways, consultar dispositivos IoT, sincronizar datos y verificar conectividad. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| _deviceStatusCommandService | IDeviceStatusCommandService | private | Servicio de comandos de dominio inyectado para las operaciones de sincronización. |
| _deviceStatusQueryService | IDeviceStatusQueryService | private | Servicio de consultas de dominio inyectado para las operaciones de lectura. |

**Métodos**

| Nombre | Verbo HTTP | Ruta | Tipo de retorno | Descripción |
|---|---|---|---|---|
| GetAllGateways | GET | `` | IActionResult | Obtener todos los edge gateways registrados. Retorna una lista de `ConnectivityStatusResource`. |
| GetDevices | GET | `/{gateway-mac}/devices` | IActionResult | Obtener los dispositivos IoT registrados bajo un edge gateway. Retorna `GatewayDevicesResource`. |
| SynchronizeEdge | POST | `/{gateway-mac}/synchronizations` | IActionResult | Recibir un `EdgeSynchronizationResource`, construir el `EdgeSynchronizationCommand` y delegar al command service. Sin autenticación (`AllowAnonymous`). |
| GetConnectivityStatus | GET | `/{gateway-mac}/connectivity` | IActionResult | Consultar el estado de conectividad del edge gateway. Sin autenticación (`AllowAnonymous`). |
| GetDeviceRegistry | GET | `/{gateway-mac}/registry` | IActionResult | Consulta legacy del registro de dispositivos IoT bajo un edge gateway. Retorna `EdgeRegistryResource`. |

---

##### 3. Resources

Los *resources* son objetos inmutables de tipo `record` que definen la estructura de los cuerpos de solicitud y respuesta de la API REST.

| Nombre | Campos | Descripción |
|---|---|---|
| EdgeDeviceRegistrationResource | edgeMac, monitoringZoneId | Cuerpo de solicitud para el registro de un nuevo edge gateway. |
| IotDeviceRegistrationResource | iotMac, plantationId | Cuerpo de solicitud para el registro de un dispositivo IoT bajo un edge gateway. |
| EdgeSynchronizationResource | readings, syncedAt | Cuerpo de solicitud para la sincronización de datos acumulados desde el edge gateway. Contiene una lista de `SensorReadingResource` y la fecha de sincronización. |
| SensorReadingResource | deviceMac, sensorType, measuredAt, value | Recurso anidado que representa una lectura individual de sensor dentro de una solicitud de sincronización. |
| ConnectivityStatusResource | mac, isConnected, status | Respuesta que expone el estado de conectividad de un edge gateway. |
| EdgeRegistryResource | edgeDeviceMac, registry | Respuesta que expone el registro legacy de dispositivos IoT vinculados a un edge gateway. |
| GatewayDevicesResource | gatewayMac, devices | Respuesta que expone la lista de dispositivos IoT registrados bajo un edge gateway. |

---

##### 4. Assemblers (Transform)

Los *assemblers* son clases estáticas que transforman entre recursos de la interfaz y objetos del dominio (commands, queries o aggregates).

| Nombre | Método | Descripción |
|---|---|---|
| RegisterEdgeDeviceCommandFromResourceAssembler | ToCommandFromResource(EdgeDeviceRegistrationResource) | Construir un `RegisterEdgeDeviceCommand` a partir del recurso de registro. |
| RegisterIotDeviceCommandFromResourceAssembler | ToCommandFromResource(string edgeMac, IotDeviceRegistrationResource) | Construir un `RegisterIotDeviceCommand` a partir de la MAC del edge y el recurso de registro IoT. |
| EdgeSynchronizationCommandFromResourceAssembler | ToCommandFromResource(string gatewayMac, EdgeSynchronizationResource) | Construir un `EdgeSynchronizationCommand` a partir de la MAC del gateway y el recurso de sincronización, convirtiendo los tipos de sensor de string a enum. |
| ConnectiviyStatusQueryFromResourceAssembler | ToQueryFromResource(string edgeMac) | Construir un `ConnectiviyStatusQuery` a partir de la dirección MAC del edge gateway. |
| EdgeRegistryQueryFromResourceAssembler | ToQueryFromResource(string edgeMac) | Construir un `EdgeRegistryQuery` a partir de la dirección MAC del edge gateway. |
| ConnectivityStatusResourceFromEdgeDeviceAggregateAssembler | ToResourceFromEdgeDeviceAggregate(EdgeDevice) | Construir un `ConnectivityStatusResource` a partir del aggregate `EdgeDevice`. |
| GatewayDevicesResourceFromEdgeDeviceAggregateAssembler | ToResourceFromEdgeDeviceAggregate(EdgeDevice, List\<EdgeRegistry\>) | Construir un `GatewayDevicesResource` a partir del aggregate `EdgeDevice` y su lista de registros. |
| EdgeRegistryResourceFromEdgeDeviceAggregateAssembler | ToResourceFromEdgeDeviceAggregate(EdgeDevice, List\<EdgeRegistry\>) | Construir un `EdgeRegistryResource` a partir del aggregate `EdgeDevice` y su lista de registros. |

#### 4.2.1.3. Application Layer

La **Application Layer** del bounded context **IoT Device Management** se encarga de orquestar los flujos de negocio relacionados con el ciclo de vida de los dispositivos. Recibe los *commands* y *queries* derivados desde la Interface Layer, accede a los repositorios de dominio para recuperar o persistir los agregados, aplica la lógica de negocio sobre los mismos, publica eventos de integración y confirma los cambios a través de la unidad de trabajo.

En este bounded context, la capa de aplicación se compone de un **Command Service**, un **Query Service** y un **Domain Service**, implementando las interfaces de dominio correspondientes.

---

##### 1. DeviceStatusCommandService

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceStatusCommandService |
| **Categoría** | Command Service |
| **Propósito** | Implementar `IDeviceStatusCommandService`. Gestionar los flujos de registro de edge gateways, registro de dispositivos IoT y sincronización de datos, coordinando el acceso a los repositorios, la publicación de eventos de integración y la confirmación de cambios mediante la unidad de trabajo. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| uow | IUnitOfWork | private | Unidad de trabajo inyectada para confirmar las transacciones de persistencia. |
| mediator | IMediator | private | Mediator inyectado para publicar eventos de dominio. |
| edgeDeviceRepository | IEdgeDeviceRepository | private | Repositorio inyectado para recuperar y persistir el aggregate `EdgeDevice`. |
| iotDeviceRepository | IIotDeviceRepository | private | Repositorio inyectado para recuperar y persistir las entidades `IotDevice`. |
| edgeRegistryRepository | IEdgeRegistryRepository | private | Repositorio inyectado para recuperar y persistir las entidades `EdgeRegistry`. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle(RegisterEdgeDeviceCommand) | Task | public | Verificar que la MAC del edge gateway no esté registrada, crear un nuevo `EdgeDevice` y persistirlo. Lanza `InvalidOperationException` si el gateway ya existe. |
| Handle(RegisterIotDeviceCommand) | Task | public | Verificar que el edge gateway exista, que el dispositivo IoT no esté registrado y que no exista una vinculación previa. Crear el `EdgeRegistry` y el `IotDevice`, persistirlos y publicar `IotDeviceRegisteredEvent`. |
| Handle(EdgeSynchronizationCommand) | Task | public | Verificar que el edge gateway exista, publicar `IotDeviceSynchronizationEvent`, invocar `SynchronizeEdgeData()` en el aggregate y persistir el cambio. |

---

##### 2. EdgeSynchronizationService

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationService |
| **Categoría** | Domain Service |
| **Propósito** | Implementar `IEdgeSynchronizationService`. Contener la lógica de dominio para el ordenamiento cronológico de las lecturas acumuladas en el edge gateway durante la sincronización. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| MapReadingsToChronologicalOrder | List\<SensorReadingPayload\> | public | Ordenar la lista de lecturas recibida por `MeasuredAt` de forma ascendente. |

---

##### 3. DeviceStatusQueryService

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceStatusQueryService |
| **Categoría** | Query Service |
| **Propósito** | Implementar `IDeviceStatusQueryService`. Gestionar las consultas de estado de conectividad, registro de dispositivos y listado de gateways, retornando los agregados y entidades para que la Interface Layer construya los recursos de respuesta. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| deviceRepository | IEdgeDeviceRepository | private | Repositorio inyectado para recuperar el aggregate `EdgeDevice`. |
| edgeRegistryRepository | IEdgeRegistryRepository | private | Repositorio inyectado para recuperar las entidades `EdgeRegistry`. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle(ConnectiviyStatusQuery) | Task\<EdgeDevice\> | public | Recuperar el edge gateway por dirección MAC y retornarlo. Lanza `KeyNotFoundException` si no existe. |
| Handle(EdgeRegistryQuery) | Task\<Tuple\<EdgeDevice, List\<EdgeRegistry\>\>\> | public | Recuperar el edge gateway y su lista de registros de vinculación. Lanza `KeyNotFoundException` si el gateway no existe. |
| Handle(GetAllEdgeGatewaysQuery) | Task\<IEnumerable\<EdgeDevice\>\> | public | Retornar todos los edge gateways registrados en la base de datos. |

#### 4.2.1.4. Infrastructure Layer

La **Infrastructure Layer** del bounded context **IoT Device Management** agrupa las clases que materializan las abstracciones de persistencia definidas en la Domain Layer. Se apoya en Entity Framework Core (EFC) con acceso al `AppDbContext` compartido, implementando las interfaces de repositorio para operar sobre la base de datos relacional de la plataforma. Las tablas utilizan snake_case: `edge_devices`, `iot_devices` y `edge_registries`.

---

##### 1. EdgeDeviceRepository

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeDeviceRepository |
| **Categoría** | Repository Implementation |
| **Propósito** | Implementar `IEdgeDeviceRepository` utilizando Entity Framework Core. Extiende `BaseRepository<EdgeDevice>`, que provee las operaciones CRUD genéricas, y añade la búsqueda por dirección MAC. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Context | AppDbContext | protected | Contexto de base de datos de Entity Framework Core heredado de `BaseRepository<EdgeDevice>`. Proporciona acceso al `DbSet<EdgeDevice>` utilizado para las consultas y operaciones de persistencia. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByMacAddress | Task\<EdgeDevice?\> | public | Ejecutar una consulta asíncrona sobre el `DbSet<EdgeDevice>` para retornar el primer gateway cuyo `MacAddress` coincida con el valor recibido, o `null` si no existe. |

**Métodos heredados de BaseRepository\<EdgeDevice\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar el aggregate `EdgeDevice` al contexto de EFC para su posterior persistencia. |
| FindByIdAsync | Task\<EdgeDevice?\> | public | Recuperar un edge gateway por su clave primaria (`Id`). |
| Update | void | public | Marcar el aggregate como modificado en el contexto de EFC. |
| Remove | void | public | Marcar el aggregate para su eliminación en el contexto de EFC. |
| ListAsync | Task\<IEnumerable\<EdgeDevice\>\> | public | Retornar todos los edge gateways registrados en la base de datos. |

---

##### 2. IotDeviceRepository

| Campo | Detalle |
|---|---|
| **Nombre** | IotDeviceRepository |
| **Categoría** | Repository Implementation |
| **Propósito** | Implementar `IIotDeviceRepository` utilizando Entity Framework Core. Extiende `BaseRepository<IotDevice>`, que provee las operaciones CRUD genéricas, y añade la búsqueda por dirección MAC. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Context | AppDbContext | protected | Contexto de base de datos de Entity Framework Core heredado de `BaseRepository<IotDevice>`. Proporciona acceso al `DbSet<IotDevice>` utilizado para las consultas y operaciones de persistencia. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByMacAddress | Task\<IotDevice?\> | public | Ejecutar una consulta asíncrona sobre el `DbSet<IotDevice>` para retornar el primer dispositivo IoT cuyo `MacAddress` coincida con el valor recibido, o `null` si no existe. |

**Métodos heredados de BaseRepository\<IotDevice\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar la entidad `IotDevice` al contexto de EFC para su posterior persistencia. |
| FindByIdAsync | Task\<IotDevice?\> | public | Recuperar un dispositivo IoT por su clave primaria (`Id`). |
| Update | void | public | Marcar la entidad como modificada en el contexto de EFC. |
| Remove | void | public | Marcar la entidad para su eliminación en el contexto de EFC. |
| ListAsync | Task\<IEnumerable\<IotDevice\>\> | public | Retornar todos los dispositivos IoT registrados en la base de datos. |

---

##### 3. EdgeRegistryRepository

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeRegistryRepository |
| **Categoría** | Repository Implementation |
| **Propósito** | Implementar `IEdgeRegistryRepository` utilizando Entity Framework Core. Extiende `BaseRepository<EdgeRegistry>`, que provee las operaciones CRUD genéricas, y añade métodos de búsqueda por direcciones MAC. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| Context | AppDbContext | protected | Contexto de base de datos de Entity Framework Core heredado de `BaseRepository<EdgeRegistry>`. Proporciona acceso al `DbSet<EdgeRegistry>` utilizado para las consultas y operaciones de persistencia. |

**Métodos propios**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindByEdgeMacAddress | Task\<List\<EdgeRegistry\>\> | public | Ejecutar una consulta asíncrona para retornar todos los registros cuyo `EdgeMacAddress` coincida con el valor recibido. |
| FindByIotDeviceMacAddress | Task\<List\<EdgeRegistry\>\> | public | Ejecutar una consulta asíncrona para retornar todos los registros cuyo `IotDeviceMacAddresses` coincida con el valor recibido. |
| FindByEdgeAndIotMacAddresses | Task\<EdgeRegistry?\> | public | Ejecutar una consulta asíncrona para retornar el primer registro cuyas MACs de edge y de IoT coincidan con los valores recibidos, o `null` si no existe. |

**Métodos heredados de BaseRepository\<EdgeRegistry\>**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| AddAsync | Task | public | Agregar la entidad `EdgeRegistry` al contexto de EFC para su posterior persistencia. |
| FindByIdAsync | Task\<EdgeRegistry?\> | public | Recuperar un registro por su clave primaria (`Id`). |
| Update | void | public | Marcar la entidad como modificada en el contexto de EFC. |
| Remove | void | public | Marcar la entidad para su eliminación en el contexto de EFC. |
| ListAsync | Task\<IEnumerable\<EdgeRegistry\>\> | public | Retornar todos los registros de vinculación en la base de datos. |

#### 4.2.1.5. Bounded Context Software Architecture Component Level Diagrams

Diagrama 1: Component Level — Backend API (ASP.NET Core)  
Este diagrama muestra la arquitectura de componentes del backend del BC-01 IoT Device Management dentro del monolito Smart Palm. Se organiza en servicios de registro, configuración, consulta de estado, monitoreo de conectividad, sincronización con el edge node, validación de suscripción y publicación de eventos de integración.

![BC-01 Component Diagram 1](../assets/img/chapter-4/bc01-component1.png)


Diagrama 2: Component Level — Web Platform (Angular)  
Este diagrama muestra la arquitectura de componentes de la plataforma web para el BC-01 IoT Device Management. Se organiza en servicios orientados a la administración de dispositivos, configuración de parámetros, consulta de estado y monitoreo de sincronización, apoyados por un servicio central de consumo de API y gestión de sesión web.

![BC-01 Component Diagram 2](../assets/img/chapter-4/bc01-component2.png)


Diagrama 3: Component Level — Mobile Application (Flutter)  
Este diagrama muestra la arquitectura de componentes de la aplicación móvil para el BC-01 IoT Device Management. Se organiza en servicios orientados al registro rápido, consulta de estado en campo, configuración básica y revisión de sincronización offline, apoyados por servicios de acceso remoto, sesión móvil y almacenamiento local.

![BC-01 Component Diagram 3](../assets/img/chapter-4/bc01-component3.png)


#### 4.2.1.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.1.6.1. Bounded Context Domain Layer Class Diagrams

![BC-01 Domain Layer Class Diagram](../assets/img/chapter-4/bc-01-domain-layer-class-diagram.png)

##### 4.2.1.6.2. Bounded Context Database Design Diagram

![BC-01 Database Diagram](../assets/img/chapter-4/bc-01-database-diagram.png)
