
# Chapter 04: Solution Software Design

## 4.1 Strategic-Level Domain-Driven Design

El diseño estratégico de Smart Palm aplica Domain-Driven Design como marco de referencia para descomponer el dominio del negocio en contextos delimitados cohesivos, establecer sus relaciones estructurales y definir la arquitectura de software que los soporta. El proceso parte del modelado realizado mediante Big Picture EventStorming en el Capítulo II y avanza hacia una descomposición de nivel de diseño que sustenta las decisiones de arquitectura del backend, el frontend web y el dispositivo IoT que conforman la plataforma.

### 4.1.1 EventStorming

La sesión de Design-Level EventStorming se realizó sobre el dominio modelado previamente en el Big Picture EventStorming, profundizando en los flujos de comandos, políticas, agregados y vistas de lectura para cada subdominio identificado. La sesión tuvo una duración aproximada de noventa minutos y permitió refinar los siete bounded contexts candidatos, identificar las políticas de negocio críticas y establecer las dependencias entre contextos. Se utilizó Miro como herramienta de trabajo colaborativo.

El proceso se estructuró en tres fases. En la primera se identificaron y refinaron los Domain Events del sistema, formulados en tiempo pasado. En la segunda se asociaron los Commands que desencadenan cada evento, los Actors que los ejecutan y los External Systems que participan. En la tercera los eventos se agruparon en bounded contexts con límites derivados de los cambios de estado del proceso de negocio.

Los actores identificados en el tablero son tres: Palm Grower, que ejecuta acciones desde la plataforma web como usuario propietario del cultivo; Agronomist, que ejecuta acciones desde la plataforma web como usuario técnico supervisor; y System, que representa los procesos automáticos que ocurren sin intervención humana directa.

#### Eventos

![Design-Level EventStorming Events](../assets/img/EventStorming/events.jpg)

#### Commandos

![Design-Level EventStorming Commands](../assets/img/EventStorming/commands.jpg)

#### Actores principales

![Design-Level EventStorming Actors](../assets/img/EventStorming/actors.jpg)

#### URL

El event storming se realizo en Miro mediante el siguiente url: 
[Miro Board](https://miro.com/app/board/uXjVHdJ_3Wo=/?share_link_id=547546845690)

#### 4.1.1.1 Candidate Context Discovery


La sesión de Candidate Context Discovery se realizó sobre el tablero de Design-Level EventStorming en Miro. El proceso consistió en recorrer la línea temporal de eventos de izquierda a derecha aplicando la técnica *look-for-pivotal-events*, identificando aquellos eventos que señalan un cambio de responsabilidad entre partes del dominio: lo que ocurre antes del evento pertenece a un contexto distinto de lo que ocurre después.

Complementariamente se aplicó la técnica *start-with-value* para validar que los contextos identificados como Core Domain concentraban las capacidades de mayor valor para el negocio: el procesamiento del dato sensorial, la recomendación agronómica calibrada para palma aceitera amazónica y la gestión técnica de campo del Agronomist.

##### Eventos pivote identificados

**`DeviceRegistered`**
Marca el límite entre la gestión del ciclo de vida del dispositivo físico y el procesamiento de los datos que ese dispositivo produce. Todo lo relacionado con registrar y configurar el dispositivo pertenece a un contexto; todo lo relacionado con recibir y procesar sus lecturas pertenece a otro.

![Design-Level EventStorming pivote 1](../assets/img/EventStorming/pivote_bc1_bc2.jpg)


**`ThresholdExceeded`**
Marca el límite entre el procesamiento de datos sensoriales y la gestión de alertas. Es el evento de mayor impacto operativo porque desencadena la respuesta hacia los usuarios.


![Design-Level EventStorming Pivote 2](../assets/img/EventStorming/pivote_bc2_bc3.jpg)

**`AlertAcknowledged`**
Marca el límite entre la gestión de alertas y la generación de recomendaciones agronómicas. Una alerta reconocida puede o no derivar en una recomendación — esa decisión pertenece a un contexto distinto con su propia lógica.

![Design-Level EventStorming Pivote 3](../assets/img/EventStorming/pivote_bc3_bc4.jpg)

**`RecommendationPublished`**
Marca el límite entre la generación de recomendaciones y su consumo para visualización. Una vez publicada, la recomendación pasa a ser un dato de solo lectura para el frontend.

![Design-Level EventStorming Pivote 4](../assets/img/EventStorming/pivote_bc4_bc5.jpg)

**`FieldInspectionRegistered`**
Marca el límite entre la gestión de la supervisión técnica del Agronomist y la generación de recomendaciones derivadas de esa inspección. La inspección pertenece al dominio del trabajo de campo; la recomendación que genera pertenece al dominio agronómico.

![Design-Level EventStorming Pivote 5](../assets/img/EventStorming/pivote_bc6_bc4.jpg)

**`SubscriptionActivated`**
Marca el límite entre la gestión comercial del usuario y el inicio de la operación del sistema. La activación de la suscripción habilita directamente el registro del dispositivo IoT en BC-01, a partir del cual el resto del sistema entra en operación de forma natural.

![Design-Level EventStorming Pivote 6](../assets/img/EventStorming/pivote_bc7_all.jpg)

##### Bounded contexts resultantes

| ID    | Bounded Context                  | Clasificación      | Responsabilidad central |
|-------|----------------------------------|--------------------|-------------------------|
| BC-01 | IoT Device Management            | Core Domain        | Ciclo de vida del dispositivo IoT en campo y operación offline mediante edge computing. |
| BC-02 | Sensor Data Processing           | Core Domain        | Recepción, validación, normalización y evaluación agronómica de lecturas sensoriales. |
| BC-03 | Alert & Notification             | Supporting Domain  | Generación, clasificación y despacho de alertas por umbral agronómico superado. |
| BC-04 | Agronomic Recommendation         | Core Domain        | Generación, aprobación y publicación de recomendaciones agronómicas por IA y por el Agronomist. |
| BC-05 | Crop Monitoring Dashboard        | Supporting Domain  | Vistas de lectura consolidadas del estado del cultivo para Palm Grower y Agronomist en la plataforma web. |
| BC-06 | Field Technical Management       | Core Domain        | Ciclo de supervisión técnica del Agronomist: visitas, inspecciones e intervenciones agronómicas. |
| BC-07 | Subscription & User Management   | Generic Subdomain  | Autenticación, autorización, perfiles y gestión de planes de suscripción. |

![Design-Level EventStorming Bounded 1](../assets/img/EventStorming/bc_01.jpg)
![Design-Level EventStorming Bounded 2](../assets/img/EventStorming/bc_02.jpg)
![Design-Level EventStorming Bounded 3](../assets/img/EventStorming/bc_03.jpg)
![Design-Level EventStorming Bounded 4](../assets/img/EventStorming/bc_04.jpg)
![Design-Level EventStorming Bounded 5](../assets/img/EventStorming/bc_05.jpg)
![Design-Level EventStorming Bounded 6](../assets/img/EventStorming/bc_06.jpg)
![Design-Level EventStorming Bounded 7](../assets/img/EventStorming/bc_07.jpg)

#### 4.1.1.2 Domain Message Flows Modeling.


El modelado de flujos de mensajes entre bounded contexts se realizó mediante la técnica de Domain Storytelling, con el objetivo de visualizar cómo los contextos colaboran para resolver los casos de uso más críticos del negocio de Smart Palm. Se modelaron tres flujos principales que cubren los escenarios de mayor valor para los dos segmentos de usuario.

##### Flujo 1 — Detección de condición de riesgo y generación de recomendación

El dispositivo IoT registra una lectura sensorial y la envía al backend mediante HTTP. BC-02 Sensor Data Processing la recibe, la valida y la normaliza. Al evaluar la lectura contra los umbrales agronómicos calibrados para palma aceitera amazónica, detecta que el valor supera el límite definido y publica el evento `ThresholdExceeded`. BC-03 Alert & Notification consume ese evento, genera una alerta, la clasifica por nivel de severidad y la despacha como notificación push al Palm Grower y como alerta visible en la plataforma web para el Agronomist. El evento `AlertTriggered` es consumido opcionalmente por BC-04 Agronomic Recommendation, que genera una recomendación automática mediante el motor de IA. El Agronomist revisa y aprueba la recomendación desde la plataforma web. Una vez aprobada, se publica al Palm Grower. El Palm Grower ejecuta la intervención agronómica indicada y la registra en BC-06 Field Technical Management, cerrando el ciclo de trazabilidad.

![Design-Level EventStorming Message Flow 1](../assets/img/EventStorming/candidate_flow_1.jpg)

##### Flujo 2 — Ciclo de supervisión del Agronomist con datos remotos

El Agronomist accede a la plataforma web y consulta BC-05 Crop Monitoring Dashboard para revisar el historial de parámetros sensoriales y las alertas activas de sus plantaciones antes de planificar una visita de campo. Con esa información, registra la planificación de la visita en BC-06 Field Technical Management. Durante la inspección presencial, registra sus observaciones directamente desde la plataforma web y las vincula a las alertas activas correspondientes. El evento `FieldInspectionRegistered` dispara la generación de una recomendación formal en BC-04 Agronomic Recommendation. El Agronomist la revisa, aprueba y publica. BC-05 Crop Monitoring Dashboard genera automáticamente un borrador de reporte técnico que el Agronomist revisa y publica hacia el Palm Grower.

![Design-Level EventStorming Message Flow 2](../assets/img/EventStorming/candidate_flow_2.jpg)

##### Flujo 3 — Activación de suscripción e inicio de operación

Un Palm Grower se registra en la plataforma web y selecciona un plan de suscripción en BC-07 Subscription & User Management. El pago se procesa a través del Payment Gateway externo. Al confirmarse el pago, el sistema activa la suscripción y publica el evento `SubscriptionActivated`. BC-01 IoT Device Management consume ese evento y habilita el registro del dispositivo IoT asociado a la plantación del usuario. Una vez registrado y configurado el dispositivo, comienza la transmisión de lecturas hacia BC-02 Sensor Data Processing, poniendo en operación el Flujo 1.

![Design-Level EventStorming Message Flow 3](../assets/img/EventStorming/candidate_flow_3.jpg)

#### 4.1.1.3 Bounded Context Canvases.


A continuación se presentan los Bounded Context Canvases elaborados para cada uno de los siete bounded contexts identificados, se denotan todos los ambitos necesarios como Ubiquitous Language, IN-OUT Dependencies y demas puntos necesarios para construir el canvas.

##### BC-01: IoT Device Management

| Campo | Detalle |
|---|---|
| **Nombre** | IoT Device Management |
| **Descripción** | Gestiona el ciclo de vida completo de los dispositivos IoT de Smart Palm: registro, configuración de parámetros de muestreo, monitoreo del estado de conectividad, operación autónoma en modo offline mediante edge computing y sincronización de datos acumulados cuando se restablece la conexión. |
| **Rol estratégico** | Core Domain — diferenciador técnico central de la plataforma. |
| **Reglas de negocio** | Un dispositivo debe estar asociado a exactamente una Monitoring Zone activa. En modo offline el Edge Node almacena lecturas localmente. El período máximo de almacenamiento offline es de 72 horas. La sincronización se realiza en orden cronológico al restablecer conexión. El registro de un dispositivo requiere suscripción activa verificada en BC-07. |
| **Ubiquitous Language** | Device, Edge Node, Monitoring Zone, Sensor Reading, Offline Mode, Synchronization, Device Health Status. |
| **Capabilities** | Registrar dispositivo, configurar parámetros de muestreo, monitorear conectividad, activar modo offline, sincronizar datos acumulados, dar de baja dispositivo. |
| **Dependencias entrantes** | BC-07 Subscription & User Management — valida suscripción activa antes de permitir registro de dispositivo. |
| **Dependencias salientes** | BC-02 Sensor Data Processing — publica `SensorReadingRecorded` tras cada lectura o sincronización. |

---

##### BC-02: Sensor Data Processing

| Campo | Detalle |
|---|---|
| **Nombre** | Sensor Data Processing |
| **Descripción** | Recibe, valida, normaliza y persiste las lecturas sensoriales provenientes de los dispositivos IoT. Evalúa cada lectura contra los umbrales agronómicos calibrados para palma aceitera en la Amazonia peruana y determina si se debe publicar un evento de alerta. |
| **Rol estratégico** | Core Domain — procesamiento central del dato sensorial que alimenta toda la plataforma. |
| **Reglas de negocio** | Los umbrales agronómicos se definen por parámetro, por tipo de suelo y por fase fenológica del cultivo, calibrados con los parámetros del INIA para la región Ucayali. Una lectura fuera de rango genera el evento `ThresholdExceeded`. Lecturas duplicadas o con marca de tiempo inconsistente son descartadas. |
| **Ubiquitous Language** | Sensor Reading, Agronomic Threshold, ThresholdExceeded, Crop Health Status, Normalization, Validation. |
| **Capabilities** | Recibir lectura sensorial, validar integridad del dato, evaluar umbral agronómico, persistir serie temporal, publicar evento de umbral superado. |
| **Dependencias entrantes** | BC-01 IoT Device Management — `SensorReadingRecorded`. |
| **Dependencias salientes** | BC-03 Alert & Notification — `ThresholdExceeded`. BC-05 Crop Monitoring Dashboard — series temporales normalizadas para visualización. |

---

##### BC-03: Alert & Notification

| Campo | Detalle |
|---|---|
| **Nombre** | Alert & Notification |
| **Descripción** | Genera, clasifica y despacha alertas cuando una lectura sensorial supera un umbral agronómico. Gestiona los canales de notificación push hacia el Palm Grower y las alertas visibles en la plataforma web del Agronomist. |
| **Rol estratégico** | Supporting Domain — habilita la respuesta oportuna de los usuarios ante condiciones de riesgo. |
| **Reglas de negocio** | Las alertas se clasifican en tres niveles: informativa, de advertencia y crítica. Una alerta crítica activa notificación push inmediata. Se aplica supresión de alertas duplicadas para un mismo parámetro dentro de una ventana de 30 minutos. |
| **Ubiquitous Language** | Alert, Alert Level, Notification, Push Notification, Alert Suppression, Alert Acknowledgment. |
| **Capabilities** | Generar alerta, clasificar nivel de alerta, despachar notificación push, registrar acuse de recibo, suprimir duplicados. |
| **Dependencias entrantes** | BC-02 Sensor Data Processing — `ThresholdExceeded`. |
| **Dependencias salientes** | BC-04 Agronomic Recommendation — `AlertTriggered` como disparador opcional. BC-05 Crop Monitoring Dashboard — estado de alertas activas. |

---

##### BC-04: Agronomic Recommendation

| Campo | Detalle |
|---|---|
| **Nombre** | Agronomic Recommendation |
| **Descripción** | Gestiona la generación, almacenamiento y comunicación de recomendaciones agronómicas, tanto las producidas automáticamente por el motor de IA calibrado con parámetros del INIA como las redactadas manualmente por el Agronomist. |
| **Rol estratégico** | Core Domain — materializa el valor agronómico diferencial de la plataforma. |
| **Reglas de negocio** | Una recomendación debe estar vinculada a una alerta activa o a una inspección de campo registrada. Las recomendaciones generadas por IA requieren revisión y aprobación del Agronomist antes de ser publicadas al Palm Grower. Una recomendación publicada no puede modificarse; se versiona. |
| **Ubiquitous Language** | Agronomic Recommendation, AI Engine, Recommendation Approval, Recommendation Version, Agronomic Intervention. |
| **Capabilities** | Generar recomendación por IA, redactar recomendación manual, aprobar recomendación, publicar recomendación al Palm Grower, registrar intervención ejecutada. |
| **Dependencias entrantes** | BC-03 Alert & Notification — `AlertTriggered`. BC-06 Field Technical Management — `FieldInspectionRegistered`. |
| **Dependencias salientes** | BC-05 Crop Monitoring Dashboard — recomendaciones publicadas para visualización. |

---

##### BC-05: Crop Monitoring Dashboard

| Campo | Detalle |
|---|---|
| **Nombre** | Crop Monitoring Dashboard |
| **Descripción** | Provee las vistas de lectura consolidadas del estado del cultivo para ambos segmentos de usuario desde la plataforma web. Para el Palm Grower ofrece el Crop Health Status actual, el historial de parámetros y las alertas y recomendaciones activas. Para el Agronomist ofrece el dashboard multi-plantación, el historial de series temporales y la generación asistida de reportes técnicos. |
| **Rol estratégico** | Supporting Domain — interfaz principal de consumo de información de la plataforma. |
| **Reglas de negocio** | Este contexto es de solo lectura; no modifica estado del dominio. El Crop Health Status se calcula a partir del conjunto de parámetros sensoriales activos y se expresa en tres estados: óptimo, en riesgo o crítico. |
| **Ubiquitous Language** | Crop Health Status, Dashboard, Technical Report, Monitoring View, Time Series, Multi-plantation View. |
| **Capabilities** | Mostrar Crop Health Status actual, visualizar series temporales de parámetros, listar alertas activas, listar recomendaciones publicadas, generar borrador de reporte técnico, publicar reporte técnico. |
| **Dependencias entrantes** | BC-02 Sensor Data Processing, BC-03 Alert & Notification, BC-04 Agronomic Recommendation, BC-06 Field Technical Management. |
| **Dependencias salientes** | Ninguna — contexto de solo lectura. |

---

##### BC-06: Field Technical Management

| Campo | Detalle |
|---|---|
| **Nombre** | Field Technical Management |
| **Descripción** | Gestiona el ciclo de supervisión técnica del Agronomist: planificación de visitas de campo, registro de observaciones durante la inspección presencial, vinculación de observaciones a alertas activas y trazabilidad de las intervenciones agronómicas ejecutadas por el Palm Grower. |
| **Rol estratégico** | Core Domain — digitaliza el flujo de trabajo del Agronomist como segundo usuario primario de la plataforma. |
| **Reglas de negocio** | Una Field Inspection debe estar asociada a exactamente una Palm Plantation. El registro de una observación de campo puede vincular una alerta activa existente. Las intervenciones agronómicas registradas por el Palm Grower quedan trazadas contra la recomendación que las originó. |
| **Ubiquitous Language** | Field Inspection, Agronomist Visit, Observation, Agronomic Intervention, Traceability, Field Report. |
| **Capabilities** | Planificar visita de campo, registrar inspección, asociar observación a alerta activa, registrar intervención agronómica, consultar historial de intervenciones por plantación. |
| **Dependencias entrantes** | BC-03 Alert & Notification — alertas activas disponibles para vincular durante la inspección. |
| **Dependencias salientes** | BC-04 Agronomic Recommendation — `FieldInspectionRegistered` como disparador. BC-05 Crop Monitoring Dashboard — historial de inspecciones e intervenciones. |

---

##### BC-07: Subscription & User Management

| Campo | Detalle |
|---|---|
| **Nombre** | Subscription & User Management |
| **Descripción** | Gestiona la autenticación, autorización y perfiles de los usuarios de la plataforma, así como la contratación, activación, renovación y cancelación de los planes de suscripción SaaS de Smart Palm. |
| **Rol estratégico** | Generic Subdomain — infraestructura de soporte transversal a toda la plataforma. |
| **Reglas de negocio** | Un usuario solo puede tener una suscripción activa a la vez. El plan determina el número máximo de hectáreas monitoreables y el conjunto de funcionalidades disponibles. La cancelación de una suscripción revoca el acceso a la plataforma al término del período contratado. |
| **Ubiquitous Language** | Subscription Plan, User Profile, Role, Authentication, Authorization, Plan Activation, Billing Cycle. |
| **Capabilities** | Registrar usuario, autenticar usuario, gestionar roles y permisos, contratar plan, procesar pago, activar suscripción, renovar suscripción, cancelar suscripción. |
| **Dependencias entrantes** | Payment Gateway externo. |
| **Dependencias salientes** | BC-01 IoT Device Management — `SubscriptionActivated` habilita el registro de dispositivos. |


