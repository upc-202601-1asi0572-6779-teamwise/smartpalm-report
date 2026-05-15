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

---

### 6.1.2. Source Code Management

El equipo utiliza Git como sistema de control de versiones y GitHub como plataforma de hosting remoto. La organización del código se estructura en repositorios separados para cada producto digital, siguiendo el principio de separación de responsabilidades.

#### Repositorios del proyecto

| Producto digital | Repositorio | Enlace |
| :--- | :--- | :--- |
| **Reporte del proyecto** | `upc-Desarrollo-IoT-Report` | [GitHub Repo](https://github.com/TempWise-DesarrolloIoT-202610/upc-Desarrollo-IoT-Report) |
| **Landing Page** | `smartpalm-landing-page` | *(Repositorio por crear)* |
| **Web Application** | `webapp-test` | [GitHub Repo](https://github.com/upc-202601-1asi0572-6779-teamwise/webapp-test) |
| **RESTful API / Backend** | `smartpalm-api` | *(Repositorio por crear)* |
| **Mobile Application** | `smartpalm-mobile-app` | *(Repositorio por crear)* |
| **Edge API** | `smartpalm-edge-api` | *(Repositorio por crear)* |
| **Embedded Application (IoT Firmware)** | `smartpalm-iot-firmware` | *(Repositorio por crear)* |

#### Estrategia de ramas: GitFlow

El equipo adopta el modelo GitFlow para gestionar el ciclo de vida del código. La estructura de ramas es la siguiente:

| Rama | Propósito |
| :--- | :--- |
| `main` | Código estable en producción. Solo recibe merge desde `release/*` o `hotfix/*`. |
| `develop` | Rama de integración continua. Recibe los merge de las ramas `feature/*` y se sincroniza periódicamente. |
| `feature/<descripción>` | Rama para el desarrollo de una funcionalidad o capítulo del reporte. Se crea desde `develop` y se mergea mediante Pull Request. |
| `release/vX.Y.Z` | Rama de preparación para una versión estable. Se crea desde `develop` y se mergea a `main`. |
| `hotfix/<descripción>` | Rama para correcciones urgentes en producción. Se crea desde `main` y se mergea a `main` y `develop`. |

#### Convención de commits: Conventional Commits

Los mensajes de commit siguen el estándar Conventional Commits para mantener trazabilidad y generar changelogs automáticos.

| Prefijo | Uso | Ejemplo |
| :--- | :--- | :--- |
| `feat:` | Nueva funcionalidad | `feat: add login form for agronomist` |
| `fix:` | Corrección de error | `fix: correct sensor reading validation` |
| `docs:` | Documentación | `docs: update API documentation` |
| `test:` | Pruebas | `test: add unit tests for device service` |
| `refactor:` | Refactorización de código | `refactor: simplify threshold evaluation logic` |
| `style:` | Cambios de formato | `style: adjust indentation in dashboard component` |
| `chore:` | Tareas de mantenimiento | `chore: update dependencies` |

#### Versionado semántico

El proyecto utiliza Semantic Versioning (`vMAJOR.MINOR.PATCH`):

| Versión | Significado |
| :--- | :--- |
| `v1.0.0` | Primera versión estable con funcionalidades del Sprint 1 desplegadas. |
| `v1.1.0` | Nuevas funcionalidades (minor) agregadas en Sprint 2. |
| `v1.1.1` | Corrección de errores (patch) sobre la versión 1.1.0. |

---

### 6.1.3. Source Code Style Guide & Coding Conventions

El equipo TempWise acordó estándares de escritura de código para cada lenguaje involucrado en la solución, con el fin de garantizar legibilidad, mantenibilidad y consistencia entre los integrantes.

#### Lenguajes y guías de referencia

| Lenguaje / Framework | Guía de estilo de referencia |
| :--- | :--- |
| **TypeScript** (Angular) | Google TypeScript Style Guide, Angular Style Guide |
| **C#** (ASP.NET Core) | Microsoft C# Coding Conventions, Framework Design Guidelines |
| **Dart** (Flutter) | Effective Dart Style Guide |
| **C++** (Arduino / ESP32) | Google C++ Style Guide (adaptado a microcontroladores) |
| **HTML / CSS** | Google HTML/CSS Style Guide |
| **Gherkin** (BDD / Acceptance Tests) | Cucumber Gherkin Reference |

#### Convenciones de nomenclatura

| Elemento | Convención | Ejemplo |
| :--- | :--- | :--- |
| Clases / Interfaces | PascalCase | `SensorReading`, `AgronomicThreshold` |
| Métodos / Funciones | camelCase | `evaluateThreshold()`, `registerDevice()` |
| Variables locales | camelCase | `currentReading`, `alertLevel` |
| Constantes | UPPER_SNAKE_CASE | `MAX_OFFLINE_STORAGE_HOURS` |
| Archivos TypeScript / Dart | kebab-case | `sensor-reading.service.ts` |
| Archivos C# | PascalCase | `SensorReadingService.cs` |
| Nombres de ramas Git | kebab-case | `feature/add-login-form` |
| Commits | inglés, imperativo | `feat: add real-time alert dispatch` |

#### Reglas generales

- Todo el código fuente, comentarios técnicos y nombres de variables se redactan en **inglés**, salvo los textos visibles al usuario que se adaptan al idioma objetivo (español latinoamericano para el productor amazónico).
- Cada archivo fuente incluye un encabezado de copyright con el nombre del proyecto, el autor y la licencia.
- Se prohíbe el *hard-coding* de valores mágicos; deben declararse como constantes con nombres descriptivos.
- El código debe estar documentado con JSDoc (TypeScript), XML Documentation (C#) o DartDoc (Dart) para métodos públicos y clases del dominio.
