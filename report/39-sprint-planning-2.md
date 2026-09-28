### 6.2.2. Sprint 2

#### 6.2.2.1. Sprint Planning 2

En esta sección se documenta la reunión de Sprint Planning del Sprint 2, en la que el equipo TempWise definió el objetivo de la iteración, estableció el alcance y distribuyó las responsabilidades entre los integrantes. Este sprint representa el hito central del proyecto: la primera integración completa del stack IoT de Smart Palm, desde el firmware del dispositivo físico hasta las interfaces de usuario web y móvil, respaldadas por un backend RESTful en la nube. Complementariamente, se despliega una segunda versión del Landing Page y de la Web Application con las mejoras y nuevas vistas derivadas de la retroalimentación del Sprint 1.

| Sprint # | Sprint 2 |
| :--- | :--- |
| **Sprint Planning Background** | |
| Date | 2026-06-10 |
| Time | 08:00 PM |
| Location | Reunión virtual vía Discord |
| Prepared By | Rojas Reategui, Victor Manuel |
| Attendees (to planning meeting) | Rojas Reategui, Victor Manuel / Tello Murga, Javier Oswaldo / Loli Ruiz, Renzo Javier / Julca Cruz, Renso Anthony / Carbajal Santivañez, Sebastian / Paucar Meneses, Jeremy Alión |
| Sprint 1 – Review Summary | Durante el Sprint 1 se desplegaron la primera versión funcional del Landing Page en Netlify y la estructura base de la Web Application en Cloudflare Pages, completando 25 Story Points. El Landing Page presentó la propuesta de valor de Smart Palm, los planes de suscripción y la información institucional de TempWise con los call-to-action dirigidos a cada segmento. La Web Application habilitó las vistas iniciales del panel de plantaciones asignadas, el detalle técnico de una plantación y el estado del cultivo por zona. Se destacó la consistencia visual entre ambos productos como el principal logro del sprint y señaló como prioridad inmediata la integración del frontend con un backend real para el Sprint 2. |
| Sprint 1 – Retrospective Summary | El equipo identificó dos oportunidades de mejora para el Sprint 2: (1) la acumulación de commits en los últimos días del sprint generó estrés de integración; como acción correctiva, el equipo se comprometió a realizar integraciones diarias con Pull Requests más pequeños y revisiones entre pares. (2) La ausencia de roles explícitos de liderazgo técnico generó solapamientos en decisiones de diseño y backend; el equipo acordó adoptar la matriz de Aspect Leaders and Collaborators desde el inicio del Sprint 2 para clarificar responsabilidades por cada aspecto del alcance. |
| **Sprint Goal & User Stories** | |
| Sprint 2 Goal | *Our focus is on enabling the first complete operational cycle for monitoring oil palm, connecting the capture of environmental variables in the field with the visualization of critical data and indicators on the digital interfaces of both the grower and the agronomist. We believe this gives growers the ability to know the real-time condition of their crops from any device, and provides agronomists with the necessary inputs to make timely agronomic decisions, reducing the risk of losses due to undetected conditions. This will be confirmed when the physical device transmits readings of temperature, humidity, soil moisture, and light intensity through the edge node to the cloud backend, and both the grower's mobile application and the agronomist's web platform display real-time plantation data and active alerts from the deployed API.* |
| Sprint 2 Velocity | 59 Story Points |
| Sum of Story Points | 59 |

**User Stories comprometidas en el Sprint 2:**

| Producto | User Story ID | Título | Story Points |
| :--- | :--- | :--- | :--- |
| Web Application v2 | US010 | Identificar plantaciones o zonas con mayor criticidad | 3 |
| Web Application v2 | US011 | Consultar alertas activas de las plantaciones supervisadas | 3 |
| Web Service (Backend) v1 | TS001 | Exponer un API RESTful para la gestión de plantaciones y zonas | 5 |
| Web Service (Backend) v1 | TS002 | Exponer un API RESTful para la gestión de alertas y umbrales | 5 |
| Web Service (Backend) v1 | TS004 | Implementar autenticación y control de acceso seguro | 5 |
| Mobile Application v1 | US023 | Visualizar el resumen de mis plantaciones en la aplicación móvil | 3 |
| Mobile Application v1 | US024 | Consultar el detalle de una plantación en la aplicación móvil | 3 |
| Mobile Application v1 | US025 | Consultar el estado de una zona en la aplicación móvil | 3 |
| Mobile Application v1 | US026 | Consultar alertas activas en la aplicación móvil | 3 |
| Embedded Application v1 — Prototipo 1 (ESP32 NodeMCU-32S) | TS011 | Capturar lecturas desde sensores en el dispositivo IoT | 5 |
| Embedded Application v1 — Prototipo 1 a Prototipo 2 | TS012 | Transmitir lecturas desde el dispositivo IoT al nodo edge | 8 |
| Prototipo físico — Prototipo 1 | TS015 | Reportar el estado operativo del dispositivo IoT | 3 |
| Edge Application v1 — Prototipo 2 + Flask Edge API | TS006 | Exponer un Edge API para la recepción de lecturas desde dispositivos IoT | 5 |
| Edge Application v1 — Flask Edge API | TS007 | Procesar datos localmente en el nodo edge | 5 |
| **Total** | | | **59** |


---
