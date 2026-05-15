## 5.4. Applications UX/UI Design

### 5.4.1. Applications Wireframes

#### Web Application

##### Login

Pantalla de inicio de sesión donde el usuario —ingeniero agrónomo o dueño de cultivo— ingresa sus credenciales para acceder a la plataforma SmartPalm.

![Login Wireframe](../../assets/img/Applications-Wireframes/1_Login.png)

##### Register

Pantalla de registro para nuevos usuarios que desean crear una cuenta en SmartPalm, solicitando datos básicos como nombre, correo electrónico y tipo de usuario (ingeniero agrónomo o dueño de cultivo).

![Register Wireframe](../../assets/img/Applications-Wireframes/2_Register.png)

---

##### Dashboard

Panel principal que muestra una vista general del estado de las plantaciones, con indicadores clave como alertas activas, visitas programadas, condiciones actuales del cultivo y accesos rápidos a las funcionalidades principales.

![Dashboard Wireframe](../../assets/img/Applications-Wireframes/3_DashBoard_1.png)

##### Schedule

Pantalla de planificación donde el ingeniero agrónomo organiza su calendario de visitas de campo, seleccionando la plantación, fecha y definiendo los objetivos de cada visita programada.

![Schedule Wireframe](../../assets/img/Applications-Wireframes/4_Schedule.png)

---

##### History

Historial de inspecciones realizadas, intervenciones agronómicas ejecutadas y alertas registradas. Permite filtrar por plantación, zona de monitoreo y rango de fechas para consultar el detalle de cada registro.

![History Wireframe](../../assets/img/Applications-Wireframes/5_History.png)

##### Settings

Pantalla de configuración de la cuenta del usuario, donde se gestionan las preferencias de notificación, parámetros de la aplicación y datos del perfil personal.

![Settings Wireframe](../../assets/img/Applications-Wireframes/6_Settings.png)

---

##### Support

Pantalla de soporte y ayuda donde el usuario puede consultar la documentación de la plataforma, reportar incidencias técnicas y contactar al equipo de soporte de SmartPalm.

![Support Wireframe](../../assets/img/Applications-Wireframes/7_Support.png)

---

### 5.4.2. Applications Wireflow Diagrams

#### Web Application

##### Register

Flujo de registro de nuevo usuario: ingreso de datos personales → validación de correo → selección de tipo de cuenta (ingeniero agrónomo o dueño de cultivo) → confirmación → redirección al dashboard principal.

![Register Wireflow](../../assets/img/Applications-Wireflow-Diagrams/1_Register.png)

##### Login

Flujo de autenticación: ingreso de credenciales → validación contra el sistema → redirección al dashboard con vista personalizada según el rol del usuario (ingeniero agrónomo o dueño de cultivo).

![Login Wireflow](../../assets/img/Applications-Wireflow-Diagrams/2_Login.png)

##### Schedule

Flujo de planificación de visita de campo: selección de plantación → elección de fecha en el calendario → definición de objetivos de la visita → confirmación y registro de la visita programada.

![Schedule Wireflow](../../assets/img/Applications-Wireflow-Diagrams/3_Schedule.png)

##### History

Flujo de consulta de historial: selección de plantación → aplicación de filtros por zona y rango de fechas → visualización del listado de inspecciones e intervenciones → acceso al detalle de cada registro con trazabilidad completa.

![History Wireflow](../../assets/img/Applications-Wireflow-Diagrams/4_History.png)

---

##### Settings

Flujo de configuración de cuenta: navegación a la sección de ajustes → modificación de preferencias de notificación y parámetros de la aplicación → guardado de cambios → confirmación visual de la actualización.

![Settings Wireflow](../../assets/img/Applications-Wireflow-Diagrams/5_Settings.png)

##### Support

Flujo de soporte al usuario: acceso a la sección de ayuda → consulta de documentación frecuente o envío de ticket de incidencia → confirmación de recepción y seguimiento del caso.

![Support Wireflow](../../assets/img/Applications-Wireflow-Diagrams/6_Support.png)

---

### 5.4.3. Applications Mock-ups

#### Web Application

##### Login

Mockup del inicio de sesión, donde el usuario ingresa sus credenciales para acceder al panel principal según su rol (ingeniero agrónomo o dueño de cultivo).

![Login Mockup](../../assets/img/Applications-Mock-ups/Login.png)

##### Dashboard

Panel principal con indicadores clave: alertas activas, visitas programadas, estado de plantaciones y accesos rápidos a las funcionalidades del sistema.

![Dashboard Mockup](../../assets/img/Applications-Mock-ups/Dashboard.png)

---

##### Plantaciones

Vista de gestión de plantaciones registradas, mostrando información de cada predio, sus zonas de monitoreo y el estado fitosanitario actual.

![Plantations Mockup](../../assets/img/Applications-Mock-ups/Plantaciones.png)

##### Alertas

Listado de alertas activas por plantación, con nivel de severidad, fecha de detección y estado de atención, vinculadas al bounded context de Alert & Notification.

![Alerts Mockup](../../assets/img/Applications-Mock-ups/Alertas.png)

---

##### Dispositivos

Gestión de dispositivos IoT instalados en campo: sensores de humedad, temperatura y estaciones meteorológicas vinculadas a cada plantación para el monitoreo continuo del cultivo.

![Devices Mockup](../../assets/img/Applications-Mock-ups/Dispositivos.png)

##### Recomendaciones

Recomendaciones agronómicas generadas por el sistema para cada plantación, con trazabilidad hacia las alertas que las originaron y las intervenciones ejecutadas.

![Recommendations Mockup](../../assets/img/Applications-Mock-ups/Recomendaciones.png)

---

##### Reportes

Reportes y estadísticas del cultivo: evolución de condiciones, frecuencia de alertas por plantación, historial de intervenciones y tendencias en el tiempo.

![Reports Mockup](../../assets/img/Applications-Mock-ups/Reportes.png)

##### Suscripción

Gestión del plan de suscripción del usuario: estado del plan contratado, fecha de renovación y acceso a funcionalidades según el nivel de suscripción activa.

![Subscription Mockup](../../assets/img/Applications-Mock-ups/Suscripcion.png)

---

### 5.5. Applications Prototyping

#### Web Application

A continuación, se presenta el prototipo interactivo de la aplicación web SmartPalm, donde se evidencia el flujo de usuario completo: autenticación, panel de control, gestión de plantaciones, consulta de alertas y generación de reportes.

- **Prototipo (Figma):** [Web App - SmartPalm](https://www.figma.com/proto/bFDv7p60jPElSFuoSRZF1H/WebApp?node-id=2072-1742&p=f&t=c8TbbdnJ2ZNXnFD4-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=2072%3A75)
- **Video demostrativo (SharePoint):** [Web App - Recorrido completo](https://upcedupe-my.sharepoint.com/:v:/g/personal/u201719449_upc_edu_pe/IQDRFTcIoRRKSIPuibljwKbuATifjeCvBUGp_ySdt9_s_Kg?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=r0SlD2)

---

#### Mobile Application

A continuación, se presenta el prototipo interactivo de la aplicación móvil SmartPalm, mostrando el flujo de trabajo del ingeniero agrónomo en campo: registro de inspecciones offline, vinculación con alertas y consulta de recomendaciones.

- **Prototipo (Figma):** [Mobile App - SmartPalm](https://www.figma.com/proto/9zfoLcEEgnm15cXfdElAv6/Prototyping?node-id=1-2015&p=f&t=lTXhQ079NFQ9NE2a-1&scaling=min-zoom&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=1%3A2015)
- **Video demostrativo (SharePoint):** [Mobile App - Flujo en campo](https://upcedupe-my.sharepoint.com/:v:/g/personal/u202312318_upc_edu_pe/IQD95BReG4PVTIdWSt4Xts5IATR2tJSg7a6IYBVbzCr34Po?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=OwGYah)
