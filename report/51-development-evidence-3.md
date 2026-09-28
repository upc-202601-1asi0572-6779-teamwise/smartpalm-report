### 6.2.3.4. Development Evidence for Sprint Review

<br>

**Web Service:** https://github.com/upc-202601-1asi0572-6779-teamwise/webservice

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | fix/update-iam-implementation | 774ac9d | feat: update edge device registration and command models, add userId to edge device and update swagger annotations. | Añade el propietario del dispositivo al modelo de EdgeDevice y actualiza los comandos y anotaciones de Swagger del registro. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-iam-implementation | ae9500f | feat: add roles to user resource and command, update assembly and service methods | Incorpora el rol del usuario a los recursos y comandos de IAM y actualiza los ensambladores y servicios asociados. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-iam-implementation | 9357111 | fix: update appdbcontext to include new tables and columns. update migrations. | Actualiza el contexto de base de datos con las nuevas tablas y columnas y genera las migraciones correspondientes. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-iam-implementation | 940c113 | fix: 404 error when injecting unknown edge gateways. | Corrige la ingesta de lecturas para que retorne 404 cuando el edge gateway no está registrado en la plataforma. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 3cbf277 | Merge pull request #3 from upc-202601-1asi0572-6779-teamwise/feat/bc-alerts-and-bc-iam | Integra los bounded contexts de alertas, notificaciones, IAM y suscripciones a la rama principal de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feat/bc-alerts-and-bc-iam | a42ab80 | feat: added threshold exceeded event and improve appdbcontext | Agrega el evento de umbral excedido y mejora la configuración del contexto de base de datos. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feat/bc-alerts-and-bc-iam | fb7ee9c | feat: added IAM and Subscription bounded | Incorpora los bounded contexts de gestión de identidad/acceso y de suscripciones al backend. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feat/bc-alerts-and-bc-iam | 7b53bc0 | feat: added alerts and notifications bounded | Incorpora el bounded context de alertas y notificaciones al backend. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 8344439 | Merge branch 'fix/update-rest-endpoints' into develop | Integra la refactorización de endpoints REST de sensores y dispositivos a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 33f306a | refactor: flatten threshold routes, align status codes/error handling and document endpoints with Swagger | Aplana las rutas de umbrales, alinea los códigos de estado y el manejo de errores, y documenta los endpoints con Swagger. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 05edd88 | refactor: flatten threshold lookups to be keyed by IoT device and simplify query handling | Reestructura la búsqueda de umbrales para que se indexe por dispositivo IoT y simplifica el manejo de las consultas. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | f496c2f | feat: add gateway and device listing endpoints | Agrega los endpoints de listado de edge gateways y de dispositivos IoT asociados. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 0001720 | feat: add per-device sensor readings endpoint and paginate gateway readings. | Agrega el endpoint de lecturas por dispositivo individual y pagina las lecturas consultadas por gateway. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 0c31e60 | refactor: rename edges resource to edge-gateways across BCs | Renombra el recurso "edges" a "edge-gateways" en todos los bounded contexts para cumplir la convención REST. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 051c239 | feat: ingest sensor readings grouped by IoT device and update edge connectivity on sync. | Implementa la ingesta de lecturas agrupada por dispositivo IoT y actualiza la conectividad del gateway al sincronizar. | Jul 07, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-rest-endpoints | 81411a9 | feat: add IoT device attribution to sensor readings and update resource assembly. | Agrega la atribución del dispositivo IoT de origen a las lecturas de sensores y actualiza el ensamblador de recursos. | Jul 07, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | dd14ea8 | Merge branch 'feature/iam-integration' into develop | Integra la configuración de IAM y JWT a la rama principal de desarrollo. | Jul 06, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/iam-integration | 79be08c | Add IAM BC and JWT configuration files, update middleware and services for token validation and hashing. | Agrega el bounded context de IAM y la configuración JWT, y actualiza el middleware y los servicios de validación y hashing. | Jul 06, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | dfdb278 | Merge branch 'refactor/rest-principles' into develop | Integra la refactorización de principios REST a la rama principal de desarrollo. | Jul 06, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | 78b9057 | feat: update Swagger annotations for recommendation intervention registration | Actualiza las anotaciones de Swagger del registro de intervenciones de recomendaciones agronómicas. | Jul 06, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | 6722763 | refactor: migrate Sensor Data Processing endpoints to REST-compliant URLs | Migra los endpoints de procesamiento de datos de sensores a URLs conformes con REST. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | 863ad8f | refactor: migrate IoT Device Management endpoints to REST-compliant URLs | Migra los endpoints de gestión de dispositivos IoT a URLs conformes con REST. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | 2c1a706 | refactor: move device identifiers from route params to request body in registration assemblers | Traslada los identificadores de dispositivo de los parámetros de ruta al cuerpo de la solicitud en el registro. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | 4e26d47 | refactor: standardize error handling across all controllers and services | Estandariza el manejo de errores en todos los controladores y servicios del backend. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | f0b9787 | refactor: remove template controller and complete REST compliance in recommendations | Elimina el controlador de plantilla y completa el cumplimiento REST en el módulo de recomendaciones. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | refactor/rest-principles | ff555c5 | chore: remove WeatherForecast template controller and model | Elimina el controlador y modelo de plantilla WeatherForecast generado por el template del proyecto. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | edc074e | Merge branch 'fix/reafactor-agronomic-recommendations' into develop | Integra la refactorización del bounded context de recomendaciones agronómicas a la rama de desarrollo. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | 1a00462 | fix: use EnsureCreated for MySQL in development and Migrate for PostgreSQL in production | Corrige la estrategia de base de datos: EnsureCreated en desarrollo con MySQL y Migrate en producción con PostgreSQL. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | 9daa77e | refactor: migrate REST endpoints to plantation-centric URLs with correct HTTP semantics | Migra los endpoints REST a URLs centradas en la plantación con la semántica HTTP correcta. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | 38c2a17 | refactor: update query service to use new plantation-centric query types | Actualiza el servicio de consultas para usar los nuevos tipos de consulta centrados en la plantación. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | f0f4874 | refactor: update repository contract and implementation with plantation-first query methods | Actualiza el contrato e implementación del repositorio con métodos de consulta orientados a la plantación. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | c290024 | refactor: replace agronomist-centric queries with plantation-centric query model | Reemplaza las consultas centradas en el agrónomo por un modelo de consulta centrado en la plantación. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/reafactor-agronomic-recommendations | daba9ee | refactor: simplify command records to use only required parameters | Simplifica los registros de comando para que utilicen únicamente los parámetros necesarios. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 09cc0e1 | Merge remote-tracking branch 'origin/develop' | Sincroniza la rama local de desarrollo con los últimos cambios remotos antes de continuar el refactor. | Jun 22, 2026 |

<br>

**Web Application:** https://github.com/upc-202601-1asi0572-6779-teamwise/webapp

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | main | 8facc6e | Merge pull request #1 from upc-202601-1asi0572-6779-teamwise/develop | Integra los nuevos bounded contexts de la Web Application a la rama principal. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | d63f775 | Merge branch 'feature/subscription-and-user-management' into develop | Integra el módulo de suscripciones y gestión de usuarios a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/subscription-and-user-management | afe0626 | feat: add bounded context subscription-and-user-management folder | Agrega la carpeta del bounded context de suscripciones y gestión de usuarios. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 6fce94c | Merge branch 'feature/iot-device-management' into develop | Integra el módulo de gestión de dispositivos IoT a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/iot-device-management | 2ff57a3 | feat: add bounded context iot-device-management folder | Agrega la carpeta del bounded context de gestión de dispositivos IoT. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | ca306ac | Merge branch 'feature/field-technical-management' into develop | Integra el módulo de gestión técnica de campo a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/field-technical-management | 908de5a | feat: add bounded context field-technical-management folder | Agrega la carpeta del bounded context de gestión técnica de campo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | d0af584 | Merge branch 'feature/crop-monitoring-dashboard' into develop | Integra el módulo del panel de monitoreo del cultivo a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/crop-monitoring-dashboard | 115ed5e | feat: add bounded context crop-monitoring-dashboard folder | Agrega la carpeta del bounded context del panel de monitoreo del cultivo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | bbdf78b | Merge branch 'feature/alert-and-notification' into develop | Integra el módulo de alertas y notificaciones a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/alert-and-notification | ea98962 | feat: add bounded context alert-and-notification folder | Agrega la carpeta del bounded context de alertas y notificaciones. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | feature/agronomic-recommendation | dc375c9 | feat: add bounded context agronomic-recommendation folder | Agrega la carpeta del bounded context de recomendaciones agronómicas. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 93f4c16 | feat: add the i18n folder | Agrega la carpeta de internacionalización con soporte de inglés y español. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | a1f0a3f | feat: update the shared folder | Actualiza los componentes, servicios y utilidades compartidas entre módulos. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | f898991 | feat: update base files | Actualiza los archivos base de configuración y estructura del proyecto Angular. | Jul 08, 2026 |

<br>

**Mobile Application:** https://github.com/upc-202601-1asi0572-6779-teamwise/mobileapp

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | main | 8b592ba | Merge remote-tracking branch 'origin/main' | Sincroniza la rama principal local con los últimos cambios publicados en el repositorio remoto. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 58436d9 | Merge branch 'main' of https://github.com/upc-202601-1asi0572-6779-teamwise/mobileapp | Fusiona los cambios de la rama principal remota dentro de la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | c6201d9 | feat(mobile): integrate smartpalm home navigation and local mock server configuration | Integra la navegación principal de Smart Palm y la configuración del servidor simulado local. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 1bc4ede | feat(mobile): add parcela feature module | Agrega el módulo de funcionalidad de parcelas (plantaciones) a la aplicación móvil. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 659ebed | fix: update dependencies and update commit message format | Actualiza las dependencias del proyecto y ajusta el formato de los mensajes de commit. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | d58bcb7 | Merge branch 'main' into develop | Fusiona los últimos cambios de la rama principal dentro de la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 9438dbf | Merge remote-tracking branch 'origin/main' | Sincroniza la rama de desarrollo local con la rama principal remota. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 46009af | feat(mobile): add report feature module | Agrega el módulo de funcionalidad de reportes a la aplicación móvil. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 25b6f64 | feat(mobile): add alert feature module | Agrega el módulo de funcionalidad de alertas activas a la aplicación móvil. | Jul 08, 2026 |

<br>

**Embedded Application — Prototipo 1 (dispositivo con sensores):** https://github.com/upc-202601-1asi0572-6779-teamwise/embeddedapp

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | main | c16f1d2 | Delete CMakeLists.txt | Elimina el archivo de configuración de compilación que quedó obsoleto tras la reestructuración del firmware. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | main | 3bd6659 | Delete smart_palm_v3 directory | Elimina el directorio de una versión anterior del firmware que ya no se utiliza. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | main | 594fbd8 | Merge pull request #1 from upc-202601-1asi0572-6779-teamwise/develop | Integra la reestructuración orientada a objetos del firmware a la rama principal. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 4399ebd | Refactor firmware to OOP approach | Reestructura el firmware del dispositivo IoT hacia un enfoque orientado a objetos para mejorar su mantenibilidad. | Jul 08, 2026 |

<br>

**Embedded Application — Prototipo 2 (edge gateway node):** https://github.com/upc-202601-1asi0572-6779-teamwise/embeddedapp-edge-node

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | main | 28f0a99 | Initial commit with OOP firmware | Establece el repositorio del nodo edge (Prototipo 2) con el firmware orientado a objetos ya reestructurado. | Jul 08, 2026 |

<br>

**Edge Service:** https://github.com/upc-202601-1asi0572-6779-teamwise/edgeservice

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on (Date) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| upc-202601-1asi0572-6779-teamwise | main | 918cda8 | Merge branch 'develop' | Integra los últimos cambios de la rama de desarrollo a la rama principal del Edge API. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | c32a484 | Merge branch 'fix/update-endpoint-conection' into develop | Integra la actualización de conectividad y descubrimiento del Edge API a la rama de desarrollo. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-endpoint-conection | 3ab02e2 | feat: update .gitignore to exclude docs | Actualiza el archivo .gitignore para excluir la documentación generada del control de versiones. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-endpoint-conection | 870a307 | feat: register Edge API by mDNS and update cloud client for edge and iot device registration. | Registra el Edge API mediante mDNS y actualiza el cliente de nube para el registro de edge gateways y dispositivos IoT. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-endpoint-conection | 2296a64 | feat: update cloud client for edge and iot device registration and registry fetching. | Actualiza el cliente de nube para el registro de dispositivos y la obtención del listado de dispositivos autorizados. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/update-endpoint-conection | 802761b | feat: add mDNS service registration for Edge API discovery. | Agrega el anuncio de servicio mDNS para que el nodo edge descubra automáticamente la ubicación del Edge API. | Jul 08, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | dbc0024 | chore: update cloud client for edge and iot device registration and registry fetching. | Actualiza el cliente de nube para adaptarlo al nuevo contrato de registro de dispositivos del backend. | Jul 03, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | c70d290 | Merge branch 'develop' | Sincroniza la rama de desarrollo tras la integración de la configuración de conectividad. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | develop | 66db45e | Merge branch 'fix/configure-conection-backend-edg-api' into develop | Integra la corrección de conectividad con el backend en la nube a la rama de desarrollo. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/configure-conection-backend-edg-api | 3cb0898 | chore: Update gitignore. | Actualiza el archivo .gitignore del Edge API. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/configure-conection-backend-edg-api | 0f9639c | refactor: move bootstrap to create_app, harden security defaults | Traslada la inicialización a create_app y refuerza los valores de seguridad por defecto. | Jun 24, 2026 |
| upc-202601-1asi0572-6779-teamwise | fix/configure-conection-backend-edg-api | cb9654c | fix: correct default thresholds, cloud response format and timestamp handling | Corrige los umbrales por defecto, el formato de respuesta de la nube y el manejo de timestamps. | Jun 24, 2026 |

---
