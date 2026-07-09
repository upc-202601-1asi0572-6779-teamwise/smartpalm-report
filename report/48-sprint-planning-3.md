### 6.2.3. Sprint 3

#### 6.2.3.1. Sprint Planning 3

En esta sección se documenta la reunión de Sprint Planning del Sprint 3, en la que el equipo TempWise definió el objetivo de la iteración, estableció el alcance y distribuyó las responsabilidades entre los integrantes. Este sprint corresponde al cierre del ciclo de vida del proyecto: se consolida el control de acceso basado en roles y la propiedad de los dispositivos, se cierra el circuito de alertas hasta la notificación al usuario final, se refuerza la conectividad de campo del nodo edge y del dispositivo IoT, y se amplían las herramientas de gestión y reporte disponibles para el agrónomo y el productor en la Web Application y la Mobile Application.

| Sprint # | Sprint 3 |
| :--- | :--- |
| **Sprint Planning Background** | |
| Date | 2026-07-01 |
| Time | 08:00 PM |
| Location | Reunión virtual vía Discord |
| Prepared By | Rojas Reategui, Victor Manuel |
| Attendees (to planning meeting) | Rojas Reategui, Victor Manuel / Tello Murga, Javier Oswaldo / Loli Ruiz, Renzo Javier / Julca Cruz, Renso Anthony / Carbajal Santivañez, Sebastian / Paucar Meneses, Jeremy Alión |
| Sprint 2 – Review Summary | Durante el Sprint 2 se completó el primer ciclo operativo integral de Smart Palm, conectando el dispositivo IoT (Prototipo 1, ESP32) con el nodo edge (Prototipo 2), el Web Service en la nube y las interfaces de usuario, completando 59 Story Points. El Web Service expuso una primera versión de los bounded contexts de IoT Device Management, Sensor Data Processing y Agronomic Recommendation; el Edge Service gestionó la autenticación y recepción de lecturas de los dispositivos IoT; la Embedded Application capturó y transmitió lecturas de sensores hacia el nodo edge; la Mobile Application habilitó las vistas principales del dueño del cultivo sobre sus dispositivos y alertas; y se desplegaron mejoras de segunda versión en Landing Page y Web Application. El equipo destacó como logro principal la validación end-to-end del stack completo con hardware físico. |
| Sprint 2 – Retrospective Summary | El equipo identificó tres oportunidades de mejora para el Sprint 3: (1) el bounded context de IAM se había integrado a nivel de código pero quedó parcialmente desconectado en tiempo de ejecución (sin persistencia activa ni middleware registrado), lo que impidió validar flujos de autenticación reales durante el Sprint 2; como acción correctiva, el equipo se comprometió a verificar cada bounded context contra una base de datos real antes de cerrar el Pull Request, no solo contra la compilación. (2) La ausencia de un modelo de roles y de validación de existencia de gateways en la ingesta de lecturas generó respuestas inconsistentes ante datos inválidos; se acordó priorizar el endurecimiento de estas validaciones al inicio del Sprint 3. (3) La dependencia de direcciones IP fijas configuradas manualmente entre el nodo edge y el Edge API dificultó las pruebas de campo; el equipo priorizó automatizar ese descubrimiento antes de la entrega final. |
| **Sprint Goal & User Stories** | |
| Sprint 3 Goal | *Our focus is on strengthening role-based access control and device ownership across the platform, closing the loop from threshold breach to user-facing notification, hardening field connectivity for the edge node and the IoT device, and equipping agronomists and growers with richer reporting, device management, and mobile alerting capabilities. We believe this delivers accountable device provisioning to administrators, timely critical-condition awareness to growers on mobile, deeper monitoring and reporting tools to agronomists, and resilient, self-recovering connectivity to the field hardware. This will be confirmed when an administrator registers a device and assigns it to a client, a threshold breach reaches the grower as both an active alert and a mobile notification, an agronomist generates and exports a plantation report from the web platform, and the edge node automatically rediscovers the Edge API and reauthorizes its IoT devices after a network interruption.* |
| Sprint 3 Velocity | 119 Story Points |
| Sum of Story Points | 119 |

**User Stories comprometidas en el Sprint 3:**

| Producto | User Story ID | Título | Story Points |
| :--- | :--- | :--- | :--- |
| Web Service (Backend) v2 | TS002 | Exponer un API RESTful para la gestión de alertas y umbrales | 5 |
| Web Service (Backend) v2 | TS004 | Implementar autenticación y control de acceso seguro | 5 |
| Web Service (Backend) v2 | TS005 | Procesar eventos críticos y generar notificaciones | 5 |
| Web Service (Backend) v2 | TS007 | Exponer un API RESTful para la gestión de usuarios, perfiles e invitaciones | 5 |
| Web Service (Backend) v2 | TS031 | Exponer un API RESTful para la ingesta y consulta de lecturas de sensores por gateway y por dispositivo IoT | 5 |
| Web Service (Backend) v2 | TS032 | Restringir el registro de dispositivos a administradores y asignarlos a la cuenta del cliente | 3 |
| Mobile Application v2 | US025 | Consultar alertas activas en la app móvil | 3 |
| Mobile Application v2 | US026 | Recibir notificaciones de alertas críticas | 5 |
| Web Application v3 | US006 | Cambiar el idioma de la interfaz | 3 |
| Web Application v3 | US017 | Generar un reporte de estado del cultivo | 5 |
| Web Application v3 | US018 | Exportar datos históricos del cultivo | 3 |
| Web Application v3 | US019 | Consultar reportes generados previamente | 2 |
| Web Application v3 | US031 | Archivar una plantación | 2 |
| Web Application v3 | US032 | Desasociar un dispositivo IoT de una zona | 2 |
| Web Application v3 | US035 | Consultar el estado de un dispositivo IoT | 2 |
| Web Application v3 | US036 | Visualizar dispositivos asociados a una plantación | 2 |
| Web Application v3 | US039 | Completar el registro inicial como agrónomo invitado | 3 |
| Web Application v3 | US043 | Contratar un plan profesional como ingeniero agrónomo | 3 |
| Web Application v3 | US044 | Iniciar sesión en la plataforma | 2 |
| Web Application v3 | US045 | Recuperar la contraseña | 2 |
| Web Application v3 | US046 | Visualizar y actualizar el perfil de usuario | 2 |
| Embedded Application v2 — Prototipo 1 (ESP32 NodeMCU-32S) | TS020 | Reportar el estado operativo del dispositivo IoT | 3 |
| Embedded Application v2 — Prototipo 1 | TS024 | Transmitir lecturas al Edge API mediante WiFi y HTTP desde el dispositivo IoT | 5 |
| Embedded Application v2 — Prototipo 1 | TS025 | Procesar indicadores de alerta del Edge API y activar señal visual en el dispositivo | 3 |
| Embedded Application v2 — Prototipo 1 a Prototipo 2 | TS030 | Atribuir correctamente cada lectura sincronizada a su dispositivo IoT de origen | 3 |
| Edge Application v2 — Prototipo 2 + Flask Edge API | TS013 | Sincronizar lecturas desde el nodo edge hacia la nube | 8 |
| Edge Application v2 — Flask Edge API | TS015 | Autenticar dispositivos IoT en el Edge API | 3 |
| Edge Application v2 — Flask Edge API | TS021 | Normalizar el timestamp de una lectura a UTC en el Edge API | 2 |
| Edge Application v2 — Flask Edge API | TS023 | Inicializar base de datos local y sembrar dispositivo de prueba en el primer request | 2 |
| Edge Application v2 — Flask Edge API | TS026 | Sincronizar umbrales agronómicos desde el backend en la nube hacia el nodo edge | 8 |
| Edge Application v2 — Prototipo 2 | TS027 | Reconfigurar la conectividad del nodo edge sin reflasheo de firmware | 5 |
| Edge Application v2 — Prototipo 2 | TS028 | Descubrir automáticamente la ubicación del Edge API desde el nodo edge | 5 |
| Edge Application v2 — Prototipo 2 + Flask Edge API | TS029 | Reintentar automáticamente la sincronización de dispositivos autorizados | 3 |
| **Total** | | | **119** |


---
