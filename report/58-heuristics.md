### 6.3.3. Evaluaciones según Heurísticas

---

## Evaluación 1 — Landing Page

| Campo | Detalle |
| :--- | :--- |
| **CARRERA** | Ingeniería de Software |
| **CURSO** | Desarrollo de Soluciones IoT |
| **SECCIÓN** | 6779 |
| **PROFESORES** | León Baca, Marco Antonio · Prudencio Vidal, Javier Antonio · Velásquez Núñez, Ángel Augusto · Vera Olivera, David Carlos |
| **AUDITOR** | Equipo TempWise |
| **CLIENTE(S)** | Usuarios representativos de los segmentos objetivo (dueño del cultivo / ingeniero agrónomo) |

**SITE o APP A EVALUAR:** Smart Palm — Landing Page  
**URL:** https://smart-palm.netlify.app/

**TAREAS A EVALUAR:**

El alcance de esta evaluación incluye la revisión de la usabilidad de las siguientes tareas:

1. Comprensión de la propuesta de valor de Smart Palm al primer vistazo.
2. Identificación de los planes de suscripción disponibles y sus diferencias.
3. Localización del call-to-action para acceder a la Web Application o descargar la Mobile Application según el rol.
4. Acceso a información de contacto e información institucional sobre TempWise.

No están incluidas en esta versión de la evaluación las siguientes tareas:

1. Proceso de registro o inicio de sesión (redirige a la Web Application).
2. Reproducción del video About-the-Product (pendiente de publicación).

---

**ESCALA DE SEVERIDAD:**

| Nivel | Descripción |
| :--- | :--- |
| 1 | Problema superficial: puede ser fácilmente superado por el usuario u ocurre con muy poca frecuencia. No necesita ser corregido a menos que exista disponibilidad de tiempo. |
| 2 | Problema menor: puede ocurrir con mayor frecuencia o es un poco más difícil de superar. Se le debería asignar prioridad baja para el siguiente release. |
| 3 | Problema mayor: ocurre frecuentemente o los usuarios no son capaces de resolverlo. Es importante corregirlo y se le debe asignar prioridad alta. |
| 4 | Problema muy grave: impide al usuario continuar con el uso de la herramienta. Es imperativo corregirlo antes del lanzamiento. |

---

**TABLA RESUMEN:**

| # | Problema | Escala de severidad | Heurística / Principio violado |
| :--- | :--- | :---: | :--- |
| 1 | El call-to-action principal no diferencia visualmente entre el rol de productor y el rol de agrónomo, dificultando que cada segmento identifique rápidamente su punto de acceso. | 3 | Usability: Visibilidad del estado del sistema · Coincidencia entre el sistema y el mundo real |
| 2 | La sección de planes de suscripción no indica de forma explícita cuál plan está recomendado para un productor con una cantidad determinada de hectáreas. | 2 | Information Architecture: Is it useful? · Is it clear? |
| 3 | Las imágenes decorativas del Landing Page no incluyen atributo `alt` descriptivo, lo que impide la lectura por parte de lectores de pantalla. | 3 | Inclusive Design: Comparable experience · Equivalence |

---

**DESCRIPCIÓN DE PROBLEMAS:**

**PROBLEMA #1:** El call-to-action no diferencia entre segmentos de usuario

Severidad: 3

Heurística violada: Usability — Coincidencia entre el sistema y el mundo real

Problema: El botón principal de llamada a la acción ("Comenzar ahora" o equivalente) no especifica si dirige al productor a la descarga de la aplicación móvil o al agrónomo al acceso web. Un visitante que no ha leído todo el contenido puede pulsar el botón incorrecto o dudar en cuál de las dos acciones ejecutar, especialmente si accede directamente a la sección hero sin haber navegado el resto de la página.

Recomendación: Duplicar el call-to-action en dos botones claramente diferenciados por etiqueta y color: uno dirigido al productor ("Descargar la app") y otro al agrónomo ("Acceder a la plataforma"). Ubicarlos en la sección hero con jerarquía visual equilibrada.

---

**PROBLEMA #2:** La sección de precios no orienta la elección según escala de operación

Severidad: 2

Heurística violada: Information Architecture — Is it useful?

Problema: La sección de planes presenta los precios y características de cada nivel, pero no ofrece ninguna indicación de para qué tamaño de plantación está pensado cada plan (por ejemplo, "Hasta 20 ha", "De 20 a 60 ha"). Un productor que gestiona 45 hectáreas no puede inferir fácilmente cuál plan le corresponde sin leer las condiciones completas.

Recomendación: Añadir una etiqueta o subtítulo en cada plan que indique el rango de hectáreas recomendado, o incluir una pregunta de orientación tipo "¿Cuántas hectáreas gestiona?" con redirección al plan sugerido.

---

**PROBLEMA #3:** Imágenes sin texto alternativo

Severidad: 3

Heurística violada: Inclusive Design — Comparable experience

Problema: Las imágenes utilizadas en el Landing Page —incluyendo capturas de la aplicación y fotografías de palma aceitera— no cuentan con atributo `alt` descriptivo. Usuarios con discapacidad visual que utilizan lectores de pantalla no pueden acceder al contenido visual de la página, lo que genera una experiencia incompleta e inequitativa.

Recomendación: Añadir atributo `alt` descriptivo a todas las imágenes con contenido significativo. Para imágenes meramente decorativas, usar `alt=""` para que el lector de pantalla las omita.

---

---

## Evaluación 2 — Web Application

| Campo | Detalle |
| :--- | :--- |
| **CARRERA** | Ingeniería de Software |
| **CURSO** | Desarrollo de Soluciones IoT |
| **SECCIÓN** | 6779 |
| **PROFESORES** | León Baca, Marco Antonio · Prudencio Vidal, Javier Antonio · Velásquez Núñez, Ángel Augusto · Vera Olivera, David Carlos |
| **AUDITOR** | Equipo TempWise |
| **CLIENTE(S)** | Usuarios representativos del segmento ingeniero agrónomo |

**SITE o APP A EVALUAR:** Smart Palm — Web Application  
**URL:** https://webapp-9sf.pages.dev

**TAREAS A EVALUAR:**

El alcance de esta evaluación incluye la revisión de la usabilidad de las siguientes tareas:

1. Inicio de sesión como ingeniero agrónomo.
2. Registro de nuevo usuario.
3. Planificación de una visita de campo (Schedule).
4. Consulta del historial de inspecciones con filtros (History).
5. Modificación de preferencias de cuenta (Settings).

No están incluidas en esta versión de la evaluación las siguientes tareas:

1. Gestión de umbrales agronómicos (funcionalidad en integración con backend real).
2. Exportación de reportes (pendiente de implementación).

---

**ESCALA DE SEVERIDAD:**

| Nivel | Descripción |
| :--- | :--- |
| 1 | Problema superficial: puede ser fácilmente superado por el usuario u ocurre con muy poca frecuencia. |
| 2 | Problema menor: puede ocurrir con mayor frecuencia o es un poco más difícil de superar. Prioridad baja para el siguiente release. |
| 3 | Problema mayor: ocurre frecuentemente o los usuarios no son capaces de resolverlo. Prioridad alta. |
| 4 | Problema muy grave: impide al usuario continuar con el uso de la herramienta. Imperativo corregirlo antes del lanzamiento. |

---

**TABLA RESUMEN:**

| # | Problema | Escala de severidad | Heurística / Principio violado |
| :--- | :--- | :---: | :--- |
| 1 | La aplicación no muestra un indicador de carga cuando obtiene datos del servidor, dejando al usuario sin retroalimentación durante la espera. | 3 | Usability: Visibilidad del estado del sistema |
| 2 | El flujo de registro no indica cuántos pasos quedan por completar, lo que puede generar abandono prematuro. | 2 | Usability: Reconocimiento en lugar de recuerdo · Estética y diseño minimalista |
| 3 | Los mensajes de error al enviar formularios con datos inválidos son genéricos ("Error al procesar") y no orientan al usuario sobre qué campo corregir. | 3 | Usability: Ayuda al usuario a reconocer, diagnosticar y recuperarse de errores |

---

**DESCRIPCIÓN DE PROBLEMAS:**

**PROBLEMA #1:** Ausencia de indicador de carga durante peticiones al servidor

Severidad: 3

Heurística violada: Usability — Visibilidad del estado del sistema

Problema: Cuando el usuario navega entre secciones o envía un formulario, la aplicación no muestra ningún indicador visual de que está procesando la solicitud (spinner, barra de progreso o mensaje de "cargando"). El usuario queda sin retroalimentación durante el tiempo de respuesta del servidor, lo que lo puede llevar a hacer clic múltiples veces o a pensar que la aplicación está congelada.

Recomendación: Añadir un indicador de carga global (spinner o skeleton screen) que se active en cada petición asíncrona y se desactive una vez que los datos estén disponibles. Angular Material incluye el componente `MatProgressSpinner` y `MatProgressBar` que pueden integrarse fácilmente.

---

**PROBLEMA #2:** El flujo de registro no incluye indicador de progreso

Severidad: 2

Heurística violada: Usability — Reconocimiento en lugar de recuerdo

Problema: El proceso de creación de cuenta para un ingeniero agrónomo involucra varios pasos (datos personales, validación de correo, selección de tipo de cuenta, confirmación), pero la interfaz no muestra en cuál paso se encuentra el usuario ni cuántos pasos quedan. Esto reduce la sensación de control del usuario y puede generar abandono antes de completar el registro.

Recomendación: Incorporar un componente de stepper (por ejemplo, `MatStepper` de Angular Material) que muestre visualmente los pasos del flujo de registro y resalte el paso activo. Añadir en cada paso un botón "Anterior" para permitir correcciones sin perder el progreso.

---

**PROBLEMA #3:** Mensajes de error de formularios no son específicos

Severidad: 3

Heurística violada: Usability — Ayuda al usuario a reconocer, diagnosticar y recuperarse de errores

Problema: Cuando el usuario envía un formulario con datos incorrectos o incompletos (por ejemplo, durante el login o el registro), la aplicación muestra un mensaje genérico de error sin indicar cuál campo tiene el problema ni qué formato se espera. El usuario debe revisar todos los campos manualmente para encontrar el error.

Recomendación: Mostrar mensajes de error en línea, junto al campo específico que lo origina, en el momento en que el campo pierde el foco o al intentar enviar el formulario. Los mensajes deben describir el problema concreto ("El correo ingresado no tiene un formato válido") y el formato esperado cuando aplique.

---

---

## Evaluación 3 — Mobile Application

| Campo | Detalle |
| :--- | :--- |
| **CARRERA** | Ingeniería de Software |
| **CURSO** | Desarrollo de Soluciones IoT |
| **SECCIÓN** | 6779 |
| **PROFESORES** | León Baca, Marco Antonio · Prudencio Vidal, Javier Antonio · Velásquez Núñez, Ángel Augusto · Vera Olivera, David Carlos |
| **AUDITOR** | Equipo TempWise |
| **CLIENTE(S)** | Usuarios representativos del segmento dueño del cultivo de palma aceitera |

**SITE o APP A EVALUAR:** Smart Palm — Mobile Application (Android)

**TAREAS A EVALUAR:**

El alcance de esta evaluación incluye la revisión de la usabilidad de las siguientes tareas:

1. Inicio de sesión como dueño del cultivo.
2. Visualización del panel principal de plantaciones.
3. Consulta del detalle de un cultivo y sus zonas de monitoreo.
4. Consulta de alertas activas.
5. Consulta de recomendaciones agronómicas asociadas a un cultivo.

No están incluidas en esta versión de la evaluación las siguientes tareas:

1. Registro de nuevo usuario desde la aplicación móvil (se realiza desde la Web Application o el Landing Page).
2. Configuración de umbrales (funcionalidad exclusiva del ingeniero agrónomo en la Web Application).

---

**ESCALA DE SEVERIDAD:**

| Nivel | Descripción |
| :--- | :--- |
| 1 | Problema superficial: puede ser fácilmente superado por el usuario u ocurre con muy poca frecuencia. |
| 2 | Problema menor: puede ocurrir con mayor frecuencia o es un poco más difícil de superar. Prioridad baja para el siguiente release. |
| 3 | Problema mayor: ocurre frecuentemente o los usuarios no son capaces de resolverlo. Prioridad alta. |
| 4 | Problema muy grave: impide al usuario continuar con el uso de la herramienta. Imperativo corregirlo antes del lanzamiento. |

---

**TABLA RESUMEN:**

| # | Problema | Escala de severidad | Heurística / Principio violado |
| :--- | :--- | :---: | :--- |
| 1 | Las etiquetas de las variables de los sensores IoT (por ejemplo, valores numéricos de humedad o temperatura) se muestran sin unidad de medida visible, lo que dificulta su interpretación. | 3 | Usability: Coincidencia entre el sistema y el mundo real |
| 2 | Las alertas activas no están diferenciadas visualmente por nivel de severidad (crítica, moderada, informativa), mostrándose todas con el mismo estilo. | 3 | Usability: Visibilidad del estado del sistema · Information Architecture: Is it clear? |
| 3 | No existe un estado de pantalla vacía ("empty state") cuando una plantación no tiene datos de sensores registrados aún, dejando al usuario ante una pantalla en blanco sin orientación. | 2 | Usability: Ayuda al usuario a reconocer, diagnosticar y recuperarse de errores |

---

**DESCRIPCIÓN DE PROBLEMAS:**

**PROBLEMA #1:** Variables de sensores se muestran sin unidad de medida

Severidad: 3

Heurística violada: Usability — Coincidencia entre el sistema y el mundo real

Problema: En la vista de detalle de una zona de monitoreo, los valores de las variables capturadas por los sensores (temperatura, humedad del suelo, luminosidad) se presentan como números sin la unidad de medida correspondiente (°C, %, lux). Un productor sin formación técnica no puede interpretar si el valor mostrado está dentro o fuera del rango esperado para su cultivo.

Recomendación: Añadir la unidad de medida junto al valor numérico en todos los componentes de visualización de lecturas de sensores. Adicionalmente, incluir un indicador visual de estado (color verde/amarillo/rojo) basado en el umbral agronómico configurado para esa variable.

---

**PROBLEMA #2:** Las alertas no están diferenciadas por nivel de severidad

Severidad: 3

Heurística violada: Usability — Visibilidad del estado del sistema

Problema: La vista de alertas activas lista todos los eventos con el mismo diseño visual, sin distinción por nivel de criticidad. Un productor que gestiona varias zonas no puede identificar de un vistazo cuáles alertas requieren atención inmediata y cuáles son meramente informativas, lo que obliga a leer el detalle de cada una para priorizar.

Recomendación: Diferenciar las alertas visualmente mediante un código de colores consistente (rojo para crítica, amarillo para moderada, azul para informativa) y un ícono de severidad junto al título de cada alerta. Ordenarlas de mayor a menor criticidad por defecto.

---

**PROBLEMA #3:** Ausencia de estado vacío en zonas sin datos de sensores

Severidad: 2

Heurística violada: Usability — Ayuda al usuario a reconocer, diagnosticar y recuperarse de errores

Problema: Cuando una plantación o zona no tiene lecturas de sensores registradas (por ejemplo, porque el dispositivo IoT aún no ha sido vinculado o no ha transmitido datos), la aplicación muestra una pantalla en blanco sin ningún mensaje que explique la situación. El usuario no sabe si es un error, si debe esperar o si debe realizar alguna acción.

Recomendación: Implementar pantallas de "empty state" con un ícono ilustrativo, un mensaje explicativo breve ("Esta zona aún no tiene lecturas registradas") y, cuando aplique, una acción sugerida ("Contacte a su agrónomo para vincular los sensores").
