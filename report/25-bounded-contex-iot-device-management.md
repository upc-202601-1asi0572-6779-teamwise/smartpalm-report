
## 4.2. Tactical-Level Domain-Driven Design

En esta sección se desarrolla la perspectiva táctica del diseño de la solución SmartPalm IoT, tomando como base los bounded contexts identificados previamente en el diseño estratégico. El propósito de este nivel es describir con mayor detalle la organización interna de cada bounded context, especificando las clases, responsabilidades, capas y componentes que permiten materializar su lógica de negocio dentro de la arquitectura de software propuesta.

### 4.2.1. Bounded Context: IoT Device Management

El bounded context **IoT Device Management** se encarga de gestionar el ciclo de vida de los dispositivos IoT desplegados en campo dentro de la solución SmartPalm IoT. Su responsabilidad principal es administrar el registro, configuración, activación, desactivación, monitoreo de conectividad y sincronización de datos de los nodos IoT multisensor ubicados en microzonas del cultivo de palma aceitera.

#### 4.2.1.1. Domain Layer

La **Domain Layer** del bounded context **IoT Device Management** representa el núcleo del dominio encargado de gestionar el ciclo de vida de los dispositivos IoT desplegados en campo. En esta capa se ubican las clases que modelan las reglas de negocio relacionadas con el registro del dispositivo, su configuración operativa, el control de conectividad, la activación de modo offline y la sincronización de datos acumulados cuando la conexión se restablece.

Para este bounded context, el dominio se encuentra compuesto por una entidad principal que actúa como *aggregate root*, complementada por un objeto de valor, enumeraciones, una interfaz de repositorio, una *factory* y un *domain service*. Esta organización permite representar de forma clara la lógica de negocio del contexto sin mezclarla con detalles de infraestructura o persistencia.

---

##### 1. IoTDevice

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDevice |
| **Categoría** | Entity / Aggregate Root |
| **Propósito** | Representar al dispositivo IoT desplegado en una microzona del cultivo y gestionar su ciclo de vida dentro del bounded context. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DeviceId | UUID | private | Identificador único del dispositivo. |
| SerialNumber | string | private | Número de serie o código único del dispositivo físico. |
| MonitoringZoneId | UUID | private | Identificador de la microzona del cultivo asociada al dispositivo. |
| ActivationStatus | ActivationStatus | private | Estado de activación del dispositivo. |
| ConnectivityStatus | ConnectivityStatus | private | Estado actual de conectividad del dispositivo. |
| HealthStatus | DeviceHealthStatus | private | Estado general de salud del dispositivo en campo. |
| Configuration | DeviceConfiguration | private | Configuración operativa del dispositivo. |
| LastSyncAt | datetime | private | Fecha y hora de la última sincronización de datos. |
| CreatedAt | datetime | private | Fecha y hora de registro del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Register | void | public | Registrar un nuevo dispositivo en el sistema. |
| ConfigureSamplingParameters | void | public | Configurar los parámetros de muestreo del dispositivo. |
| Deactivate | void | public | Desactivar el dispositivo para detener su operación. |
| ActivateOfflineMode | void | public | Cambiar el dispositivo a modo offline ante pérdida de conectividad. |
| RestoreConnectivity | void | public | Restablecer el estado de conectividad del dispositivo. |
| SynchronizeEdgeData | void | public | Registrar la sincronización de los datos almacenados localmente en el edge node. |

---

##### 2. DeviceConfiguration

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceConfiguration |
| **Categoría** | Value Object |
| **Propósito** | Almacenar la configuración operativa del dispositivo IoT, especialmente los parámetros de muestreo y comportamiento de transmisión. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| SamplingIntervalMinutes | int | private | Intervalo de tiempo, en minutos, entre cada lectura del dispositivo. |
| TransmissionMode | string | private | Modo de transmisión o preparación de datos del dispositivo. |
| RetryPolicy | string | private | Política de reintentos aplicada cuando existe falla de conectividad. |
| MaxOfflineStorageHours | int | private | Cantidad máxima de horas que el dispositivo puede almacenar datos localmente en modo offline. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Validate | bool | public | Validar que la configuración sea consistente y permitida. |
| UpdateSamplingInterval | void | public | Actualizar el intervalo de muestreo del dispositivo. |
| UpdateTransmissionMode | void | public | Actualizar el modo de transmisión de datos. |
| UpdateRetryPolicy | void | public | Actualizar la política de reintentos del dispositivo. |

---

##### 3. ConnectivityStatus

| Campo | Detalle |
|---|---|
| **Nombre** | ConnectivityStatus |
| **Categoría** | Enumeration |
| **Propósito** | Representar los posibles estados de conectividad del dispositivo IoT. |

**Valores**

| Nombre | Descripción |
|---|---|
| Connected | El dispositivo mantiene conectividad con la plataforma. |
| Disconnected | El dispositivo ha perdido la conectividad, pero aún no se ha confirmado la operación offline. |
| OfflineMode | El dispositivo opera en modo offline y almacena datos localmente. |

---

##### 4. DeviceHealthStatus

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceHealthStatus |
| **Categoría** | Enumeration |
| **Propósito** | Representar el estado general de salud del dispositivo IoT en campo. |

**Valores**

| Nombre | Descripción |
|---|---|
| Healthy | El dispositivo opera con normalidad. |
| Warning | El dispositivo presenta una condición que requiere atención. |
| Critical | El dispositivo presenta una condición crítica que compromete su operación. |

---

##### 5. ActivationStatus

| Campo | Detalle |
|---|---|
| **Nombre** | ActivationStatus |
| **Categoría** | Enumeration |
| **Propósito** | Representar el estado de activación del dispositivo dentro del sistema. |

**Valores**

| Nombre | Descripción |
|---|---|
| Active | El dispositivo está habilitado para operar. |
| Inactive | El dispositivo ha sido desactivado. |

---

##### 6. IoTDeviceRepository

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDeviceRepository |
| **Categoría** | Repository |
| **Propósito** | Abstraer la persistencia de los dispositivos IoT gestionados por el bounded context. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindById | IoTDevice | public | Buscar un dispositivo por su identificador. |
| FindBySerialNumber | IoTDevice | public | Buscar un dispositivo por su número de serie. |
| Save | void | public | Persistir un nuevo dispositivo. |
| Update | void | public | Actualizar el estado o configuración de un dispositivo existente. |
| Remove | void | public | Eliminar o dar de baja lógica a un dispositivo. |

---

##### 7. IoTDeviceFactory

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDeviceFactory |
| **Categoría** | Factory |
| **Propósito** | Crear nuevas instancias válidas de la entidad IoTDevice con sus configuraciones iniciales. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Create | IoTDevice | public | Crear una nueva instancia de dispositivo IoT. |
| CreateWithDefaultConfiguration | IoTDevice | public | Crear un nuevo dispositivo con una configuración inicial por defecto. |

---

##### 8. EdgeSynchronizationService

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationService |
| **Categoría** | Domain Service |
| **Propósito** | Gestionar la lógica de negocio asociada a la sincronización de datos acumulados en el edge node cuando la conectividad es restaurada. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ValidateSynchronization | bool | public | Validar si el dispositivo cumple las condiciones para sincronizar datos acumulados. |
| SynchronizeStoredData | void | public | Ejecutar la sincronización lógica de los datos almacenados localmente. |
| VerifyChronologicalOrder | bool | public | Verificar que los datos acumulados se procesen en orden cronológico. |

#### 4.2.1.2. Interface Layer

La **Interface Layer** del bounded context **IoT Device Management** agrupa las clases encargadas de recibir solicitudes, eventos o mensajes provenientes de actores externos y derivarlos hacia la capa de aplicación. Su función principal es actuar como punto de entrada del bounded context, validando la estructura de los datos de entrada y canalizando correctamente las operaciones relacionadas con el ciclo de vida del dispositivo IoT.

En este bounded context, la capa de interfaz se encuentra compuesta principalmente por clases del tipo **Controller** y **Consumer**, ya que la interacción puede provenir tanto de solicitudes HTTP como de eventos o mensajes relacionados con la conectividad y sincronización del dispositivo.

---

##### 1. IoTDeviceController

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDeviceController |
| **Categoría** | Controller |
| **Propósito** | Exponer endpoints HTTP para las operaciones principales del bounded context, relacionadas con el registro, configuración, consulta y desactivación de dispositivos IoT. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DeviceApplicationService | DeviceApplicationService | private | Servicio de aplicación encargado de coordinar los casos de uso del bounded context. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| RegisterDevice | HttpResponse | public | Recibir la solicitud de registro de un nuevo dispositivo IoT. |
| ConfigureSamplingParameters | HttpResponse | public | Recibir la solicitud de configuración de parámetros de muestreo del dispositivo. |
| DeactivateDevice | HttpResponse | public | Recibir la solicitud para desactivar un dispositivo. |
| GetDeviceById | HttpResponse | public | Obtener la información de un dispositivo específico. |
| GetDeviceStatus | HttpResponse | public | Consultar el estado de activación, conectividad y salud de un dispositivo. |

---

##### 2. ConnectivityEventConsumer

| Campo | Detalle |
|---|---|
| **Nombre** | ConnectivityEventConsumer |
| **Categoría** | Consumer |
| **Propósito** | Recibir eventos o mensajes relacionados con la pérdida o restauración de conectividad del dispositivo IoT y derivarlos hacia la capa de aplicación. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DeviceApplicationService | DeviceApplicationService | private | Servicio de aplicación que procesa los cambios de conectividad del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ConsumeConnectivityLost | void | public | Procesar el evento de pérdida de conectividad del dispositivo. |
| ConsumeConnectivityRestored | void | public | Procesar el evento de restauración de conectividad del dispositivo. |

---

##### 3. EdgeSynchronizationConsumer

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationConsumer |
| **Categoría** | Consumer |
| **Propósito** | Recibir solicitudes o eventos relacionados con la sincronización de datos acumulados desde el edge node hacia la plataforma central. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DeviceApplicationService | DeviceApplicationService | private | Servicio de aplicación que coordina el proceso de sincronización de datos del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ConsumeSynchronizationRequest | void | public | Procesar una solicitud de sincronización de datos acumulados desde el edge node. |
| ConsumeSynchronizationCompleted | void | public | Procesar la confirmación de que la sincronización fue completada. |

---

##### 4. SubscriptionActivatedConsumer

| Campo | Detalle |
|---|---|
| **Nombre** | SubscriptionActivatedConsumer |
| **Categoría** | Consumer |
| **Propósito** | Recibir el evento de activación de suscripción proveniente del bounded context Subscription & User Management para habilitar el registro de dispositivos asociados a una plantación activa. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DeviceApplicationService | DeviceApplicationService | private | Servicio de aplicación que valida y habilita el proceso de registro del dispositivo en función de la suscripción activa. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ConsumeSubscriptionActivated | void | public | Procesar el evento de activación de suscripción relacionado con la habilitación del registro de dispositivos. |

#### 4.2.1.3. Application Layer

La **Application Layer** del bounded context **IoT Device Management** se encarga de coordinar los flujos de negocio asociados al ciclo de vida de los dispositivos IoT. Su responsabilidad principal es recibir las solicitudes derivadas desde la Interface Layer, transformarlas en comandos o eventos de aplicación, y orquestar su ejecución utilizando las clases del dominio correspondientes.

---

##### 1. DeviceApplicationService

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceApplicationService |
| **Categoría** | Application Service |
| **Propósito** | Coordinar los principales casos de uso del bounded context y servir como punto de orquestación entre la Interface Layer y los handlers de aplicación. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| RegisterDeviceCommandHandler | RegisterDeviceCommandHandler | private | Handler encargado del registro de dispositivos. |
| ConfigureSamplingParametersCommandHandler | ConfigureSamplingParametersCommandHandler | private | Handler encargado de la configuración operativa del dispositivo. |
| DeactivateDeviceCommandHandler | DeactivateDeviceCommandHandler | private | Handler encargado de la desactivación lógica del dispositivo. |
| ConnectivityEventHandler | ConnectivityEventHandler | private | Handler encargado de gestionar eventos de conectividad. |
| EdgeSynchronizationCommandHandler | EdgeSynchronizationCommandHandler | private | Handler encargado de coordinar la sincronización de datos acumulados. |
| SubscriptionActivatedEventHandler | SubscriptionActivatedEventHandler | private | Handler encargado de procesar eventos de activación de suscripción relacionados con el registro de dispositivos. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| RegisterDevice | void | public | Coordinar el flujo completo de registro de un nuevo dispositivo. |
| ConfigureDevice | void | public | Coordinar la actualización de los parámetros de configuración del dispositivo. |
| DeactivateDevice | void | public | Coordinar la desactivación de un dispositivo existente. |
| HandleConnectivityChange | void | public | Coordinar el procesamiento de cambios de conectividad. |
| SynchronizeDeviceData | void | public | Coordinar la sincronización de datos acumulados desde el edge node. |

---

##### 2. RegisterDeviceCommandHandler

| Campo | Detalle |
|---|---|
| **Nombre** | RegisterDeviceCommandHandler |
| **Categoría** | Command Handler |
| **Propósito** | Ejecutar el caso de uso de registro de un nuevo dispositivo IoT dentro del sistema. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio para persistir el nuevo dispositivo. |
| IoTDeviceFactory | IoTDeviceFactory | private | Factory que permite crear una instancia válida del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle | void | public | Procesar el comando de registro de dispositivo y persistir la nueva entidad. |

---

##### 3. ConfigureSamplingParametersCommandHandler

| Campo | Detalle |
|---|---|
| **Nombre** | ConfigureSamplingParametersCommandHandler |
| **Categoría** | Command Handler |
| **Propósito** | Ejecutar el caso de uso relacionado con la configuración de parámetros de muestreo del dispositivo IoT. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio para recuperar y actualizar el dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle | void | public | Procesar el comando de actualización de configuración operativa del dispositivo. |

---

##### 4. DeactivateDeviceCommandHandler

| Campo | Detalle |
|---|---|
| **Nombre** | DeactivateDeviceCommandHandler |
| **Categoría** | Command Handler |
| **Propósito** | Ejecutar el caso de uso de desactivación lógica de un dispositivo IoT. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio para recuperar y actualizar el estado del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle | void | public | Procesar el comando que desactiva el dispositivo dentro del sistema. |

---

##### 5. ConnectivityEventHandler

| Campo | Detalle |
|---|---|
| **Nombre** | ConnectivityEventHandler |
| **Categoría** | Event Handler |
| **Propósito** | Gestionar los eventos relacionados con la pérdida o restauración de conectividad del dispositivo IoT. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio para recuperar y actualizar el estado de conectividad del dispositivo. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| HandleConnectivityLost | void | public | Procesar el evento de pérdida de conectividad y activar el modo offline. |
| HandleConnectivityRestored | void | public | Procesar el evento de restauración de conectividad del dispositivo. |

---

##### 6. EdgeSynchronizationCommandHandler

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationCommandHandler |
| **Categoría** | Command Handler |
| **Propósito** | Coordinar el flujo de sincronización de datos acumulados desde el edge node hacia la plataforma central. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio para recuperar la entidad del dispositivo a sincronizar. |
| EdgeSynchronizationService | EdgeSynchronizationService | private | Servicio de dominio que contiene la lógica de sincronización. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle | void | public | Procesar el comando de sincronización de datos acumulados. |

---

##### 7. SubscriptionActivatedEventHandler

| Campo | Detalle |
|---|---|
| **Nombre** | SubscriptionActivatedEventHandler |
| **Categoría** | Event Handler |
| **Propósito** | Procesar el evento de activación de suscripción proveniente de otro bounded context para habilitar el registro de dispositivos asociados a una plantación activa. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| IoTDeviceRepository | IoTDeviceRepository | private | Repositorio utilizado para verificar la disponibilidad de asociación de dispositivos. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| Handle | void | public | Procesar el evento de activación de suscripción y habilitar el registro de dispositivos correspondientes. |

#### 4.2.1.4. Infrastructure Layer

La **Infrastructure Layer** del bounded context **IoT Device Management** agrupa las clases responsables de la persistencia, integración y comunicación con servicios externos necesarios para soportar el ciclo de vida de los dispositivos IoT. En esta capa se materializan técnicamente las abstracciones definidas en la Domain Layer, permitiendo que el bounded context pueda operar sobre componentes reales de base de datos, mensajería e interoperabilidad con otros bounded contexts.

---

##### 1. IoTDeviceRepositoryImpl

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDeviceRepositoryImpl |
| **Categoría** | Repository Implementation |
| **Propósito** | Implementar la interfaz `IoTDeviceRepository` para persistir y recuperar dispositivos IoT desde la base de datos de la plataforma. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| DataSource | DatabaseConnection | private | Conexión o acceso al motor de base de datos. |
| DeviceMapper | IoTDeviceMapper | private | Componente encargado de mapear entre objetos del dominio y estructuras de persistencia. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| FindById | IoTDevice | public | Recuperar un dispositivo según su identificador. |
| FindBySerialNumber | IoTDevice | public | Recuperar un dispositivo según su número de serie. |
| Save | void | public | Persistir un nuevo dispositivo en la base de datos. |
| Update | void | public | Actualizar la información de un dispositivo existente. |
| Remove | void | public | Ejecutar la baja lógica o eliminación del dispositivo. |

---

##### 2. IoTDeviceMapper

| Campo | Detalle |
|---|---|
| **Nombre** | IoTDeviceMapper |
| **Categoría** | Mapper |
| **Propósito** | Transformar la información entre la representación del dominio (`IoTDevice`) y la representación de persistencia utilizada por la base de datos. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ToDomain | IoTDevice | public | Convertir una estructura de persistencia en una entidad del dominio. |
| ToPersistence | Record | public | Convertir una entidad del dominio en una estructura lista para persistir. |

---

##### 3. SubscriptionValidationClient

| Campo | Detalle |
|---|---|
| **Nombre** | SubscriptionValidationClient |
| **Categoría** | External Service Client |
| **Propósito** | Consultar al bounded context `Subscription & User Management` para validar que la suscripción asociada al dispositivo se encuentre activa antes de permitir su registro. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| ServiceEndpoint | string | private | URL o punto de acceso al servicio externo de validación de suscripción. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ValidateActiveSubscription | bool | public | Verificar si la suscripción asociada al dispositivo o plantación está activa. |

---

##### 4. DeviceEventPublisher

| Campo | Detalle |
|---|---|
| **Nombre** | DeviceEventPublisher |
| **Categoría** | Message Publisher |
| **Propósito** | Publicar eventos de integración generados por el bounded context, de manera que otros bounded contexts puedan continuar el flujo de negocio. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| MessageBrokerClient | MessageBrokerConnection | private | Cliente o conexión al sistema de mensajería utilizado por la plataforma. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| PublishDeviceRegistered | void | public | Publicar el evento de registro de dispositivo. |
| PublishConnectivityRestored | void | public | Publicar el evento de restauración de conectividad. |
| PublishEdgeDataSynchronized | void | public | Publicar el evento relacionado con la sincronización de datos del edge node. |

---

##### 5. EdgeSynchronizationGateway

| Campo | Detalle |
|---|---|
| **Nombre** | EdgeSynchronizationGateway |
| **Categoría** | Integration Gateway |
| **Propósito** | Recibir lotes de datos sincronizados desde el edge node y canalizarlos hacia los componentes internos del bounded context. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| EndpointAddress | string | private | Punto de acceso para recepción de datos sincronizados desde el edge node. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| ReceiveSynchronizationBatch | void | public | Recibir un lote de datos acumulados desde el edge node. |
| ForwardSynchronizationBatch | void | public | Derivar el lote recibido hacia la capa de aplicación para su procesamiento. |

---

##### 6. LocalEdgeStorageAdapter

| Campo | Detalle |
|---|---|
| **Nombre** | LocalEdgeStorageAdapter |
| **Categoría** | Storage Adapter |
| **Propósito** | Gestionar el acceso al almacenamiento local del edge node para los datos acumulados durante el modo offline. |

**Atributos**

| Nombre | Tipo de dato | Visibilidad | Descripción |
|---|---|---|---|
| LocalStoragePath | string | private | Ruta o referencia al almacenamiento local del edge node. |

**Métodos**

| Nombre | Tipo de retorno | Visibilidad | Descripción |
|---|---|---|---|
| StoreOfflineData | void | public | Almacenar datos localmente mientras el dispositivo se encuentra sin conectividad. |
| RetrieveStoredData | List<Record> | public | Recuperar los datos almacenados localmente para su posterior sincronización. |
| ClearSynchronizedData | void | public | Limpiar los datos que ya fueron sincronizados correctamente. |
