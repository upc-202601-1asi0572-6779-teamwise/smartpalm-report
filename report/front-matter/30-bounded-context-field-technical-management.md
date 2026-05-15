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

