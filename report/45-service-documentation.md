#### 6.2.2.6. Services Documentation Evidence for Sprint Review

| Module | Mock Resource | Main Actions | Sprint Relevance |
|---|---|---|---|
| Access | `/api/v1/auth/register`, `/api/v1/auth/login`, `/api/v1/users/me` | Simular registro, login y consulta de perfil. | Permite navegar la Web Application con usuarios representativos. |
| Subscriptions | `/api/v1/subscriptions/plans`, `/api/v1/subscriptions/me`, `/api/v1/subscriptions/me/upgrade` | Consultar planes, suscripción actual y cambio de plan. | Soporta las historias de contratación y suscripción inicial. |
| Plantations | `/api/v1/plantations`, `/api/v1/plantations/:id`, `/api/v1/plantations/:plantationId/zones` | Consultar plantaciones, detalle técnico y zonas de monitoreo. | Soporta dashboard, listado y detalle de plantaciones. |
| Devices | `/api/v1/devices`, `/api/v1/devices/:id`, `/api/v1/devices/:id/zone` | Consultar dispositivos asociados a plantaciones y zonas. | Permite evidenciar el componente IoT dentro de la experiencia web. |
| Sensor Readings | `/api/v1/readings` | Consultar lecturas simuladas por variable, zona, dispositivo o plantación. | Alimenta la visualización del estado del cultivo. |
| Alerts | `/api/v1/alerts`, `/api/v1/alerts/:id`, `/api/v1/alerts/:id/acknowledge` | Consultar alertas activas, detalle de alerta y reconocimiento. | Permite priorizar condiciones críticas dentro de la Web Application. |
| Recommendations | `/api/v1/recommendations`, `/api/v1/recommendations/:id/approve`, `/api/v1/recommendations/:id/publish` | Consultar, aprobar y publicar recomendaciones agronómicas. | Soporta la experiencia del agrónomo y del productor. |
| Reports | `/api/v1/reports`, `/api/v1/reports/generate-draft`, `/api/v1/reports/:id/publish` | Consultar, generar y publicar reportes. | Permite mostrar documentación del estado del cultivo. |
| Field Records | `/api/v1/inspections`, `/api/v1/interventions` | Consultar inspecciones e intervenciones simuladas. | Complementa la trazabilidad del seguimiento agronómico. |

#### 6.2.2.7. Software Deployment Evidence for Sprint Review

En el Sprint 2 se desplegaron los seis artefactos del alcance: Landing Page, Web Application, Mock API, Web Service, Edge Service y Emebbed Apllication.

| Artifact | Deployment Status | URL / Environment                       |
|---|---|-----------------------------------------|
| Landing Page | Deployed | https://smart-palm.netlify.app          |
| Web Application | Deployed | https://webapp-9sf.pages.dev            |
| Mock API | Deployed | https://smartpalm-mock-api.onrender.com |
| Web Service | Deployed |  |
| Edge Service | Deployed |  |
| Emebbed Apllication | Deployed |  |