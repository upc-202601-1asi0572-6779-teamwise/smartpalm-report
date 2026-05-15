### 4.2.6. Bounded Context: Field Technical Management

Este bounded context se encarga de gestionar las actividades tÃ©cnicas de campo realizadas por el ingeniero agrÃ³nomo: planificaciÃ³n de visitas, registro de inspecciones presenciales, vinculaciÃ³n de observaciones con alertas activas y registro de intervenciones agronÃ³micas con trazabilidad hacia las recomendaciones que las originaron. InteractÃºa con los bounded contexts de Alert & Notification (BC-03) como fuente de alertas activas, Agronomic Recommendation (BC-04) como origen de las recomendaciones que motivan intervenciones, y Crop Monitoring Dashboard (BC-05) como destino de los datos de inspecciÃ³n para visualizaciÃ³n. Incorpora soporte offline para registro de inspecciones en campo sin conectividad, resolviendo el pain point identificado en el EventStorming.

#### 4.2.6.1. Domain Layer

Contiene la lÃ³gica de negocio pura y las entidades principales relacionadas con la planificaciÃ³n de visitas de campo, el registro de inspecciones y observaciones, la vinculaciÃ³n con alertas activas y el registro de intervenciones agronÃ³micas con trazabilidad completa.

---

**Aggregate 1: FieldVisit**

| Nombre     | CategorÃ­a              | DescripciÃ³n                                                                                                                                                                                                                           |
| ---------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FieldVisit | Entity (Aggregate Root) | Representa una visita de campo planificada o ejecutada por el ingeniero agrÃ³nomo a una plantaciÃ³n. Gestiona el ciclo de vida desde la planificaciÃ³n hasta la finalizaciÃ³n, y agrupa las inspecciones realizadas durante la visita. |

**Attributes**

| Nombre        | Tipo de dato            | Visibilidad | DescripciÃ³n                                                          |
| ------------- | ----------------------- | ----------- | --------------------------------------------------------------------- |
| id            | UUID                    | Private     | Identificador Ãºnico de la visita de campo.                           |
| plantationId  | UUID                    | Private     | Identificador de la plantaciÃ³n a visitar.                            |
| agronomistId  | UUID                    | Private     | Identificador del agrÃ³nomo responsable de la visita.                 |
| scheduledDate | LocalDate               | Private     | Fecha planificada para la visita.                                     |
| actualDate    | LocalDate               | Private     | Fecha real en que se ejecutÃ³ la visita (null si aÃºn no se ejecuta). |
| status        | VisitStatus (enum)      | Private     | Estado de la visita: PLANNED, IN_PROGRESS, COMPLETED, CANCELLED.      |
| objectives    | String                  | Private     | Objetivos de la visita definidos por el agrÃ³nomo.                    |
| inspections   | List\<FieldInspection\> | Private     | Lista de inspecciones registradas durante la visita.                  |
| createdAt     | LocalDateTime           | Private     | Fecha de creaciÃ³n del registro.                                      |
| completedAt   | LocalDateTime           | Private     | Fecha de finalizaciÃ³n de la visita.                                  |

**Methods**

| Nombre                                     | Tipo de retorno | Visibilidad | DescripciÃ³n                                                                                      |
| ------------------------------------------ | --------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| start()                                    | Void            | Public      | Inicia la visita cambiando su estado de PLANNED a IN_PROGRESS y registra la fecha actual.         |
| complete()                                 | Void            | Public      | Finaliza la visita cambiando su estado a COMPLETED. Requiere al menos una inspecciÃ³n registrada. |
| cancel(reason: String)                     | Void            | Public      | Cancela la visita. Solo permitido en estado PLANNED.                                              |
| addInspection(inspection: FieldInspection) | Void            | Public      | Agrega una inspecciÃ³n a la visita. Solo permitido en estado IN_PROGRESS.                         |
| hasInspections()                           | Boolean         | Public      | Indica si la visita tiene inspecciones registradas.                                               |

---

**Aggregate 2: FieldInspection**

| Nombre          | CategorÃ­a              | DescripciÃ³n                                                                                                                                                                                                                                                      |
| --------------- | ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FieldInspection | Entity (Aggregate Root) | Representa una inspecciÃ³n tÃ©cnica realizada por el agrÃ³nomo en una zona de monitoreo durante una visita de campo. Contiene observaciones, evidencia fotogrÃ¡fica y puede vincularse a alertas activas. Soporta registro offline con sincronizaciÃ³n posterior. |

**Attributes**

| Nombre         | Tipo de dato             | Visibilidad | DescripciÃ³n                                                                           |
| -------------- | ------------------------ | ----------- | -------------------------------------------------------------------------------------- |
| id             | UUID                     | Private     | Identificador Ãºnico de la inspecciÃ³n.                                                |
| visitId        | UUID                     | Private     | Identificador de la visita de campo a la que pertenece.                                |
| zoneId         | UUID                     | Private     | Identificador de la zona de monitoreo inspeccionada.                                   |
| plantationId   | UUID                     | Private     | Identificador de la plantaciÃ³n.                                                       |
| agronomistId   | UUID                     | Private     | Identificador del agrÃ³nomo que realizÃ³ la inspecciÃ³n.                               |
| observations   | List\<FieldObservation\> | Private     | Observaciones registradas durante la inspecciÃ³n.                                      |
| inspectedAt    | LocalDateTime            | Private     | Fecha y hora de la inspecciÃ³n en campo.                                               |
| registeredAt   | LocalDateTime            | Private     | Fecha y hora de registro en el sistema (puede diferir de inspectedAt en caso offline). |
| syncStatus     | SyncStatus (enum)        | Private     | Estado de sincronizaciÃ³n: SYNCED, PENDING_SYNC.                                       |
| linkedAlertIds | List\<UUID\>             | Private     | Identificadores de alertas activas vinculadas a esta inspecciÃ³n.                      |

**Methods**

| Nombre                                        | Tipo de retorno | Visibilidad | DescripciÃ³n                                                                           |
| --------------------------------------------- | --------------- | ----------- | -------------------------------------------------------------------------------------- |
| addObservation(observation: FieldObservation) | Void            | Public      | Agrega una observaciÃ³n a la inspecciÃ³n.                                              |
| linkToAlert(alertId: UUID)                    | Void            | Public      | Vincula la inspecciÃ³n a una alerta activa del BC-03.                                  |
| markAsSynced()                                | Void            | Public      | Marca la inspecciÃ³n como sincronizada con el servidor.                                |
| isPendingSync()                               | Boolean         | Public      | Indica si la inspecciÃ³n estÃ¡ pendiente de sincronizaciÃ³n.                           |
| wasRegisteredOffline()                        | Boolean         | Public      | Indica si la inspecciÃ³n fue registrada offline (inspectedAt difiere de registeredAt). |

---

**Value Object: FieldObservation**

| Nombre           | CategorÃ­a   | DescripciÃ³n                                                                             |
| ---------------- | ------------ | ---------------------------------------------------------------------------------------- |
| FieldObservation | Value Object | ObservaciÃ³n tÃ©cnica individual registrada durante una inspecciÃ³n de campo. Inmutable. |

**Attributes**

| Nombre          | Tipo de dato               | Visibilidad | DescripciÃ³n                                                                       |
| --------------- | -------------------------- | ----------- | ---------------------------------------------------------------------------------- |
| description     | String                     | Private     | DescripciÃ³n textual de la observaciÃ³n.                                           |
| category        | ObservationCategory (enum) | Private     | CategorÃ­a: PHYTOSANITARY, SOIL_CONDITION, PLANT_DEVELOPMENT, IRRIGATION, GENERAL. |
| severity        | ObservationSeverity (enum) | Private     | Severidad: LOW, MEDIUM, HIGH.                                                      |
| photoReferences | List\<String\>             | Private     | Referencias a evidencia fotogrÃ¡fica (URLs o IDs de archivos).                     |
| observedAt      | LocalDateTime              | Private     | Momento en que se realizÃ³ la observaciÃ³n.                                        |

---

**Aggregate 3: AgronomicIntervention**

| Nombre                | CategorÃ­a              | DescripciÃ³n                                                                                                                                                                                                                                                               |
| --------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AgronomicIntervention | Entity (Aggregate Root) | Representa una intervenciÃ³n agronÃ³mica ejecutada en una zona o plantaciÃ³n como resultado de una recomendaciÃ³n. Mantiene trazabilidad hacia la recomendaciÃ³n que la originÃ³ y la inspecciÃ³n que la motivÃ³, cerrando el ciclo recomendaciÃ³n â†’ acciÃ³n â†’ registro. |

**Attributes**

| Nombre                 | Tipo de dato              | Visibilidad | DescripciÃ³n                                                                                           |
| ---------------------- | ------------------------- | ----------- | ------------------------------------------------------------------------------------------------------ |
| id                     | UUID                      | Private     | Identificador Ãºnico de la intervenciÃ³n.                                                              |
| plantationId           | UUID                      | Private     | Identificador de la plantaciÃ³n intervenida.                                                           |
| zoneId                 | UUID                      | Private     | Identificador de la zona intervenida (opcional si aplica a toda la plantaciÃ³n).                       |
| registeredBy           | UUID                      | Private     | Identificador del usuario que registrÃ³ la intervenciÃ³n (agrÃ³nomo o dueÃ±o del cultivo).             |
| interventionType       | InterventionType (enum)   | Private     | Tipo: FERTILIZATION, PEST_CONTROL, IRRIGATION_ADJUSTMENT, PRUNING, SOIL_AMENDMENT, OTHER.              |
| description            | String                    | Private     | DescripciÃ³n detallada de la intervenciÃ³n realizada.                                                  |
| originRecommendationId | UUID                      | Private     | Identificador de la recomendaciÃ³n del BC-04 que originÃ³ esta intervenciÃ³n (null si es espontÃ¡nea). |
| originInspectionId     | UUID                      | Private     | Identificador de la inspecciÃ³n que motivÃ³ la intervenciÃ³n (null si no aplica).                      |
| executedAt             | LocalDateTime             | Private     | Fecha y hora de ejecuciÃ³n de la intervenciÃ³n.                                                        |
| registeredAt           | LocalDateTime             | Private     | Fecha y hora de registro en el sistema.                                                                |
| status                 | InterventionStatus (enum) | Private     | Estado: REGISTERED, VERIFIED, REJECTED.                                                                |
| verificationNotes      | String                    | Private     | Notas del agrÃ³nomo al verificar la intervenciÃ³n.                                                     |

**Methods**

| Nombre                    | Tipo de retorno | Visibilidad | DescripciÃ³n                                                            |
| ------------------------- | --------------- | ----------- | ----------------------------------------------------------------------- |
| verify(notes: String)     | Void            | Public      | El agrÃ³nomo verifica que la intervenciÃ³n fue ejecutada correctamente. |
| reject(notes: String)     | Void            | Public      | El agrÃ³nomo rechaza la intervenciÃ³n como incorrecta o insuficiente.   |
| hasOriginRecommendation() | Boolean         | Public      | Indica si la intervenciÃ³n fue originada por una recomendaciÃ³n.        |
| hasOriginInspection()     | Boolean         | Public      | Indica si la intervenciÃ³n fue motivada por una inspecciÃ³n.            |
| isVerified()              | Boolean         | Public      | Indica si la intervenciÃ³n ha sido verificada.                          |

---

**Enumeraciones**

**Enum: VisitStatus**

| CÃ³digo     | DescripciÃ³n                                    |
| ----------- | ----------------------------------------------- |
| PLANNED     | Visita planificada, pendiente de ejecuciÃ³n.    |
| IN_PROGRESS | Visita en curso.                                |
| COMPLETED   | Visita finalizada con inspecciones registradas. |
| CANCELLED   | Visita cancelada antes de su ejecuciÃ³n.        |

**Enum: SyncStatus**

| CÃ³digo      | DescripciÃ³n                                     |
| ------------ | ------------------------------------------------ |
| SYNCED       | Registro sincronizado con el servidor.           |
| PENDING_SYNC | Registro pendiente de sincronizaciÃ³n (offline). |

**Enum: ObservationCategory**

| CÃ³digo           | DescripciÃ³n                                       |
| ----------------- | -------------------------------------------------- |
| PHYTOSANITARY     | ObservaciÃ³n fitosanitaria (plagas, enfermedades). |
| SOIL_CONDITION    | CondiciÃ³n del suelo.                              |
| PLANT_DEVELOPMENT | Desarrollo de la planta.                           |
| IRRIGATION        | Estado del riego.                                  |
| GENERAL           | ObservaciÃ³n general.                              |

**Enum: ObservationSeverity**

| CÃ³digo | DescripciÃ³n                                |
| ------- | ------------------------------------------- |
| LOW     | Severidad baja, informativa.                |
| MEDIUM  | Severidad media, requiere seguimiento.      |
| HIGH    | Severidad alta, requiere acciÃ³n inmediata. |

**Enum: InterventionType**

| CÃ³digo               | DescripciÃ³n                      |
| --------------------- | --------------------------------- |
| FERTILIZATION         | AplicaciÃ³n de fertilizantes.     |
| PEST_CONTROL          | Control de plagas o enfermedades. |
| IRRIGATION_ADJUSTMENT | Ajuste del sistema de riego.      |
| PRUNING               | Poda de plantas.                  |
| SOIL_AMENDMENT        | Enmienda o correcciÃ³n del suelo. |
| OTHER                 | Otro tipo de intervenciÃ³n.       |

**Enum: InterventionStatus**

| CÃ³digo    | DescripciÃ³n                                          |
| ---------- | ----------------------------------------------------- |
| REGISTERED | IntervenciÃ³n registrada, pendiente de verificaciÃ³n. |
| VERIFIED   | IntervenciÃ³n verificada por el agrÃ³nomo.            |
| REJECTED   | IntervenciÃ³n rechazada por el agrÃ³nomo.             |

---

**Domain Services**

| Nombre                          | DescripciÃ³n                                                                                                                                                                                                 |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| InspectionSyncService           | Servicio de dominio que gestiona la lÃ³gica de sincronizaciÃ³n de inspecciones registradas offline. Determina el orden de sincronizaciÃ³n, detecta conflictos y marca los registros como sincronizados.      |
| InterventionTraceabilityService | Servicio de dominio que gestiona la trazabilidad entre intervenciones, recomendaciones e inspecciones. Valida que las referencias cruzadas sean consistentes y construye la cadena de trazabilidad completa. |

---

**Repository Interfaces (Domain contracts)**

| Nombre                          | DescripciÃ³n                                                                                                |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| FieldVisitRepository            | Contrato para persistir y consultar visitas de campo por agrÃ³nomo, plantaciÃ³n y estado.                   |
| FieldInspectionRepository       | Contrato para persistir y consultar inspecciones por visita, zona, plantaciÃ³n y estado de sincronizaciÃ³n. |
| AgronomicInterventionRepository | Contrato para persistir y consultar intervenciones por plantaciÃ³n, zona, tipo y estado de verificaciÃ³n.   |

---

---

#### 4.2.6.2. Interface Layer

Esta capa es responsable de la recepciÃ³n y formato de peticiones/respuestas externas (API REST), validaciÃ³n bÃ¡sica del formato y los datos de entrada, manejo de errores a nivel de API y delegaciÃ³n de la lÃ³gica de negocio a la capa de AplicaciÃ³n. Expone los endpoints consumidos por la plataforma web del agrÃ³nomo y la aplicaciÃ³n mÃ³vil del dueÃ±o del cultivo.

---

**Controller 1: FieldVisitController**

| Nombre               | CategorÃ­a | DescripciÃ³n                                                                                                     |
| -------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------- |
| FieldVisitController | Controller | Controlador para los endpoints de planificaciÃ³n y gestiÃ³n del ciclo de vida de visitas de campo del agrÃ³nomo. |

**Attributes**

| Nombre            | Tipo de dato      | Visibilidad | DescripciÃ³n                                                            |
| ----------------- | ----------------- | ----------- | ----------------------------------------------------------------------- |
| fieldVisitService | FieldVisitService | Private     | Servicio de la capa de AplicaciÃ³n para lÃ³gica de gestiÃ³n de visitas. |
| visitMapper       | FieldVisitMapper  | Private     | Mapper para convertir entre entidades de dominio y DTOs de respuesta.   |

**Endpoints**

| Ruta                                 | MÃ©todo | DescripciÃ³n                                                                                                             |
| ------------------------------------ | ------- | ------------------------------------------------------------------------------------------------------------------------ |
| /api/field/visits                    | POST    | Planifica una nueva visita de campo a una plantaciÃ³n.                                                                   |
| /api/field/visits                    | GET     | Retorna las visitas de campo del agrÃ³nomo autenticado con filtros opcionales por plantaciÃ³n, estado y rango de fechas. |
| /api/field/visits/{visitId}          | GET     | Retorna el detalle de una visita de campo especÃ­fica con sus inspecciones asociadas.                                    |
| /api/field/visits/{visitId}/start    | PUT     | Inicia una visita planificada, cambiando su estado a IN_PROGRESS.                                                        |
| /api/field/visits/{visitId}/complete | PUT     | Finaliza una visita en curso, cambiando su estado a COMPLETED.                                                           |
| /api/field/visits/{visitId}/cancel   | PUT     | Cancela una visita planificada.                                                                                          |

---

**Controller 2: FieldInspectionController**

| Nombre                    | CategorÃ­a | DescripciÃ³n                                                                                                                       |
| ------------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| FieldInspectionController | Controller | Controlador para los endpoints de registro de inspecciones de campo, incluyendo soporte para sincronizaciÃ³n de registros offline. |

**Attributes**

| Nombre                 | Tipo de dato           | Visibilidad | DescripciÃ³n                                                                 |
| ---------------------- | ---------------------- | ----------- | ---------------------------------------------------------------------------- |
| fieldInspectionService | FieldInspectionService | Private     | Servicio de la capa de AplicaciÃ³n para lÃ³gica de gestiÃ³n de inspecciones. |
| inspectionMapper       | FieldInspectionMapper  | Private     | Mapper para convertir entre entidades de dominio y DTOs de respuesta.        |

**Endpoints**

| Ruta                                               | MÃ©todo | DescripciÃ³n                                                                                                    |
| -------------------------------------------------- | ------- | --------------------------------------------------------------------------------------------------------------- |
| /api/field/visits/{visitId}/inspections            | POST    | Registra una nueva inspecciÃ³n de campo dentro de una visita en curso.                                          |
| /api/field/inspections/sync                        | POST    | Sincroniza un lote de inspecciones registradas offline. Acepta una lista de inspecciones con sus observaciones. |
| /api/field/inspections/{inspectionId}              | GET     | Retorna el detalle de una inspecciÃ³n especÃ­fica con sus observaciones y alertas vinculadas.                   |
| /api/field/inspections/{inspectionId}/observations | POST    | Agrega una observaciÃ³n a una inspecciÃ³n existente.                                                            |
| /api/field/inspections/{inspectionId}/link-alert   | POST    | Vincula una inspecciÃ³n a una alerta activa del sistema.                                                        |
| /api/field/plantations/{plantationId}/inspections  | GET     | Retorna el historial de inspecciones de una plantaciÃ³n con filtros opcionales por zona y rango de fechas.      |

---

**Controller 3: AgronomicInterventionController**

| Nombre                          | CategorÃ­a | DescripciÃ³n                                                                                                                                               |
| ------------------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AgronomicInterventionController | Controller | Controlador para los endpoints de registro, verificaciÃ³n y consulta de intervenciones agronÃ³micas con trazabilidad hacia recomendaciones e inspecciones. |

**Attributes**

| Nombre              | Tipo de dato                 | Visibilidad | DescripciÃ³n                                                                   |
| ------------------- | ---------------------------- | ----------- | ------------------------------------------------------------------------------ |
| interventionService | AgronomicInterventionService | Private     | Servicio de la capa de AplicaciÃ³n para lÃ³gica de gestiÃ³n de intervenciones. |
| interventionMapper  | AgronomicInterventionMapper  | Private     | Mapper para convertir entre entidades de dominio y DTOs de respuesta.          |

**Endpoints**

| Ruta                                                | MÃ©todo | DescripciÃ³n                                                                                                     |
| --------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------- |
| /api/field/interventions                            | POST    | Registra una nueva intervenciÃ³n agronÃ³mica en una plantaciÃ³n o zona.                                          |
| /api/field/interventions/{interventionId}           | GET     | Retorna el detalle de una intervenciÃ³n especÃ­fica con su trazabilidad completa.                                |
| /api/field/interventions/{interventionId}/verify    | PUT     | El agrÃ³nomo verifica que la intervenciÃ³n fue ejecutada correctamente.                                          |
| /api/field/interventions/{interventionId}/reject    | PUT     | El agrÃ³nomo rechaza la intervenciÃ³n como incorrecta o insuficiente.                                            |
| /api/field/plantations/{plantationId}/interventions | GET     | Retorna el historial de intervenciones de una plantaciÃ³n con filtros por zona, tipo, estado y rango de fechas.  |
| /api/field/plantations/{plantationId}/traceability  | GET     | Retorna la cadena de trazabilidad completa: recomendaciÃ³n â†’ inspecciÃ³n â†’ intervenciÃ³n para una plantaciÃ³n. |

---

**DTOs**

| Nombre                               | DescripciÃ³n                                                                                                                                                                                                                                                       |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| PlanFieldVisitRequestDto             | { plantationId: UUID, scheduledDate: LocalDate, objectives: String }                                                                                                                                                                                               |
| FieldVisitResponseDto                | { id: UUID, plantationId: UUID, agronomistId: UUID, scheduledDate: LocalDate, actualDate: LocalDate, status: String, objectives: String, inspectionCount: Integer, createdAt: DateTime, completedAt: DateTime }                                                    |
| FieldVisitListResponseDto            | { visits: List\<FieldVisitResponseDto\>, totalCount: Integer }                                                                                                                                                                                                     |
| CancelVisitRequestDto                | { reason: String }                                                                                                                                                                                                                                                 |
| RegisterInspectionRequestDto         | { zoneId: UUID, observations: List\<FieldObservationDto\>, inspectedAt: DateTime, linkedAlertIds: List\<UUID\> }                                                                                                                                                   |
| SyncInspectionsRequestDto            | { inspections: List\<RegisterInspectionRequestDto\>, visitId: UUID }                                                                                                                                                                                               |
| SyncInspectionsResponseDto           | { syncedCount: Integer, failedCount: Integer, failedIds: List\<UUID\>, syncedAt: DateTime }                                                                                                                                                                        |
| FieldInspectionResponseDto           | { id: UUID, visitId: UUID, zoneId: UUID, plantationId: UUID, agronomistId: UUID, observations: List\<FieldObservationDto\>, inspectedAt: DateTime, registeredAt: DateTime, syncStatus: String, linkedAlertIds: List\<UUID\>, wasOffline: Boolean }                 |
| FieldInspectionListResponseDto       | { inspections: List\<FieldInspectionResponseDto\>, totalCount: Integer }                                                                                                                                                                                           |
| FieldObservationDto                  | { description: String, category: String, severity: String, photoReferences: List\<String\>, observedAt: DateTime }                                                                                                                                                 |
| AddObservationRequestDto             | { description: String, category: String, severity: String, photoReferences: List\<String\> }                                                                                                                                                                       |
| LinkAlertRequestDto                  | { alertId: UUID }                                                                                                                                                                                                                                                  |
| RegisterInterventionRequestDto       | { plantationId: UUID, zoneId: UUID, interventionType: String, description: String, originRecommendationId: UUID, originInspectionId: UUID, executedAt: DateTime }                                                                                                  |
| VerifyInterventionRequestDto         | { verificationNotes: String }                                                                                                                                                                                                                                      |
| RejectInterventionRequestDto         | { verificationNotes: String }                                                                                                                                                                                                                                      |
| AgronomicInterventionResponseDto     | { id: UUID, plantationId: UUID, zoneId: UUID, registeredBy: UUID, interventionType: String, description: String, originRecommendationId: UUID, originInspectionId: UUID, executedAt: DateTime, registeredAt: DateTime, status: String, verificationNotes: String } |
| AgronomicInterventionListResponseDto | { interventions: List\<AgronomicInterventionResponseDto\>, totalCount: Integer }                                                                                                                                                                                   |
| TraceabilityChainResponseDto         | { plantationId: UUID, chains: List\<TraceabilityItemDto\> }                                                                                                                                                                                                        |
| TraceabilityItemDto                  | { recommendationId: UUID, recommendationContent: String, inspectionId: UUID, inspectedAt: DateTime, interventionId: UUID, interventionType: String, interventionStatus: String, executedAt: DateTime }                                                             |

---

---

#### 4.2.6.3. Application Layer

En la capa de Application Layer se ubican los servicios que orquestan los casos de uso del bounded context Field Technical Management. Estos servicios coordinan la lÃ³gica de negocio delegando a las entidades y servicios de dominio, gestionan transacciones y actÃºan como intermediarios entre la capa de Interface y la capa de Domain.

---

**Service 1: FieldVisitService**

| Nombre            | CategorÃ­a          | DescripciÃ³n                                                                                                                         |
| ----------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| FieldVisitService | Application Service | Servicio de aplicaciÃ³n responsable de los casos de uso de planificaciÃ³n, inicio, finalizaciÃ³n y cancelaciÃ³n de visitas de campo. |

**Dependencies**

| Nombre                    | Tipo de Objeto            | Visibilidad | DescripciÃ³n                                                    |
| ------------------------- | ------------------------- | ----------- | --------------------------------------------------------------- |
| fieldVisitRepository      | FieldVisitRepository      | Private     | Acceso a la persistencia de visitas de campo.                   |
| fieldInspectionRepository | FieldInspectionRepository | Private     | Acceso a inspecciones para validar requisitos de finalizaciÃ³n. |
| visitMapper               | FieldVisitMapper          | Private     | Mapper para convertir entre entidades de dominio y DTOs.        |

**Methods**

| Nombre                                                  | Tipo de retorno           | Visibilidad | DescripciÃ³n                                              |
| ------------------------------------------------------- | ------------------------- | ----------- | --------------------------------------------------------- |
| planVisit(PlanVisitCommand command)                     | FieldVisitResponseDto     | Public      | Planifica una nueva visita de campo a una plantaciÃ³n.    |
| getVisitsByAgronomist(GetVisitsByAgronomistQuery query) | FieldVisitListResponseDto | Public      | Retorna las visitas del agrÃ³nomo con filtros opcionales. |
| getVisitById(GetVisitByIdQuery query)                   | FieldVisitResponseDto     | Public      | Retorna el detalle de una visita especÃ­fica.             |
| startVisit(StartVisitCommand command)                   | FieldVisitResponseDto     | Public      | Inicia una visita planificada.                            |
| completeVisit(CompleteVisitCommand command)             | FieldVisitResponseDto     | Public      | Finaliza una visita en curso.                             |
| cancelVisit(CancelVisitCommand command)                 | FieldVisitResponseDto     | Public      | Cancela una visita planificada.                           |

---

**Service 2: FieldInspectionService**

| Nombre                 | CategorÃ­a          | DescripciÃ³n                                                                                                                                                    |
| ---------------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FieldInspectionService | Application Service | Servicio de aplicaciÃ³n responsable de los casos de uso de registro de inspecciones, sincronizaciÃ³n offline, vinculaciÃ³n con alertas y consulta de historial. |

**Dependencies**

| Nombre                    | Tipo de Objeto            | Visibilidad | DescripciÃ³n                                                 |
| ------------------------- | ------------------------- | ----------- | ------------------------------------------------------------ |
| fieldInspectionRepository | FieldInspectionRepository | Private     | Acceso a la persistencia de inspecciones.                    |
| fieldVisitRepository      | FieldVisitRepository      | Private     | Acceso a visitas para validar estado IN_PROGRESS.            |
| inspectionSyncService     | InspectionSyncService     | Private     | Servicio de dominio para lÃ³gica de sincronizaciÃ³n offline. |
| alertQueryClient          | AlertQueryClient          | Private     | Cliente ACL para validar alertas del BC-03.                  |
| inspectionMapper          | FieldInspectionMapper     | Private     | Mapper para convertir entre entidades de dominio y DTOs.     |

**Methods**

| Nombre                                                            | Tipo de retorno                | Visibilidad | DescripciÃ³n                                                  |
| ----------------------------------------------------------------- | ------------------------------ | ----------- | ------------------------------------------------------------- |
| registerInspection(RegisterInspectionCommand command)             | FieldInspectionResponseDto     | Public      | Registra una nueva inspecciÃ³n dentro de una visita en curso. |
| syncOfflineInspections(SyncOfflineInspectionsCommand command)     | SyncInspectionsResponseDto     | Public      | Sincroniza un lote de inspecciones registradas offline.       |
| getInspectionById(GetInspectionByIdQuery query)                   | FieldInspectionResponseDto     | Public      | Retorna el detalle de una inspecciÃ³n especÃ­fica.            |
| addObservation(AddObservationCommand command)                     | FieldInspectionResponseDto     | Public      | Agrega una observaciÃ³n a una inspecciÃ³n existente.          |
| linkInspectionToAlert(LinkInspectionToAlertCommand command)       | FieldInspectionResponseDto     | Public      | Vincula una inspecciÃ³n a una alerta activa.                  |
| getInspectionsByPlantation(GetInspectionsByPlantationQuery query) | FieldInspectionListResponseDto | Public      | Retorna el historial de inspecciones de una plantaciÃ³n.      |

---

**Service 3: AgronomicInterventionService**

| Nombre                       | CategorÃ­a          | DescripciÃ³n                                                                                                                                                     |
| ---------------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AgronomicInterventionService | Application Service | Servicio de aplicaciÃ³n responsable de los casos de uso de registro, verificaciÃ³n, rechazo y consulta de intervenciones agronÃ³micas con trazabilidad completa. |

**Dependencies**

| Nombre                          | Tipo de Objeto                  | Visibilidad | DescripciÃ³n                                             |
| ------------------------------- | ------------------------------- | ----------- | -------------------------------------------------------- |
| interventionRepository          | AgronomicInterventionRepository | Private     | Acceso a la persistencia de intervenciones.              |
| interventionTraceabilityService | InterventionTraceabilityService | Private     | Servicio de dominio para gestionar trazabilidad.         |
| recommendationQueryClient       | RecommendationQueryClient       | Private     | Cliente ACL para validar recomendaciones del BC-04.      |
| fieldInspectionRepository       | FieldInspectionRepository       | Private     | Acceso a inspecciones para validar referencias.          |
| interventionMapper              | AgronomicInterventionMapper     | Private     | Mapper para convertir entre entidades de dominio y DTOs. |

**Methods**

| Nombre                                                                | Tipo de retorno                      | Visibilidad | DescripciÃ³n                                                   |
| --------------------------------------------------------------------- | ------------------------------------ | ----------- | -------------------------------------------------------------- |
| registerIntervention(RegisterInterventionCommand command)             | AgronomicInterventionResponseDto     | Public      | Registra una nueva intervenciÃ³n agronÃ³mica con trazabilidad. |
| verifyIntervention(VerifyInterventionCommand command)                 | AgronomicInterventionResponseDto     | Public      | Verifica que la intervenciÃ³n fue ejecutada correctamente.     |
| rejectIntervention(RejectInterventionCommand command)                 | AgronomicInterventionResponseDto     | Public      | Rechaza la intervenciÃ³n como incorrecta o insuficiente.       |
| getInterventionById(GetInterventionByIdQuery query)                   | AgronomicInterventionResponseDto     | Public      | Retorna el detalle de una intervenciÃ³n especÃ­fica.           |
| getInterventionsByPlantation(GetInterventionsByPlantationQuery query) | AgronomicInterventionListResponseDto | Public      | Retorna el historial de intervenciones de una plantaciÃ³n.     |
| getTraceabilityChain(GetTraceabilityChainQuery query)                 | TraceabilityChainResponseDto         | Public      | Retorna la cadena de trazabilidad completa de una plantaciÃ³n. |

---

**Commands**

| Nombre                        | Atributos                                                                                                                                                                                        | DescripciÃ³n                                               |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| PlanVisitCommand              | plantationId: UUID, agronomistId: UUID, scheduledDate: LocalDate, objectives: String                                                                                                             | Comando para planificar una nueva visita de campo.         |
| StartVisitCommand             | visitId: UUID, agronomistId: UUID                                                                                                                                                                | Comando para iniciar una visita planificada.               |
| CompleteVisitCommand          | visitId: UUID, agronomistId: UUID                                                                                                                                                                | Comando para finalizar una visita en curso.                |
| CancelVisitCommand            | visitId: UUID, agronomistId: UUID, reason: String                                                                                                                                                | Comando para cancelar una visita planificada.              |
| RegisterInspectionCommand     | visitId: UUID, zoneId: UUID, agronomistId: UUID, observations: List\<FieldObservationDto\>, inspectedAt: LocalDateTime, linkedAlertIds: List\<UUID\>                                             | Comando para registrar una inspecciÃ³n de campo.           |
| SyncOfflineInspectionsCommand | visitId: UUID, agronomistId: UUID, inspections: List\<RegisterInspectionCommand\>                                                                                                                | Comando para sincronizar inspecciones offline en lote.     |
| AddObservationCommand         | inspectionId: UUID, description: String, category: ObservationCategory, severity: ObservationSeverity, photoReferences: List\<String\>                                                           | Comando para agregar una observaciÃ³n a una inspecciÃ³n.   |
| LinkInspectionToAlertCommand  | inspectionId: UUID, alertId: UUID                                                                                                                                                                | Comando para vincular una inspecciÃ³n a una alerta activa. |
| RegisterInterventionCommand   | plantationId: UUID, zoneId: UUID, registeredBy: UUID, interventionType: InterventionType, description: String, originRecommendationId: UUID, originInspectionId: UUID, executedAt: LocalDateTime | Comando para registrar una intervenciÃ³n agronÃ³mica.      |
| VerifyInterventionCommand     | interventionId: UUID, agronomistId: UUID, verificationNotes: String                                                                                                                              | Comando para verificar una intervenciÃ³n.                  |
| RejectInterventionCommand     | interventionId: UUID, agronomistId: UUID, verificationNotes: String                                                                                                                              | Comando para rechazar una intervenciÃ³n.                   |

**Queries**

| Nombre                            | Atributos                                                                                                                                                                                                 | DescripciÃ³n                                                |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| GetVisitsByAgronomistQuery        | agronomistId: UUID, plantationId: UUID (opcional), status: VisitStatus (opcional), startDate: LocalDate (opcional), endDate: LocalDate (opcional)                                                         | Consulta de visitas del agrÃ³nomo con filtros.              |
| GetVisitByIdQuery                 | visitId: UUID                                                                                                                                                                                             | Consulta de detalle de una visita.                          |
| GetInspectionByIdQuery            | inspectionId: UUID                                                                                                                                                                                        | Consulta de detalle de una inspecciÃ³n.                     |
| GetInspectionsByPlantationQuery   | plantationId: UUID, zoneId: UUID (opcional), startDate: LocalDateTime (opcional), endDate: LocalDateTime (opcional)                                                                                       | Consulta de historial de inspecciones de una plantaciÃ³n.   |
| GetInterventionByIdQuery          | interventionId: UUID                                                                                                                                                                                      | Consulta de detalle de una intervenciÃ³n.                   |
| GetInterventionsByPlantationQuery | plantationId: UUID, zoneId: UUID (opcional), interventionType: InterventionType (opcional), status: InterventionStatus (opcional), startDate: LocalDateTime (opcional), endDate: LocalDateTime (opcional) | Consulta de historial de intervenciones de una plantaciÃ³n. |
| GetTraceabilityChainQuery         | plantationId: UUID                                                                                                                                                                                        | Consulta de la cadena de trazabilidad completa.             |

---

---

#### 4.2.6.4. Infrastructure Layer

En la capa de Infrastructure Layer se encuentran las implementaciones concretas de los contratos definidos en las capas de dominio y aplicaciÃ³n. Incluye los repositorios JPA, los clientes de integraciÃ³n con otros bounded contexts (Anti-Corruption Layer) y los servicios tÃ©cnicos de almacenamiento.

---

**JpaFieldVisitRepositoryImpl**

| Nombre                      | CategorÃ­a                | Implementa           | DescripciÃ³n                                                                                                                                                                          |
| --------------------------- | ------------------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| JpaFieldVisitRepositoryImpl | Repository Implementation | FieldVisitRepository | ImplementaciÃ³n concreta de la interfaz FieldVisitRepository utilizando JPA y Spring Data JPA. Maneja el mapeo entre el agregado de dominio FieldVisit y la base de datos relacional. |

**Funcionalidad clave**

- Busca y carga agregados FieldVisit por ID, agronomistId y plantationId.
- Guarda (inserta/actualiza) agregados FieldVisit con sus inspecciones asociadas.
- Filtra visitas por estado (PLANNED, IN_PROGRESS, COMPLETED, CANCELLED) y rango de fechas.
- Cuenta visitas por plantaciÃ³n y agrÃ³nomo para estadÃ­sticas.
- Lista visitas ordenadas por fecha programada descendente.

---

**JpaFieldInspectionRepositoryImpl**

| Nombre                           | CategorÃ­a                | Implementa                | DescripciÃ³n                                                                                                                                                                                                                               |
| -------------------------------- | ------------------------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| JpaFieldInspectionRepositoryImpl | Repository Implementation | FieldInspectionRepository | ImplementaciÃ³n concreta de la interfaz FieldInspectionRepository utilizando JPA y Spring Data JPA. Maneja el mapeo entre el agregado de dominio FieldInspection y la base de datos, incluyendo observaciones y vinculaciones con alertas. |

**Funcionalidad clave**

- Busca y carga agregados FieldInspection por ID, visitId, zoneId y plantationId.
- Guarda (inserta/actualiza) agregados FieldInspection con sus FieldObservation embebidas.
- Filtra inspecciones por estado de sincronizaciÃ³n (SYNCED, PENDING_SYNC).
- Lista inspecciones por plantaciÃ³n con filtros por zona y rango de fechas.
- Consulta inspecciones pendientes de sincronizaciÃ³n para el proceso de sync offline.

---

**JpaAgronomicInterventionRepositoryImpl**

| Nombre                                 | CategorÃ­a                | Implementa                      | DescripciÃ³n                                                                                                                                                                                     |
| -------------------------------------- | ------------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| JpaAgronomicInterventionRepositoryImpl | Repository Implementation | AgronomicInterventionRepository | ImplementaciÃ³n concreta de la interfaz AgronomicInterventionRepository utilizando JPA y Spring Data JPA. Maneja el mapeo entre el agregado de dominio AgronomicIntervention y la base de datos. |

**Funcionalidad clave**

- Busca y carga agregados AgronomicIntervention por ID, plantationId y zoneId.
- Guarda (inserta/actualiza) agregados AgronomicIntervention.
- Filtra intervenciones por tipo (InterventionType), estado (InterventionStatus) y rango de fechas.
- Consulta intervenciones por originRecommendationId para construir cadenas de trazabilidad.
- Lista intervenciones ordenadas por fecha de ejecuciÃ³n descendente.

---

**AlertQueryClientImpl**

| Nombre               | CategorÃ­a                   | Implementa       | DescripciÃ³n                                                                                                                                                                          |
| -------------------- | ---------------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AlertQueryClientImpl | Anti-Corruption Layer Client | AlertQueryClient | ImplementaciÃ³n concreta del cliente de integraciÃ³n con el BC-03 (Alert & Notification). Valida la existencia de alertas activas antes de permitir la vinculaciÃ³n con inspecciones. |

**Funcionalidad clave**

- Valida que un alertId corresponda a una alerta activa en el BC-03 antes de vincularla a una inspecciÃ³n.
- Consulta detalles de alertas activas por plantaciÃ³n para facilitar la vinculaciÃ³n durante la inspecciÃ³n.
- Maneja errores de comunicaciÃ³n retornando respuestas de validaciÃ³n negativas en caso de indisponibilidad del BC-03.

---

**RecommendationQueryClientImpl**

| Nombre                        | CategorÃ­a                   | Implementa                | DescripciÃ³n                                                                                                                                                                                         |
| ----------------------------- | ---------------------------- | ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RecommendationQueryClientImpl | Anti-Corruption Layer Client | RecommendationQueryClient | ImplementaciÃ³n concreta del cliente de integraciÃ³n con el BC-04 (Agronomic Recommendation). Valida la existencia de recomendaciones y obtiene su contenido para construir cadenas de trazabilidad. |

**Funcionalidad clave**

- Valida que un originRecommendationId corresponda a una recomendaciÃ³n publicada en el BC-04.
- Obtiene el contenido resumido de recomendaciones para incluir en la cadena de trazabilidad.
- Maneja errores de comunicaciÃ³n permitiendo el registro de intervenciones sin recomendaciÃ³n vinculada en caso de indisponibilidad.

---

**PhotoStorageServiceImpl**

| Nombre                  | CategorÃ­a        | Implementa          | DescripciÃ³n                                                                                                                                                                                           |
| ----------------------- | ----------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| PhotoStorageServiceImpl | Technical Service | PhotoStorageService | ImplementaciÃ³n concreta del servicio de almacenamiento de evidencia fotogrÃ¡fica de inspecciones. Gestiona la subida, almacenamiento y recuperaciÃ³n de imÃ¡genes asociadas a observaciones de campo. |

**Funcionalidad clave**

- Almacena imÃ¡genes en un servicio de almacenamiento de objetos (S3/Azure Blob) y retorna la URL de referencia.
- Comprime imÃ¡genes antes del almacenamiento para optimizar espacio y ancho de banda.
- Genera URLs pre-firmadas para acceso temporal a las imÃ¡genes.
- Maneja almacenamiento local temporal en el dispositivo del agrÃ³nomo durante operaciones offline, con sincronizaciÃ³n posterior.

---

---

#### 4.2.6.5. Bounded Context Software Architecture Component Level Diagrams

Los diagramas de componentes del bounded context Field Technical Management se elaboraron utilizando el modelo C4 en la herramienta Structurizr. Muestran la arquitectura interna del backend (API) y la aplicaciÃ³n mÃ³vil del agrÃ³nomo con soporte offline.

##### Diagrama 1: Component Level â€” Backend API (Spring Boot)

![BC06_Backend_Components](../../assets/img/chapter-4/BC06_Backend_Components.png)

##### Diagrama 2: Component Level â€” Web Platform (Angular)

![BC06_WebPlatform_Components](../../assets/img/chapter-4/BC06_WebPlatform_Components.png)

##### Diagrama 3: Component Level â€” Mobile Application (Flutter)

![BC06_Mobile_Components](../../assets/img/chapter-4/BC06_MobileApp_Components.png)

#### 4.2.6.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.6.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases del Domain Layer del bounded context Field Technical Management se elaborÃ³ utilizando PlantUML. Muestra las entidades, value objects, enumeraciones, servicios de dominio e interfaces de repositorio.

![BC06-UML](../../assets/img/chapter-4/BC06_UML.png)

---

**DescripciÃ³n del diagrama:**

El diagrama muestra el diseÃ±o del Domain Layer del bounded context Field Technical Management, compuesto por tres agregados principales:

- **FieldVisit** es la entidad raÃ­z que modela el ciclo de vida de una visita de campo (PLANNED â†’ IN_PROGRESS â†’ COMPLETED/CANCELLED). Agrupa las inspecciones realizadas durante la visita y valida que solo se puedan agregar inspecciones cuando la visita estÃ¡ en curso.
- **FieldInspection** modela una inspecciÃ³n tÃ©cnica realizada en una zona de monitoreo. Contiene una lista de **FieldObservation** (value object) con categorÃ­a, severidad y evidencia fotogrÃ¡fica. Incorpora soporte offline mediante el enum **SyncStatus**, resolviendo el pain point identificado en el EventStorming. Puede vincularse a alertas activas del BC-03.
- **AgronomicIntervention** modela una intervenciÃ³n ejecutada como resultado de una recomendaciÃ³n. Mantiene trazabilidad bidireccional hacia la recomendaciÃ³n del BC-04 que la originÃ³ y la inspecciÃ³n que la motivÃ³. Soporta un ciclo de verificaciÃ³n por parte del agrÃ³nomo (REGISTERED â†’ VERIFIED/REJECTED).

Los **Domain Services** encapsulan la lÃ³gica de sincronizaciÃ³n offline (InspectionSyncService) y la construcciÃ³n de cadenas de trazabilidad recomendaciÃ³n â†’ inspecciÃ³n â†’ intervenciÃ³n (InterventionTraceabilityService).

##### 4.2.6.6.2. Bounded Context Database Design Diagram

![BC-06 Database Diagram](../../assets/img/chapter-4/BC06-DB.png)

---
**DescripciÃ³n del diagrama:**

El modelo relacional del bounded context Field Technical Management estÃ¡ compuesto por 6 tablas que reflejan los 3 agregados del Domain Layer y sus relaciones:

- **field_visits** almacena las visitas de campo con su ciclo de vida (PLANNED â†’ IN_PROGRESS â†’ COMPLETED/CANCELLED). Los Ã­ndices compuestos por `agronomist_id + status` y `plantation_id + scheduled_date` optimizan las consultas del panel del agrÃ³nomo.
- **field_inspections** almacena las inspecciones tÃ©cnicas con soporte offline. El campo `sync_status` controla el estado de sincronizaciÃ³n, y la diferencia entre `inspected_at` y `registered_at` permite identificar registros offline. La FK a `field_visits` garantiza que cada inspecciÃ³n pertenezca a una visita.
- **field_observations** contiene las observaciones categorizadas por tipo y severidad dentro de cada inspecciÃ³n. El Ã­ndice compuesto `(inspection_id, category)` facilita filtrados por categorÃ­a.
- **observation_photos** almacena las referencias a evidencia fotogrÃ¡fica. Las imÃ¡genes fÃ­sicas residen en almacenamiento de objetos externo (S3/Azure Blob), y esta tabla solo guarda las URLs.
- **inspection_alert_links** es la tabla intermedia que vincula inspecciones con alertas activas del BC-03. La restricciÃ³n `unique(inspection_id, alert_id)` evita duplicados.
- **agronomic_interventions** almacena las intervenciones con trazabilidad completa. Los campos `origin_recommendation_id` (referencia lÃ³gica al BC-04) y `origin_inspection_id` (FK a `field_inspections`) construyen la cadena de trazabilidad recomendaciÃ³n â†’ inspecciÃ³n â†’ intervenciÃ³n. Los Ã­ndices por `origin_recommendation_id` y `origin_inspection_id` optimizan las consultas de trazabilidad.
