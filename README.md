<center>

![Logo Upc](https://www.upc.edu.pe/static/img/logo_upc_red.png "Logo upc")
<br>

<h3>Universidad Peruana de Ciencias Aplicadas</h3> <br>
<center>Carrera: Ingenieria de Software</center><br>  
<center>Ciclo: 2026-10</center><br>
<center>Código del curso: 1ASI0572</center><br>
<center>Curso: Desarrollo de Soluciones IOT</center> <br>
<center>NRC: 6779</center> <br>
<center>Profesor: Angel Augusto Velasquez Nuñez</center> <br>
<center>"INFORME DE TRABAJO FINAL"</center> <br>

</center>

### <center>Startup: TempWise</center>

### <center>Producto: [COMPLETAR]</center>

### Integrantes:

<table >
    <tr>
        <th>Nombre</th>
        <th>Codigo</th>
    </tr>
    <tr>
        <td>Victor Manuel Rojas Reategui</td>
        <td>U202123655</td>
    </tr>
    <tr>
        <td>[COMPLETAR]</td>
        <td>[COMPLETAR]</td>
    </tr>
    <tr>
        <td>[COMPLETAR]</td>
        <td>[COMPLETAR]</td>
    </tr>
    <tr>
        <td>[COMPLETAR]</td>
        <td>[COMPLETAR]</td>
    </tr>
    <tr>
        <td>[COMPLETAR]</td>
        <td>[COMPLETAR]</td>
    </tr>
    <tr>
        <td>[COMPLETAR]</td>
        <td>[COMPLETAR]</td>
    </tr>
</table >

<center> Julio, 2025</center>

**Registro de Versiones del Informe:**

En esta sección se resumen todas las modificaciones relevantes que sean realizadas sobre el informe durante el ciclo de vida del proyecto.

| Versión | Fecha | Autor | Descripción de modificación |
| ------- | ----- | ----- | --------------------------- |
| V0.1    |

# Project Report Collaboration Insights

Link de Repositorio: https://github.com/TempWise-DesarrolloIoT-202610/upc-Desarrollo-IoT-Report

TB1: En esta etapa, el equipo se reunió para definir el alcance y los objetivos, asignando tareas específicas a cada miembro. Comenzamos recopilando datos y revisando información relevante, con cada miembro contribuyendo con investigaciones individuales que luego compartimos y discutimos en reuniones periódicas. En GitHub, establecimos un flujo de trabajo para colaborar en la redacción del informe, creando un repositorio dedicado con secciones divididas en archivos Markdown para facilitar la colaboración y revisión

![Capturas-TB1]()

# Contenido

- [Capítulo I: Introducción](#capítulo-i-introducción)
  - [1.1. Startup Profile](#11-startup-profile)
    - [1.1.1. Descripción de la Startup](#111-descripción-de-la-startup)
    - [1.1.2. Perfiles de integrantes del equipo](#112-perfiles-de-integrantes-del-equipo)
  - [1.2. Solution Profile](#12-solution-profile)
    - [1.2.1. Antecedentes y problemática](#121-antecedentes-y-problemática)
    - [1.2.2. Lean UX Process](#122-lean-ux-process)
      - [1.2.2.1. Lean UX Problem Statements](#1221-lean-ux-problem-statements)
      - [1.2.2.2. Lean UX Assumptions](#1222-lean-ux-assumptions)
      - [1.2.2.3. Lean UX Hypothesis Statements](#1223-lean-ux-hypothesis-statements)
      - [1.2.2.4. Lean UX Canvas](#1224-lean-ux-canvas)
    - [1.3. Segmentos objetivo](#13-segmento-objetivo)
- [Capítulo II: Requirements Elicitation & Analysis](#capítulo-ii-requirements-elicitation--analysis)
  - [2.1. Competidores](#21-competidores)
    - [2.1.1. Análisis competitivo](#211-análisis-competitivo)
    - [2.1.2. Estrategias y tácticas frente a competidores](#212-estrategias-y-tácticas-frente-a-competidores)
  - [2.2. Entrevistas](#22-entrevistas)
    - [2.2.1. Diseño de entrevistas](#221-diseño-de-entrevistas)
    - [2.2.2. Registro de entrevistas](#222-registro-de-entrevistas)
    - [2.2.3. Análisis de entrevistas](#223-análisis-de-entrevistas)
  - [2.3. Needfinding](#23-needfinding)
    - [2.3.1. User Personas](#231-user-personas)
    - [2.3.2. User Task Matrix](#232-user-task-matrix)
    - [2.3.3. User Journey Mapping](#233-user-journey-mapping)
    - [2.3.4. Empathy Mapping](#234-empathy-mapping)
    - [2.3.5. As-is Scenario Mapping](#235-as-is-scenario-mapping)
  - [2.4. Ubiquitous Language](#24-ubiquitous-language)
- [Capítulo III: Requirements Specification](#capítulo-iii-requirements-specification)
  - [3.1. To-Be Scenario Mapping](#31-to-be-scenario-mapping)
  - [3.2. User Stories](#32-user-stories)
  - [3.3. Impact Mapping](#33-impact-mapping)
  - [3.4. Product Backlog](#34-product-backlog)
- [Capítulo IV: Solution Software Design](#capítulo-iv-solution-software-design)
  - [4.1. Strategic-Level Domain-Driven Design](#41-strategic-level-domain-driven-design)
    - [4.1.1. EventStorming](#411-eventstorming)
      - [4.1.1.1. Candidate Context Discovery](#4111-candidate-context-discovery)
      - [4.1.1.2. Domain Message Flows Modeling](#4112-domain-message-flows-modeling)
      - [4.1.1.3. Bounded Context Canvases](#4113-bounded-context-canvases)
    - [4.1.2. Context Mapping](#412-context-mapping)
    - [4.1.3. Software Architecture](#413-software-architecture)
      - [4.1.3.1. Software Architecture System Landscape Diagram](#4131-software-architecture-system-landscape-diagram)
      - [4.1.3.2. Software Architecture Context Level Diagrams](#4132-software-architecture-context-level-diagrams)
      - [4.1.3.3. Software Architecture Deployment Diagrams](#4133-software-architecture-deployment-diagrams)
  - [4.2. Tactical-Level Domain-Driven Design](#42-tactical-level-domain-driven-design)
    - [4.2.X. Bounded Context: <Bounded Context Name>](#42x-bounded-context-bounded-context-name)
      - [4.2.X.1. Domain Layer](#42x1-domain-layer)
      - [4.2.X.2. Interface Layer](#42x2-interface-layer)
      - [4.2.X.3. Application Layer](#42x3-application-layer)
      - [4.2.X.4. Infrastructure Layer](#42x4-infrastructure-layer)
      - [4.2.X.5. Bounded Context Software Architecture Component Level Diagrams](#42x5-bounded-context-software-architecture-component-level-diagrams)
      - [4.2.X.6. Bounded Context Software Architecture Code Level Diagrams](#42x6-bounded-context-software-architecture-code-level-diagrams)
        - [4.2.X.6.1. Bounded Context Domain Layer Class Diagrams](#42x61-bounded-context-domain-layer-class-diagrams)
        - [4.2.X.6.2. Bounded Context Database Design Diagram](#42x62-bounded-context-database-design-diagram)

- [Conclusiones](#conclusiones)
  - [Conclusiones y recomendaciones](#conclusiones-y-recomendaciones)
  - [Video About-the-Team](#video-about-the-team)
- [Bibliografía](#bibliografía)
- [Anexos](#anexos)

# Student Outcome

**El curso contribuye al cumplimiento del Student Outcome ABET:**
**ABET – EAC - Student Outcome**

Criterio: La capacidad de funcionar efectivamente en un equipo cuyos miembros
juntos proporcionan liderazgo, crean un entorno de colaboración e inclusivo,
establecen objetivos, planifican tareas y cumplen objetivos.
En el siguiente cuadro se describe las acciones realizadas y enunciados de
conclusiones por parte del grupo, que permiten sustentar el haber alcanzado el logro
del ABET – EAC - Student Outcome 5.

| Criterio específico                                                                            | Acciones realizadas | Conclusiones |
| ---------------------------------------------------------------------------------------------- | ------------------- | ------------ |
| Trabaja en equipo para proporcionar liderazgo en forma conjunta                                |                     |              |
| Crea un entorno colaborativo e inclusivo, establece metas, planifica tareas y cumple objetivos |                     |              |

# Chapter 1

## 1.1 Startup Profile

### 1.1.1 Descripción de la Startup

TempWise es una startup peruana de tecnología agrícola (AgTech) fundada en 2026 en la ciudad de Lima, con operaciones orientadas a la Amazonia peruana. La organización nació a partir de la identificación de una brecha crítica entre la complejidad técnica que exige el manejo óptimo de cultivos tropicales como la palma aceitera y la ausencia de herramientas tecnológicas accesibles, contextualizadas y asequibles para el productor amazónico de pequeña y mediana escala.

Como propuesta principal, la startup desarrolla SmartPalm IoT, un producto enfocado en el monitoreo inteligente y en tiempo real de cultivos de palma aceitera. Este producto integra nodos IoT multisensor distribuidos en microzonas del cultivo y una plataforma digital de visualización y análisis, con el fin de brindar información útil, alertas y recomendaciones que apoyen la toma de decisiones de los actores del sector agrícola.

TempWise busca generar valor para dos segmentos clave: los dueños de cultivos y los ingenieros agrónomos. Para ello, propone una solución que facilita la supervisión continua de variables relevantes del cultivo, mejora el control operativo y promueve una gestión agrícola más eficiente, sostenible y basada en datos.

De esta manera, TempWise se posiciona como una iniciativa innovadora con potencial de transformar el manejo tradicional de la palma aceitera mediante el uso de tecnologías IoT, analítica y herramientas digitales accesibles, contribuyendo a una agricultura más moderna y con mayor capacidad de respuesta frente a las condiciones del entorno.

**Misión**: Democratizar el acceso a la agricultura de precisión para los productores de palma aceitera en la Amazonia peruana, proporcionando soluciones IoT accesibles, contextualizadas y orientadas a la acción que conviertan los datos del cultivo en decisiones agronómicas inteligentes, oportunas y rentables.

**Visión**: Convertirnos en la plataforma de referencia para la gestión tecnológica de cultivos tropicales en América Latina, comenzando con la palma aceitera en el Perú y expandiéndonos progresivamente hacia otros cultivos estratégicos de la región amazónica, contribuyendo a una agricultura más productiva, sostenible e inclusiva.

### 1.1.2 Perfiles de integrantes del equipo

<table>
  <tr>
    <th>Integrante</th>
    <th>Información</th>
    <th>Foto</th>
  </tr>
  <tr>
    <td><strong>Victor Manuel Rojas Reategui</strong></td>
    <td>
      <strong>Código de estudiante:</strong> U202123655<br><br>
      <strong>Carrera:</strong> Ingeniería de Software<br><br>
      Soy Victor Rojas y voy en el 7mo ciclo de la carrera de Ingeniería de Software. Me gusta lo rápido que cambia la tecnología en la actualidad, por lo que este curso me ayudará a expandir mis conocimientos y a explorar nuevas aplicaciones de mi carrera que no había experimentado antes.<br><br>
      Tengo conocimientos en desarrollo web para el lado frontend con Angular 21 y backend con ASP.Net para C# y Spring boot para java. También, flutter para desarrollo móvil, python básico, c++, sql, familiarizado con el marco de trabajo ágil Scrum, diseño de patrones de software, y conocimientos básicos de electronica. Considero que estás habilidades y conocimientos me servirán para desarrollar este proyecto y a seguir mejorandolas con la práctica.
    </td>
    <td align="center">
    <img src="./assets/img/team/victor.jpg" alt="Foto de Victor Manuel Rojas Reategui" width="160"> 
    </td>
  </tr>
  <tr>
    <td><strong>[COMPLETAR NOMBRE]</strong></td>
    <td>
      <strong>Código de estudiante:</strong> [COMPLETAR]<br><br>
      <strong>Carrera:</strong> [COMPLETAR]<br><br>
      [COMPLETAR DESCRIPCIÓN DEL INTEGRANTE]<br><br>
      [COMPLETAR CONOCIMIENTOS Y APORTE AL EQUIPO]
    </td>
    <td align="center">
      [COMPLETAR FOTO]
    </td>
  </tr>
    <tr>
    <td><strong>Javier Oswaldo Tello Murga</strong></td>
    <td>
      <strong>Código de estudiante:</strong> U202218387<br><br>
      <strong>Carrera:</strong> Ingeniería de Software, Universidad Peruana de Ciencias Aplicadas (UPC)<br><br>
      Soy estudiante de Ingeniería de Software en la Universidad Peruana de Ciencias Aplicadas. Me caracterizo por ser una persona responsable, con disposición para aprender continuamente y fortalecer mis conocimientos en temas relacionados con mi formación profesional. Dentro del equipo, aporto compromiso, interés por el trabajo colaborativo y motivación para contribuir activamente en el desarrollo del proyecto.<br><br>
      Cuento con conocimientos en WordPress básico, HTML, CSS y JavaScript, Python a nivel básico, fundamentos de base de datos y bases de programación en C++. Estas competencias me permiten apoyar en tareas de documentación, desarrollo web y comprensión de las tecnologías que forman parte de la solución.
    </td>
    <td align="center">
      <img src="./assets/img/team/integrante-javiertello.jpg" alt="Foto de Javier Oswaldo Tello Murga" width="160">
    </td>
  </tr>
  <tr>
    <td><strong>[COMPLETAR NOMBRE]</strong></td>
    <td>
      <strong>Código de estudiante:</strong> [COMPLETAR]<br><br>
      <strong>Carrera:</strong> [COMPLETAR]<br><br>
      [COMPLETAR DESCRIPCIÓN DEL INTEGRANTE]<br><br>
      [COMPLETAR CONOCIMIENTOS Y APORTE AL EQUIPO]
    </td>
    <td align="center">
      [COMPLETAR FOTO]
    </td>
  </tr>
  <tr>
    <td><strong>[COMPLETAR NOMBRE]</strong></td>
    <td>
      <strong>Código de estudiante:</strong> [COMPLETAR]<br><br>
      <strong>Carrera:</strong> [COMPLETAR]<br><br>
      [COMPLETAR DESCRIPCIÓN DEL INTEGRANTE]<br><br>
      [COMPLETAR CONOCIMIENTOS Y APORTE AL EQUIPO]
    </td>
    <td align="center">
      [COMPLETAR FOTO]
    </td>
  </tr>
  <tr>
    <td><strong>[COMPLETAR NOMBRE]</strong></td>
    <td>
      <strong>Código de estudiante:</strong> [COMPLETAR]<br><br>
      <strong>Carrera:</strong> [COMPLETAR]<br><br>
      [COMPLETAR DESCRIPCIÓN DEL INTEGRANTE]<br><br>
      [COMPLETAR CONOCIMIENTOS Y APORTE AL EQUIPO]
    </td>
    <td align="center">
      [COMPLETAR FOTO]
    </td>
  </tr>
</table>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | [COMPLETAR]                                                                                                   |

## 1.2 Solution Profile
### 1.2.1 Antecedentes y problemática

La palma aceitera (*Elaeis guineensis* Jacq.) se cultivó por primera vez en el Perú en 1960 en la provincia de Tocache, región San Martín. En Ucayali, la producción a pequeña escala se inició en la década de los noventa con el respaldo del Programa de las Naciones Unidas para el Desarrollo (PNUD), que la promovió como cultivo alternativo a la hoja de coca. Entre 1995 y 2010, el cultivo contribuyó al reemplazo de más de 25 000 hectáreas de coca ilegal en todo el país, consolidándose como un instrumento de desarrollo económico y reconversión productiva en zonas históricamente vulnerables de la Amazonia (MIDAGRI, 2026).

A partir de este período fundacional, el sector creció de forma acelerada. Al año 2020, la superficie instalada superaba las 116 000 hectáreas, de las cuales 80 000 se encontraban en producción, concentradas principalmente en San Martín, Ucayali, Loreto y Huánuco (MIDAGRI, citado en Gestión, 2022). Para 2026, según la Resolución Ministerial N° 0046-2026-MIDAGRI, que incorpora a la palma aceitera entre los cinco cultivos estratégicos priorizados para la agricultura familiar peruana, existen más de 120 000 hectáreas cultivadas a nivel nacional, de las cuales aproximadamente 95 000 ya se encuentran en producción activa. Ucayali lidera el área con más de 60 000 hectáreas, respaldada por la disponibilidad de tierras previamente intervenidas y la conectividad de la Carretera Federico Basadre, su principal corredor productivo. La producción nacional alcanza aproximadamente 280 000 toneladas anuales de aceite crudo de palma (ACP), procesadas íntegramente en más de 15 plantas extractoras y refinerías a lo largo del país (Business Empresarial, 2026).

El impacto socioeconomico del secto es significativo. La actividad genera más de 40000 puestos de trabajo directos e indirectos anuales (JUNPALMA, 2025), beneficiaa más de 7200 familias y representa el 1,8% del Producto Bruto Interno de toda la selva peruana, con participaciones del 3,4% en San Martin y del 1,5% en Ucayali (MIDAGRI, 2021). En términos de política pública, el MIDAGRI publicó en marzo de 2025 el Instrumento de Gestión para el Desarrollo Sostenible de la Palma Aceitera en el Perú, periodo 2025-2034, que propone incrementar la frontera agrícola y mejorar la competitividad de la cadena con enfoque de sostenibilidad, reconociendo la Amazonia como el territorio con condiciones agroclimáticas óptimas para el desarrollo del cultivo (Mongabay, abril 2025). Estos datos confirman que la palmicultura amazónica es un sector en expansión, estratégico para el Estado y con alto potencial de crecimiento.

Sin embargo, este crecimiento sostenido en superficie y producción no se ha traducido en mejoras proporcionales de productividad para el pequeño y mediano palmicultor. El Plan de Competitividad de la Palma Aceitera de Ucayali 2016–2026 documenta que el productor tradicional de la región obtiene alrededor de 10 t de Racimos de Fruta Fresca (RFF)/ha/año, mientras que el promedio regional para el productor promedio se ubica actualmente entre 15 y 16 t/ha/año según datos de Agraria.pe (2023). Ambas cifras contrastan marcadamente con el potencial demostrado: opearciones tecnificadas en Ucayali alcanzaron 21 t/ha en 2023 (Agraria.pe, 2023), y el Manual del Cultivo de Palma Aceitera del INIAP certifica que con la variedad INIAP-Tenera bajo manejo óptimo es posible obtener al menos 35 t/ha. El propio Plan de Competitividad identifica como causa directa de esta brecha el escaso servicio de transferencia de tecnología, la insuficiente asistencia técnica y el bajo nivel de conocimiento del manejo agronómico por parte de los productores, señalando que en 2016 solo el 25% de los palmicultores de Ucayali conocía el manejo adecuado del cultivo, con una meta institucional de alcanzar el 70% hacia 2026 (Gobierno Regional de Ucayali, 2016).

Esta realidad motivó iniciativas de cooperación internacional para cerrar la brecha. El Proyecto Paisajes Productivos Sostenibles en la Amazonia Peruana (PPS), ejecutado por el Ministerio del Ambiente con cooperación técnica del PNUD y financiamiento del GEF, formalizó el reconocimiento de las brechas tecnológicas y productivas existentes en Ucayali y Huánuco, y articuló una alianza entre JUNPALMA, el Comité Central de Palmicultores de Ucayali (COCEPU), la Asociación de Palmicultores de Shambillo (ASPASH) y la organización colombiana CENIPALMA para acompañar a más de 500 palmicultores que intervienen en más de 7500 hectáreas en la incorporación de buenas prácticas agronómicas y estándares de sostenibilidad (PNUD-PPS, 2022). La existencia de esta alianza confirma que la brecha tecnológica en la palmicultura amazónica peruana es un problema reconocido institucionalmente al más alto nivel, y que los mecanismos informales de transferencia de conocimiento disponibles hasta ahora resultan insuficientes para su dimensión y urgencia.

Las condiciones agroecológicas de la región refuerzan la necesidad de monitoreo continuo. Según el Manual del Cultivo de Palma Aceitera para la Región de Ucayali (INIA, 2018), la zona se caracteriza por un clima cálido húmedo con temperaturas entre 24 y 32 °C, precipitaciones anuales de 1800 a 3500 mm y suelos de pH variable entre 4,5 y 6,5. La alta pluviosidad demanda vigilancia fitosanitaria permanente, dado que las condiciones de humedad extrema favorecen enfermedades de alta incidencia como la Marchitez Sorpresiva y el Anillo Rojo en todo el eje palmicultor de la Carretera Federico Basadre. A este escenario se suma el riesgo climático emergente: el MIDAGRI reportó en abril de 2026 que el Fenómeno El Niño costero persistirá en el Perú hasta enero de 2027 con intensidad potencialmente modersda entre junio y julio de 2026, elevando la exposición del cultivo a variaciones térmicas e hídricas que intensifican el estrés de las plantas y crean condiciones propicias para el desarrollo de patógenos.

**Objetivo principal**:

Desarrollar una solución IoT para el monitoreo en tiempo real de cultivos de palma aceitera, que permita supervisar variables críticas del cultivo y apoyar la toma de decisiones oportunas para mejorar la productividad, el control y la sostenibilidad de la plantación.

**Objetivos específicos**:

- Monitorear variables relevantes del cultivo, como humedad, temperatura, luz, indicadores de minerales y condiciones asociadas a la presencia de plagas.
- Generar alertas y notificaciones oportunas sobre cambios o anomalías en el estado del cultivo.
- Facilitar la visualización de información mediante reportes, paneles de control y analíticas de tendencias.
- Apoyar la toma de decisiones del dueño del cultivo y del ingeniero agrónomo mediante recomendaciones basadas en datos.
- Promover una gestión más eficiente de recursos como agua, fertilizantes y tiempo de supervisión en campo.

**Restricciones**:

- La solución debe adaptarse a contextos de conectividad limitada o intermitente en zonas agrícolas.
- El prototipo debe ser viable dentro del alcance académico, técnico y temporal del curso.
- El monitoreo se realizará mediante nodos IoT multisensor distribuidos en microzonas representativas del cultivo, y no necesariamente a nivel individual para cada planta.
- La solución debe responder a las necesidades de dos segmentos objetivo distintos: el dueño del cultivo y el ingeniero agrónomo.
- El sistema debe integrarse con una plataforma digital que permita visualizar datos, alertas y recomendaciones de manera clara, accesible y útil para ambos segmentos.

#### Técnica 5Ws y 2Hs

**Who (¿Quién?):** Los principales afectados son los dueños de cultivos de palma aceitera de pequeña y mediana escala y los ingenieros agrónomos que supervisan múltiples plantaciones en las zonas productoras de la Amazonia peruana. Según la Resolución Ministerial N° 0046-2026-MIDAGRI, más del 70% de las 95000 hectáreas en producción activa es gestionado por pequeños y medianos productores organizados en asociaciones y cooperativas. Cada productor atiende típicamente entre 5 y 8 hectáreas con labores manuales de campo, en contraste con el promedio de Malasia donde un productor gestiona entre 10 y 15 hectáreas con mecanización (Ivanova, 2015). El CITTEPALMA (Centro de Innovación y Transferencia de Tecnología para Palma Aceitera promovido por el MIDAGRI) fue creado con el objetivo explícito de reducir la brecha tecnológica entre la producción actual y el potencial del cultivo mediante capacitación directa a pequeños productores (MIDAGRI, 2012), lo que confirma que este segmento ha sido históricamente subatendido en materia de tecnificación.

**What (¿Qué?):** La problemática central es la ausencia de herramientas tecnológicas accesibles que permitan el monitoreo continuo y en tiempo real del estado agronómico de los cultivos de palma aceitera en la Amazonia peruana. Los productores carecen de datos objetivos sobre variables críticas como humedad del suelo, temperatura, pH, conductividad eléctrica y estado fitosanitario de las plantas, lo que los obliga a tomar decisiones agronómicas de manera reactiva, tardía e imprecisa. El Plan de Competitividad de Ucayali 2016–2026 identifica explícitamente como debilidad estructural del sector tanto la falta de un sistema de información tecnológica y comercial como el escaso servicio de transferencia de tecnología y asistencia técnica. A escala nacional, el MIDAGRI reconoce que más del 60% de la demanda de aceites vegetales para alimentos se atiende con importaciones y más del 90% del componente energético de biocombustibles proviene del extranjero, desaprovechando el potencial productivo interno precisamente por la insuficiencia en el manejo tecnológico del cultivo (Resolución Ministerial N° 0120-2021-MIDAGRI).

**Where (¿Dónde?):** El problema se concentra en las regiones palmicultoras de la Amazonia peruana. Ucayali es la región con mayor superficie cultivada, con más de 60000 hectáreas al 2026 (MIDAGRI, 2026), donde la actividad se desarrolla principalmente a lo largo del corredor Pucallpa–Aguaytía (Carretera Federico Basadre), en los distritos de Campo Verde, Padre Abad y Coronel Portillo. En enero de 2024, el Gobierno Regional de Ucayali y la Municipalidad Provincial de Padre Abad cofinanciaron un proyecto de S/ 6,3 millones para mejorar las capacidades técnicas productivas de 1399 familias palmicultoras en 25 comunidades del valle de Shambillo, evidenciando la escala del déficit de asistencia técnica que persiste en la zona (Inforegión, 2024). Estas áreas se caracterizan por conectividad de telecomunicaciones deficiente, infraestructura vial que dificulta el desplazamiento de técnicos, y lejanía de centros urbanos con servicios especializados.

**When (¿Cuándo?):** El problema es permanente a lo largo de todo el ciclo productivo, pero se agudiza en tres momentos críticos propios del entorno amazónico. El primero es el período de establecimiento del cultivo en los primeros 28 a 36 meses hasta el inicio de cosecha (INIA, 2018), cuando las plantas son más vulnerables a errores de manejo y deficiencias nutricionales. El segundo es la época de alta precipitación y anomalías climáticas: la Marchitez Sorpresiva y el Anillo Rojo tienen su mayor incidencia durante los períodos de mayor humedad, y el Fenómeno El Niño proyectado hasta enero de 2027 agrava este riesgo de manera sostenida (MIDAGRI, abril 2026). A modo de precedente regional, en Colombia la Pudrición del Cogollo y la sequía derivada del Fenómeno El Niño determinaron una caída del 6,6% en la producción nacional de aceite de palma en 2024 respecto a 2023 (Fedepalma, diciembre 2024), ilustrando el impacto sectorial que genera un monitoreo insuficiente ante eventos climáticos extremos. El tercer momento crítico es el período de cosecha, cuando una detección tardía de condiciones adversas ya no permite revertir el daño acumulado en la producción.

**Why (¿Por qué?):** La causa raíz es una brecha tecnológica estructural con reconocimiento institucional múltiple y sostenido. El Proyecto PPS del PNUD-GEF formalizó en 2022 el reconocimiento de brechas tecnológicas en Ucayali y Huánuco que requieren programas de entrenamiento adaptados al contexto local. El presidente del Consejo Directivo de JUNPALMA declaró públicamente la necesidad de pasar de una palmicultura tradicional a una más sostenible con mayor tecnificación (Agraria.pe, 2022). El MIDAGRI, a través del Instrumento de Gestión 2025–2034, reconoce la necesidad de mejorar la productividad y la competitividad de la cadena sin establecer herramientas tecnológicas concretas de monitoreo para el productor individual, dejando esa brecha abierta para soluciones del sector privado (Mongabay, 2025). A estas causas se suman la escasa capacidad financiera de los pequeños palmicultores para acceder a tecnología de precisión de alto costo, la débil articulación entre empresas, universidades y centros de investigación, y la ausencia de sistemas de información tecnológica y comercial adaptados a las condiciones de la Amazonia peruana.

**How (¿Cómo?):** La problemática se manifiesta en un ciclo reactivo que caracteriza la gestión de la mayoría de plantaciones amazónicas: el productor realiza inspecciones manuales esporádicas de su cultivo, detecta problemas cuando los síntomas visuales ya son irreversibles, convoca a un técnico que puede tardar días en llegar dadas las distancias y el estado de las vías rurales, y aplica una intervención que en muchos casos ya no puede revertir el daño acumulado. El Manual del Cultivo de Palma Aceitera para Ucayali (INIA, 2018) advierte que la Marchitez Sorpresiva puede acabar con una plantación completa si no se actúa de inmediato al eliminar la fuente de inóculo, intervención que resulta prácticamente inalcanzable sin un sistema de detección continua en campo.

**How Much (¿Cuánto?):** Las pérdidas económicas derivadas de una gestión agronómica deficiente son cuantificables con precisión. El Plan de Competitividad de Ucayali 2016–2026 establece que en un escenario de producción de 10 t de RFF/ha/año, rendimiento del productor tradicional sin tecnificación, a un precio de USD 90/t y costos de mantenimiento de USD 850/ha, la utilidad neta es de apenas USD 50/ha/año, situación que ante una baja del precio puede derivar en pérdidas netas. En contraste, con una productividad de 20 t/ha a USD 130/t, la utilidad sube a USD 1750/ha/año (Gobierno Regional de Ucayali, 2016): la brecha entre ambos escenarios, de hasta USD 1700/ha/año, es directamente atribuible a la calidad de la gestión agronómica y representa el valor económico que Smart Palm puede contribuir a capturar. A nivel fitosanitario, el Manual del Cultivo de Palma Aceitera del INIAP documenta que los insectos defoliadores como *Alurnus humeralis* pueden provocar defoliaciones de entre el 30% y el 50% del área foliar en períodos de alta incidencia (INIAP, 2018), y que la Marchitez Sorpresiva puede destruir una plantación completa de no actuarse de forma oportuna (INIA, 2018). Aplicando los rangos de daño documentados sobre el ingreso de un productor promedio con 10 hectáreas en Ucayali, con producción de 150 a 160 t/año a rendimiento promedio de 15–16 t/ha/año (Agraria.pe, 2023), las pérdidas por evento fitosanitario no controlado pueden oscilar entre USD 4050 y la pérdida total del ingreso del ciclo. A nivel de riesgo sistémico regional, el Manual del INIAP registra que la Pudrición del Cogollo diezmó aproximadamente 25000 hectáreas en el noroccidente del Ecuador (ANCUPA, 2014); con 95000 hectáreas en producción activa en la Amazonia peruana y el agravante del Fenómeno El Niño proyectado hasta 2027, la exposición potencial del sector peruano a este tipo de evento justifica de manera contundente la inversión en herramientas de monitoreo continuo y detección temprana como las que propone Smart Palm.


### 1.2.2 Lean UX Process

#### 1.2.2.1 Lean UX Problem Statements

En el dominio de la gestión agrícola de cultivos de palma aceitera, los dueños de cultivos y los ingenieros agrónomos enfrentan dificultades para supervisar de manera continua y precisa el estado del cultivo, debido a que gran parte del monitoreo todavía depende de revisiones manuales, observación empírica y registros no centralizados.

El segmento de dueños de cultivos necesita tener mayor control sobre la condición general de la plantación, optimizar el uso de recursos y reducir riesgos que afecten la productividad y rentabilidad. Por su parte, el segmento de ingenieros agrónomos necesita contar con información técnica más confiable, actualizada y accesible para evaluar el estado del cultivo, detectar anomalías y formular recomendaciones de manejo oportunas.

Actualmente, ambos segmentos experimentan problemas como falta de visibilidad en tiempo real, respuesta tardía ante cambios en el cultivo, dificultad para identificar tendencias y uso poco eficiente de agua, fertilizantes y tiempo de supervisión. La brecha principal radica en la ausencia de una solución tecnológica que permita monitorear variables críticas del cultivo, transformar esos datos en información útil y apoyar la toma de decisiones de forma continua y accesible.

Por ello, la visión de la solución consiste en desarrollar un ecosistema digital basado en nodos IoT multisensor distribuidos en microzonas del cultivo, integrados con una plataforma que permita visualizar datos, generar alertas, analizar tendencias y ofrecer recomendaciones útiles para la gestión del cultivo de palma aceitera.

Como estrategia inicial, la solución se enfocará primero en atender a los dueños de cultivos y a los ingenieros agrónomos que requieran mejorar el monitoreo, control y análisis de plantaciones de palma aceitera, brindándoles una herramienta tecnológica que facilite una gestión más eficiente, preventiva y basada en datos.

#### 1.2.2.2 Lean UX Assumptions

**1. Business Assumptions**:

- Se asume que los cultivos de palma aceitera necesitan una solución tecnológica que permita mejorar el monitoreo del cultivo y optimizar la toma de decisiones agrícolas.

- Se asume que una solución basada en IoT puede aportar valor al negocio al reducir la incertidumbre en el manejo del cultivo y promover un uso más eficiente de recursos como agua, fertilizantes y tiempo de supervisión.

- Se asume que el acceso a información en tiempo real puede contribuir a mejorar la productividad, el control y la sostenibilidad de la plantación.

**2. Outcome Assumptions**:

- Se asume que la implementación de la solución permitirá un mayor control sobre el estado del cultivo.

- Se asume que la solución ayudará a detectar cambios o anomalías de forma más oportuna.

- Se asume que el uso de datos y analíticas favorecerá decisiones más precisas y una gestión más eficiente del cultivo.

**3. User Assumptions**:

- Se asume que los dueños de cultivos necesitan información clara, accesible y actualizada para supervisar la plantación y proteger su rentabilidad.

- Se asume que los ingenieros agrónomos requieren datos continuos y confiables para evaluar la condición del cultivo y formular recomendaciones técnicas.

- Se asume que ambos segmentos tienen dificultades para monitorear el cultivo únicamente mediante observación manual o registros dispersos.

**4. Feature Assumptions**:

- Se asume que el monitoreo de variables como humedad, temperatura, luz, indicadores de minerales y condiciones asociadas a la presencia de plagas será relevante para evaluar la condición del cultivo.

- Se asume que las alertas, reportes, paneles de control y analíticas de tendencias serán funciones útiles para ambos segmentos objetivo.

- Se asume que una plataforma digital conectada a nodos IoT multisensor distribuidos en microzonas del cultivo permitirá una supervisión más eficiente y ordenada.

**5. User Outcome Assumptions**:

- Se asume que los usuarios podrán comprender mejor el estado del cultivo gracias a la visualización de datos en tiempo real.

- Se asume que los usuarios podrán actuar con mayor rapidez frente a riesgos o cambios en la plantación.

- Se asume que los usuarios tomarán decisiones con mayor respaldo de información, mejorando el control, la prevención y la gestión general del cultivo.
  

#### 1.2.2.3 Lean UX Hypothesis Statements

**Hipótesis 1:**
Creemos que, si los dueños de cultivos de palma aceitera pueden visualizar en tiempo real el estado general de la plantación mediante una plataforma digital, entonces podrán tomar decisiones más oportunas sobre riego, abonado y manejo del cultivo, mejorando el control y la rentabilidad de la plantación.

**Hipótesis 2:**
Creemos que, si los ingenieros agrónomos cuentan con datos continuos y confiables sobre variables críticas del cultivo, entonces podrán detectar anomalías con mayor anticipación y formular recomendaciones técnicas más precisas para el manejo de la plantación.

**Hipótesis 3:**
Creemos que, si la solución utiliza nodos IoT multisensor distribuidos en microzonas del cultivo para monitorear humedad, temperatura, luz, indicadores de minerales y condiciones asociadas a la presencia de plagas, entonces será posible obtener una supervisión más eficiente y representativa del estado del cultivo.

**Hipótesis 4:**
Creemos que, si la plataforma transforma los datos recolectados en alertas, reportes y analíticas de tendencias, entonces los usuarios comprenderán mejor el comportamiento del cultivo y podrán actuar de manera preventiva frente a cambios o riesgos relevantes.

**Hipótesis 5:**
Creemos que, si la solución presenta información clara, útil y accesible para ambos segmentos objetivo, entonces el dueño del cultivo y el ingeniero agrónomo percibirán valor en su uso y estarán más dispuestos a incorporarla en la gestión cotidiana del cultivo.

#### 1.2.2.4 Lean UX Canvas

El Lean UX Canvas resume el problema de negocio, los segmentos objetivo, los resultados esperados, la propuesta de solución, las hipótesis, los riesgos y los experimentos iniciales para validar la propuesta de valor de SmartPalm.

![Lean UX Canvas - SmartPalm](./assets/img/leanUx/lean-ux-canvas.png)

Permitió organizar de forma integral los principales elementos del problema y de la solución propuesta, facilitando la alineación entre las necesidades de los usuarios, los objetivos del negocio y las decisiones iniciales de diseño de la propuesta.

## 1.3 Segmento Objetivo

# Chapter 2: Requirements Elicitation & Analysis

## 2.1 Competidores

### 2.1.1 Análisis competitivo

### 2.1.2 Estrategias y tácticas frente a competidores

**1. Diferenciación de Producto:**<br>
**Estrategia:** <br>
**Tácticas:** <br><br>
**2. Mejora Continua y Adaptación:**<br>
**Estrategia:** <br>
**Tácticas:** <br><br>
**3. Penetración de Mercado:**<br>
**Estrategia:** <br>
**Tácticas:** <br><br>
**4. Colaboración y Alianzas Estratégicas:**<br>
**Estrategia:** <br>
**Tácticas:** <br><br>
**5. Optimización de Costos y Valor Percibido:**<br>
**Estrategia:** <br>
**Tácticas:** <br><br>
**6. Desarrollo de Nuevas Funcionalidades y Servicios:** <br>
**Estrategia:** <br>
**Tácticas:**

## 2.2 Entrevistas

### 2.2.1 Diseño de entrevistas

**Segmento 1:**

**Segmento 2:**

### 2.2.2 Registro de entrevistas

**Segmento 1:**<br>
**Entrevista N°1:**<br>

**Entrevista N°2:**<br>

**Entrevista N°3:**<br>

**Segmento 2:**<br>
**Entrevista N°1:**<br>

**Entrevista N°2:**<br>

**Entrevista N°3:**<br>

### 2.2.3 Análisis de entrevistas

**Segmento 1:**
<br>

**SEgmento 2:**

## 2.3 Needfinding

### 2.3.1 User Personas

### 2.3.2 User Task Matrix

### 2.3.3 User Journey Mapping

### 2.3.4 Empathy Mapping

### 2.3.5 As-is Scenario Mapping

## 2.4 Ubiquitous Language

Ubiquitous Language (o Lenguaje Ubicuo) es un conjunto de términos compartidos y consistentes que se utilizan en todo un equipo de desarrollo (diseñadores, programadores, analistas, stakeholders, etc.) para describir el dominio del problema. Es muy común en metodologías como Domain-Driven Design (DDD).

| Término | Definición |
| ------- | ---------- |
|         |            |
|         |            |
|         |            |
|         |            |
|         |            |
|         |            |
|         |            |
|         |            |

# Capítulo 3: Requirements Specification

## 3.1 To-Be Scenario Mapping

## 3.2 User Stories

USER STORIES

## 3.3 Impact Mapping

## 3.4 Product Backlog

Product Backlog Trello:

# Chapter 04: Solution Software Design

## 4.1 Strategic-Level Domain-Driven Design

El diseño estratégico de Smart Palm aplica Domain-Driven Design como marco de referencia para descomponer el dominio del negocio en contextos delimitados cohesivos, establecer sus relaciones estructurales y definir la arquitectura de software que los soporta. El proceso parte del modelado realizado mediante Big Picture EventStorming en el Capítulo II y avanza hacia una descomposición de nivel de diseño que sustenta las decisiones de arquitectura del backend, el frontend web y el dispositivo IoT que conforman la plataforma.

### 4.1.1 EventStorming

La sesión de Design-Level EventStorming se realizó sobre el dominio modelado previamente en el Big Picture EventStorming, profundizando en los flujos de comandos, políticas, agregados y vistas de lectura para cada subdominio identificado. La sesión tuvo una duración aproximada de noventa minutos y permitió refinar los siete bounded contexts candidatos, identificar las políticas de negocio críticas y establecer las dependencias entre contextos. Se utilizó Miro como herramienta de trabajo colaborativo.

El proceso se estructuró en tres fases. En la primera se identificaron y refinaron los Domain Events del sistema, formulados en tiempo pasado. En la segunda se asociaron los Commands que desencadenan cada evento, los Actors que los ejecutan y los External Systems que participan. En la tercera los eventos se agruparon en bounded contexts con límites derivados de los cambios de estado del proceso de negocio.

Los actores identificados en el tablero son tres: Palm Grower, que ejecuta acciones desde la plataforma web como usuario propietario del cultivo; Agronomist, que ejecuta acciones desde la plataforma web como usuario técnico supervisor; y System, que representa los procesos automáticos que ocurren sin intervención humana directa.

#### Eventos
<img src="./assets/img/EventStorming/events.jpg" alt="Design-Level EventStorming Events" width="800"/>

#### Commandos
<img src="./assets/img/EventStorming/commands.jpg" alt="Design-Level EventStorming Commands" width="800"/>


#### Actores principales
<img src="./assets/img/EventStorming/actors.jpg" alt="Design-Level EventStorming Actors" width="800"/>

#### URL
El event storming se realizo en Miro mediante el siguiente url: 
[Miro Board](https://miro.com/app/board/uXjVHdJ_3Wo=/?share_link_id=547546845690)

#### 4.1.1.1 Candidate Context Discovery


La sesión de Candidate Context Discovery se realizó sobre el tablero de Design-Level EventStorming en Miro. El proceso consistió en recorrer la línea temporal de eventos de izquierda a derecha aplicando la técnica *look-for-pivotal-events*, identificando aquellos eventos que señalan un cambio de responsabilidad entre partes del dominio: lo que ocurre antes del evento pertenece a un contexto distinto de lo que ocurre después.

Complementariamente se aplicó la técnica *start-with-value* para validar que los contextos identificados como Core Domain concentraban las capacidades de mayor valor para el negocio: el procesamiento del dato sensorial, la recomendación agronómica calibrada para palma aceitera amazónica y la gestión técnica de campo del Agronomist.

##### Eventos pivote identificados

**`DeviceRegistered`**
Marca el límite entre la gestión del ciclo de vida del dispositivo físico y el procesamiento de los datos que ese dispositivo produce. Todo lo relacionado con registrar y configurar el dispositivo pertenece a un contexto; todo lo relacionado con recibir y procesar sus lecturas pertenece a otro.

<img src="./assets/img/EventStorming/pivote_bc1_bc2.jpg" alt="Design-Level EventStorming pivote 1" width="800"/>

**`ThresholdExceeded`**
Marca el límite entre el procesamiento de datos sensoriales y la gestión de alertas. Es el evento de mayor impacto operativo porque desencadena la respuesta hacia los usuarios.

<img src="./assets/img/EventStorming/pivote_bc2_bc3.jpg" alt="Design-Level EventStorming Pivote 2" width="800"/>

**`AlertAcknowledged`**
Marca el límite entre la gestión de alertas y la generación de recomendaciones agronómicas. Una alerta reconocida puede o no derivar en una recomendación — esa decisión pertenece a un contexto distinto con su propia lógica.

<img src="./assets/img/EventStorming/pivote_bc3_bc4.jpg" alt="Design-Level EventStorming Pivote 3" width="800"/>

**`RecommendationPublished`**
Marca el límite entre la generación de recomendaciones y su consumo para visualización. Una vez publicada, la recomendación pasa a ser un dato de solo lectura para el frontend.

<img src="./assets/img/EventStorming/pivote_bc4_bc5.jpg" alt="Design-Level EventStorming Pivote 4" width="800"/>

**`FieldInspectionRegistered`**
Marca el límite entre la gestión de la supervisión técnica del Agronomist y la generación de recomendaciones derivadas de esa inspección. La inspección pertenece al dominio del trabajo de campo; la recomendación que genera pertenece al dominio agronómico.

<img src="./assets/img/EventStorming/pivote_bc6_bc4.jpg" alt="Design-Level EventStorming Pivote 5" width="800"/>

**`SubscriptionActivated`**
Marca el límite entre la gestión comercial del usuario y el inicio de la operación del sistema. La activación de la suscripción habilita directamente el registro del dispositivo IoT en BC-01, a partir del cual el resto del sistema entra en operación de forma natural.

<img src="./assets/img/EventStorming/pivote_bc7_all.jpg" alt="Design-Level EventStorming Pivote 6" width="800"/>

##### Bounded contexts resultantes

| ID    | Bounded Context                  | Clasificación      | Responsabilidad central |
|-------|----------------------------------|--------------------|-------------------------|
| BC-01 | IoT Device Management            | Core Domain        | Ciclo de vida del dispositivo IoT en campo y operación offline mediante edge computing. |
| BC-02 | Sensor Data Processing           | Core Domain        | Recepción, validación, normalización y evaluación agronómica de lecturas sensoriales. |
| BC-03 | Alert & Notification             | Supporting Domain  | Generación, clasificación y despacho de alertas por umbral agronómico superado. |
| BC-04 | Agronomic Recommendation         | Core Domain        | Generación, aprobación y publicación de recomendaciones agronómicas por IA y por el Agronomist. |
| BC-05 | Crop Monitoring Dashboard        | Supporting Domain  | Vistas de lectura consolidadas del estado del cultivo para Palm Grower y Agronomist en la plataforma web. |
| BC-06 | Field Technical Management       | Core Domain        | Ciclo de supervisión técnica del Agronomist: visitas, inspecciones e intervenciones agronómicas. |
| BC-07 | Subscription & User Management   | Generic Subdomain  | Autenticación, autorización, perfiles y gestión de planes de suscripción. |

<img src="./assets/img/EventStorming/bc_01.jpg" alt="Design-Level EventStorming Bounded 1" width="800"/>
<img src="./assets/img/EventStorming/bc_02.jpg" alt="Design-Level EventStorming Bounded 2" width="800"/>
<img src="./assets/img/EventStorming/bc_03.jpg" alt="Design-Level EventStorming Bounded 3" width="800"/>
<img src="./assets/img/EventStorming/bc_04.jpg" alt="Design-Level EventStorming Bounded 4" width="800"/>
<img src="./assets/img/EventStorming/bc_05.jpg" alt="Design-Level EventStorming Bounded 5" width="800"/>
<img src="./assets/img/EventStorming/bc_06.jpg" alt="Design-Level EventStorming Bounded 6" width="800"/>
<img src="./assets/img/EventStorming/bc_07.jpg" alt="Design-Level EventStorming Bounded 7" width="800"/>

#### 4.1.1.2 Domain Message Flows Modeling.


El modelado de flujos de mensajes entre bounded contexts se realizó mediante la técnica de Domain Storytelling, con el objetivo de visualizar cómo los contextos colaboran para resolver los casos de uso más críticos del negocio de Smart Palm. Se modelaron tres flujos principales que cubren los escenarios de mayor valor para los dos segmentos de usuario.

##### Flujo 1 — Detección de condición de riesgo y generación de recomendación

El dispositivo IoT registra una lectura sensorial y la envía al backend mediante HTTP. BC-02 Sensor Data Processing la recibe, la valida y la normaliza. Al evaluar la lectura contra los umbrales agronómicos calibrados para palma aceitera amazónica, detecta que el valor supera el límite definido y publica el evento `ThresholdExceeded`. BC-03 Alert & Notification consume ese evento, genera una alerta, la clasifica por nivel de severidad y la despacha como notificación push al Palm Grower y como alerta visible en la plataforma web para el Agronomist. El evento `AlertTriggered` es consumido opcionalmente por BC-04 Agronomic Recommendation, que genera una recomendación automática mediante el motor de IA. El Agronomist revisa y aprueba la recomendación desde la plataforma web. Una vez aprobada, se publica al Palm Grower. El Palm Grower ejecuta la intervención agronómica indicada y la registra en BC-06 Field Technical Management, cerrando el ciclo de trazabilidad.

<img src="./assets/img/EventStorming/candidate_flow_1.jpg" alt="Design-Level EventStorming Message Flow 1" width="800"/>

##### Flujo 2 — Ciclo de supervisión del Agronomist con datos remotos

El Agronomist accede a la plataforma web y consulta BC-05 Crop Monitoring Dashboard para revisar el historial de parámetros sensoriales y las alertas activas de sus plantaciones antes de planificar una visita de campo. Con esa información, registra la planificación de la visita en BC-06 Field Technical Management. Durante la inspección presencial, registra sus observaciones directamente desde la plataforma web y las vincula a las alertas activas correspondientes. El evento `FieldInspectionRegistered` dispara la generación de una recomendación formal en BC-04 Agronomic Recommendation. El Agronomist la revisa, aprueba y publica. BC-05 Crop Monitoring Dashboard genera automáticamente un borrador de reporte técnico que el Agronomist revisa y publica hacia el Palm Grower.

<img src="./assets/img/EventStorming/candidate_flow_2.jpg" alt="Design-Level EventStorming Message Flow 2" width="800"/>

##### Flujo 3 — Activación de suscripción e inicio de operación

Un Palm Grower se registra en la plataforma web y selecciona un plan de suscripción en BC-07 Subscription & User Management. El pago se procesa a través del Payment Gateway externo. Al confirmarse el pago, el sistema activa la suscripción y publica el evento `SubscriptionActivated`. BC-01 IoT Device Management consume ese evento y habilita el registro del dispositivo IoT asociado a la plantación del usuario. Una vez registrado y configurado el dispositivo, comienza la transmisión de lecturas hacia BC-02 Sensor Data Processing, poniendo en operación el Flujo 1.

<img src="./assets/img/EventStorming/candidate_flow_3.jpg" alt="Design-Level EventStorming Message Flow 3" width="800"/>

#### 4.1.1.3 Bounded Context Canvases.


A continuación se presentan los Bounded Context Canvases elaborados para cada uno de los siete bounded contexts identificados, se denotan todos los ambitos necesarios como Ubiquitous Language, IN-OUT Dependencies y demas puntos necesarios para construir el canvas.

##### BC-01: IoT Device Management

| Campo | Detalle |
|---|---|
| **Nombre** | IoT Device Management |
| **Descripción** | Gestiona el ciclo de vida completo de los dispositivos IoT de Smart Palm: registro, configuración de parámetros de muestreo, monitoreo del estado de conectividad, operación autónoma en modo offline mediante edge computing y sincronización de datos acumulados cuando se restablece la conexión. |
| **Rol estratégico** | Core Domain — diferenciador técnico central de la plataforma. |
| **Reglas de negocio** | Un dispositivo debe estar asociado a exactamente una Monitoring Zone activa. En modo offline el Edge Node almacena lecturas localmente. El período máximo de almacenamiento offline es de 72 horas. La sincronización se realiza en orden cronológico al restablecer conexión. El registro de un dispositivo requiere suscripción activa verificada en BC-07. |
| **Ubiquitous Language** | Device, Edge Node, Monitoring Zone, Sensor Reading, Offline Mode, Synchronization, Device Health Status. |
| **Capabilities** | Registrar dispositivo, configurar parámetros de muestreo, monitorear conectividad, activar modo offline, sincronizar datos acumulados, dar de baja dispositivo. |
| **Dependencias entrantes** | BC-07 Subscription & User Management — valida suscripción activa antes de permitir registro de dispositivo. |
| **Dependencias salientes** | BC-02 Sensor Data Processing — publica `SensorReadingRecorded` tras cada lectura o sincronización. |

---

##### BC-02: Sensor Data Processing

| Campo | Detalle |
|---|---|
| **Nombre** | Sensor Data Processing |
| **Descripción** | Recibe, valida, normaliza y persiste las lecturas sensoriales provenientes de los dispositivos IoT. Evalúa cada lectura contra los umbrales agronómicos calibrados para palma aceitera en la Amazonia peruana y determina si se debe publicar un evento de alerta. |
| **Rol estratégico** | Core Domain — procesamiento central del dato sensorial que alimenta toda la plataforma. |
| **Reglas de negocio** | Los umbrales agronómicos se definen por parámetro, por tipo de suelo y por fase fenológica del cultivo, calibrados con los parámetros del INIA para la región Ucayali. Una lectura fuera de rango genera el evento `ThresholdExceeded`. Lecturas duplicadas o con marca de tiempo inconsistente son descartadas. |
| **Ubiquitous Language** | Sensor Reading, Agronomic Threshold, ThresholdExceeded, Crop Health Status, Normalization, Validation. |
| **Capabilities** | Recibir lectura sensorial, validar integridad del dato, evaluar umbral agronómico, persistir serie temporal, publicar evento de umbral superado. |
| **Dependencias entrantes** | BC-01 IoT Device Management — `SensorReadingRecorded`. |
| **Dependencias salientes** | BC-03 Alert & Notification — `ThresholdExceeded`. BC-05 Crop Monitoring Dashboard — series temporales normalizadas para visualización. |

---

##### BC-03: Alert & Notification

| Campo | Detalle |
|---|---|
| **Nombre** | Alert & Notification |
| **Descripción** | Genera, clasifica y despacha alertas cuando una lectura sensorial supera un umbral agronómico. Gestiona los canales de notificación push hacia el Palm Grower y las alertas visibles en la plataforma web del Agronomist. |
| **Rol estratégico** | Supporting Domain — habilita la respuesta oportuna de los usuarios ante condiciones de riesgo. |
| **Reglas de negocio** | Las alertas se clasifican en tres niveles: informativa, de advertencia y crítica. Una alerta crítica activa notificación push inmediata. Se aplica supresión de alertas duplicadas para un mismo parámetro dentro de una ventana de 30 minutos. |
| **Ubiquitous Language** | Alert, Alert Level, Notification, Push Notification, Alert Suppression, Alert Acknowledgment. |
| **Capabilities** | Generar alerta, clasificar nivel de alerta, despachar notificación push, registrar acuse de recibo, suprimir duplicados. |
| **Dependencias entrantes** | BC-02 Sensor Data Processing — `ThresholdExceeded`. |
| **Dependencias salientes** | BC-04 Agronomic Recommendation — `AlertTriggered` como disparador opcional. BC-05 Crop Monitoring Dashboard — estado de alertas activas. |

---

##### BC-04: Agronomic Recommendation

| Campo | Detalle |
|---|---|
| **Nombre** | Agronomic Recommendation |
| **Descripción** | Gestiona la generación, almacenamiento y comunicación de recomendaciones agronómicas, tanto las producidas automáticamente por el motor de IA calibrado con parámetros del INIA como las redactadas manualmente por el Agronomist. |
| **Rol estratégico** | Core Domain — materializa el valor agronómico diferencial de la plataforma. |
| **Reglas de negocio** | Una recomendación debe estar vinculada a una alerta activa o a una inspección de campo registrada. Las recomendaciones generadas por IA requieren revisión y aprobación del Agronomist antes de ser publicadas al Palm Grower. Una recomendación publicada no puede modificarse; se versiona. |
| **Ubiquitous Language** | Agronomic Recommendation, AI Engine, Recommendation Approval, Recommendation Version, Agronomic Intervention. |
| **Capabilities** | Generar recomendación por IA, redactar recomendación manual, aprobar recomendación, publicar recomendación al Palm Grower, registrar intervención ejecutada. |
| **Dependencias entrantes** | BC-03 Alert & Notification — `AlertTriggered`. BC-06 Field Technical Management — `FieldInspectionRegistered`. |
| **Dependencias salientes** | BC-05 Crop Monitoring Dashboard — recomendaciones publicadas para visualización. |

---

##### BC-05: Crop Monitoring Dashboard

| Campo | Detalle |
|---|---|
| **Nombre** | Crop Monitoring Dashboard |
| **Descripción** | Provee las vistas de lectura consolidadas del estado del cultivo para ambos segmentos de usuario desde la plataforma web. Para el Palm Grower ofrece el Crop Health Status actual, el historial de parámetros y las alertas y recomendaciones activas. Para el Agronomist ofrece el dashboard multi-plantación, el historial de series temporales y la generación asistida de reportes técnicos. |
| **Rol estratégico** | Supporting Domain — interfaz principal de consumo de información de la plataforma. |
| **Reglas de negocio** | Este contexto es de solo lectura; no modifica estado del dominio. El Crop Health Status se calcula a partir del conjunto de parámetros sensoriales activos y se expresa en tres estados: óptimo, en riesgo o crítico. |
| **Ubiquitous Language** | Crop Health Status, Dashboard, Technical Report, Monitoring View, Time Series, Multi-plantation View. |
| **Capabilities** | Mostrar Crop Health Status actual, visualizar series temporales de parámetros, listar alertas activas, listar recomendaciones publicadas, generar borrador de reporte técnico, publicar reporte técnico. |
| **Dependencias entrantes** | BC-02 Sensor Data Processing, BC-03 Alert & Notification, BC-04 Agronomic Recommendation, BC-06 Field Technical Management. |
| **Dependencias salientes** | Ninguna — contexto de solo lectura. |

---

##### BC-06: Field Technical Management

| Campo | Detalle |
|---|---|
| **Nombre** | Field Technical Management |
| **Descripción** | Gestiona el ciclo de supervisión técnica del Agronomist: planificación de visitas de campo, registro de observaciones durante la inspección presencial, vinculación de observaciones a alertas activas y trazabilidad de las intervenciones agronómicas ejecutadas por el Palm Grower. |
| **Rol estratégico** | Core Domain — digitaliza el flujo de trabajo del Agronomist como segundo usuario primario de la plataforma. |
| **Reglas de negocio** | Una Field Inspection debe estar asociada a exactamente una Palm Plantation. El registro de una observación de campo puede vincular una alerta activa existente. Las intervenciones agronómicas registradas por el Palm Grower quedan trazadas contra la recomendación que las originó. |
| **Ubiquitous Language** | Field Inspection, Agronomist Visit, Observation, Agronomic Intervention, Traceability, Field Report. |
| **Capabilities** | Planificar visita de campo, registrar inspección, asociar observación a alerta activa, registrar intervención agronómica, consultar historial de intervenciones por plantación. |
| **Dependencias entrantes** | BC-03 Alert & Notification — alertas activas disponibles para vincular durante la inspección. |
| **Dependencias salientes** | BC-04 Agronomic Recommendation — `FieldInspectionRegistered` como disparador. BC-05 Crop Monitoring Dashboard — historial de inspecciones e intervenciones. |

---

##### BC-07: Subscription & User Management

| Campo | Detalle |
|---|---|
| **Nombre** | Subscription & User Management |
| **Descripción** | Gestiona la autenticación, autorización y perfiles de los usuarios de la plataforma, así como la contratación, activación, renovación y cancelación de los planes de suscripción SaaS de Smart Palm. |
| **Rol estratégico** | Generic Subdomain — infraestructura de soporte transversal a toda la plataforma. |
| **Reglas de negocio** | Un usuario solo puede tener una suscripción activa a la vez. El plan determina el número máximo de hectáreas monitoreables y el conjunto de funcionalidades disponibles. La cancelación de una suscripción revoca el acceso a la plataforma al término del período contratado. |
| **Ubiquitous Language** | Subscription Plan, User Profile, Role, Authentication, Authorization, Plan Activation, Billing Cycle. |
| **Capabilities** | Registrar usuario, autenticar usuario, gestionar roles y permisos, contratar plan, procesar pago, activar suscripción, renovar suscripción, cancelar suscripción. |
| **Dependencias entrantes** | Payment Gateway externo. |
| **Dependencias salientes** | BC-01 IoT Device Management — `SubscriptionActivated` habilita el registro de dispositivos. |

### 4.1.2. Context Mapping.


El Context Mapping define las relaciones estructurales entre los siete bounded contexts de Smart Palm. El proceso consistió en revisar las dependencias identificadas en los Bounded Context Canvases y determinar el patrón de relación más adecuado para cada par de contextos relacionados, considerando el nivel de acoplamiento, la dirección del flujo de datos y el impacto sobre el modelo de dominio de cada contexto.

#### Relaciones identificadas

**BC-07 → BC-01: Customer/Supplier**
Subscription & User Management actúa como Supplier: provee la confirmación de suscripción activa que BC-01 IoT Device Management requiere antes de permitir el registro de un dispositivo. BC-01 es el Customer: consume ese dato sin poder modificar la lógica del contexto proveedor. La comunicación ocurre mediante el evento `SubscriptionActivated`.

**BC-01 → BC-02: Customer/Supplier**
BC-01 IoT Device Management produce las lecturas sensoriales y las publica como eventos HTTP hacia BC-02 Sensor Data Processing. BC-02 las consume y procesa sin control sobre el formato ni la frecuencia de las lecturas.

**BC-02 → BC-03: Customer/Supplier**
BC-02 Sensor Data Processing publica el evento `ThresholdExceeded`. BC-03 Alert & Notification lo consume para generar alertas. BC-03 no controla cuándo ni cómo se produce ese evento.

**BC-02 → BC-05: Customer/Supplier**
BC-02 provee las series temporales normalizadas que BC-05 Crop Monitoring Dashboard proyecta en sus vistas de lectura. BC-05 consume esos datos sin modificar el modelo del contexto productor.

**BC-03 → BC-04: Customer/Supplier**
BC-03 Alert & Notification publica `AlertTriggered` como disparador opcional para la generación automática de recomendaciones en BC-04 Agronomic Recommendation. BC-04 mantiene su propia lógica de generación y aprobación con independencia del contexto de alertas.

**BC-03 → BC-05: Customer/Supplier**
BC-03 provee el estado de alertas activas que BC-05 Crop Monitoring Dashboard proyecta en sus vistas. BC-05 es consumidor de solo lectura.

**BC-06 → BC-04: Customer/Supplier**
BC-06 Field Technical Management publica `FieldInspectionRegistered` como disparador de recomendaciones agronómicas asociadas a inspecciones presenciales. BC-04 consume ese evento.

**BC-06 → BC-05: Customer/Supplier**
BC-06 provee el historial de inspecciones e intervenciones agronómicas que BC-05 Crop Monitoring Dashboard proyecta en sus vistas de trazabilidad.

**BC-04 → BC-05: Customer/Supplier**
BC-04 Agronomic Recommendation publica las recomendaciones aprobadas que BC-05 presenta al Palm Grower y al Agronomist en la plataforma web.

**BC-07 → todos los contextos: Conformist**
Todos los contextos consumen la identidad y los permisos del usuario provistos por BC-07 Subscription & User Management para validar el acceso a sus operaciones. Ningún contexto puede modificar el modelo de identidad — deben conformarse con lo que este contexto define.

### 4.1.3. Software Architecture.

La arquitectura de software de Smart Palm se representa mediante el modelo C4, utilizando Structurizr DSL para la generación de los diagramas. La arquitectura responde a los siete bounded contexts identificados en el proceso de Domain-Driven Design y contempla tres niveles de representación: System Landscape, Context y Container.

#### 4.1.3.1. Software Architecture System Landscape Diagram.

El System Landscape Diagram muestra Smart Palm en relación con los sistemas externos con los que interactúa y los tipos de usuario que lo utilizan.

<img src="./assets/img/SoftwareArchitecture/system_landscape.png" alt="Design-Level EventStorming Domain Message Flows" width="800"/>

#### 4.1.3.2. Software Architecture Context Level Diagrams.

El Context Diagram muestra Smart Palm como sistema central, sus usuarios directos y los sistemas externos con los que interactúa, sin detallar su estructura interna.

<img src="./assets/img/SoftwareArchitecture/context_level.png" alt="Design-Level EventStorming Domain Message Flows" width="800"/>

#### 4.1.3.3. Software Architecture Container Level Diagrams.

El Container Diagram descompone Smart Palm en sus contenedores principales, mostrando las responsabilidades de cada uno y cómo se comunican entre sí.

<img src="./assets/img/SoftwareArchitecture/container_level.png" alt="Design-Level EventStorming Domain Message Flows" width="800"/>

#### 4.1.3.4. Software Architecture Deployment Diagrams.

El Deployment Diagram muestra cómo los contenedores de Smart Palm se despliegan en infraestructura de nube, considerando los entornos de producción y el dispositivo IoT en campo. En nuestro caso usaremos directamente la nube de Azure, junto a dispositivos Arduino y Raspberry PI

<img src="./assets/img/SoftwareArchitecture/deployment_diagrams.png" alt="Design-Level EventStorming Domain Message Flows" width="800"/>

## 4.2. Tactical-Level Domain-Driven Design

### 4.2.X. Bounded Context: (Bounded Context Name)

#### 4.2.X.1. Domain Layer.

#### 4.2.X.2. Interface Layer.

#### 4.2.X.3. Application Layer.

#### 4.2.X.4. Infrastructure Layer.

#### 4.2.X.5. Bounded Context Software Architecture Component Level Diagrams.

#### 4.2.X.6. Bounded Context Software Architecture Code Level Diagrams.

#### 4.2.X.6.1. Bounded Context Domain Layer Class Diagrams.

#### 4.2.X.6.2. Bounded Context Database Design Diagram.

# Conclusiones 
# Conclusiones y recomendaciones. 
# Video About-the-Team.
