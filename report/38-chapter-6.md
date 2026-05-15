# Capítulo VI: Product Implementation, Validation & Deployment

## 6.1. Software Configuration Management

Este capítulo documenta la configuración técnica, las herramientas, las convenciones y el proceso de despliegue adoptado por el equipo TempWise para el desarrollo de SmartPalm. El objetivo es establecer un marco ordenado y trazable que sustente la implementación del producto digital y del dispositivo IoT en condiciones reales de la Amazonia peruana.

---

### 6.1.1. Software Development Environment Configuration

El equipo TempWise utilizó un conjunto de herramientas seleccionadas en función de la naturaleza del proyecto: una plataforma SaaS de monitoreo agrícola con componentes web, móvil, backend RESTful y firmware IoT embebido. La siguiente tabla consolida las herramientas, su propósito y los enlaces de acceso.

| Herramienta | Uso en el proyecto | Enlace de acceso |
| :--- | :--- | :--- |
| **GitHub** | Control de versiones, repositorios de código y colaboración del equipo | [github.com/TempWise-DesarrolloIoT-202610](https://github.com/TempWise-DesarrolloIoT-202610) |
| **Netlify** | Despliegue continuo del Landing Page | [lading-page-smartpalm.netlify.app](https://lading-page-smartpalm.netlify.app) |
| **Cloudflare Pages** | Despliegue continuo de la Web Application | [webapp-9sf.pages.dev](https://webapp-9sf.pages.dev) |
| **Render** | Despliegue de la Mock API RESTful | [smartpalm-mock-api.onrender.com](https://smartpalm-mock-api.onrender.com) |
| **Miro** | Modelado colaborativo (Big Picture EventStorming y Design-Level EventStorming) | [Tablero Big Picture](https://miro.com/app/board/uXjVK2R7nV4=/?share_link_id=837305751989) / [Tablero Design-Level](https://miro.com/app/board/uXjVHdJ_3Wo=/?share_link_id=547546845690) |
| **UXPressia** | Creación de User Personas, User Journey Maps y Empathy Maps | *(Enlace pendiente)* |
| **Figma** | Diseño de interfaces, wireframes, mock-ups y wireflows | *(Enlace pendiente)* |
| **Visual Studio / VS Code** | Entorno de desarrollo integrado para frontend, backend y firmware | *(Enlace pendiente)* |
| **Angular** | Framework de desarrollo de la Web Application | [angular.io](https://angular.io) |
| **ASP.NET Core** | Framework del backend RESTful y del Edge API | [dotnet.microsoft.com](https://dotnet.microsoft.com) |
| **Flutter** | Framework de desarrollo de la Mobile Application | [flutter.dev](https://flutter.dev) |
| **Arduino IDE / PlatformIO** | Desarrollo del firmware embebido para ESP32 | [arduino.cc](https://www.arduino.cc) |
| **Postman / Swagger UI** | Pruebas manuales y documentación automática de endpoints de la API | *(Enlace pendiente)* |
| **PlantUML** | Elaboración de diagramas de clases del Domain Layer (tactical DDD) | [plantuml.com](https://plantuml.com) |
| **Wokwi** | Simulación de circuito del dispositivo IoT antes del despliegue físico | [wokwi.com](https://wokwi.com) |
