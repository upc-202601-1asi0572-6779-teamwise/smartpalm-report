## Conclusiones y Recomendaciones

### Conclusiones

El desarrollo de Smart Palm durante los dos primeros sprints del proyecto demostró la viabilidad técnica de una solución IoT distribuida orientada al monitoreo continuo de cultivos de palma aceitera en la Amazonia peruana. La investigación con los segmentos objetivo confirmó la validez de los Problem Statements planteados: la gestión reactiva del productor y las restricciones logísticas del ingeniero agrónomo son condiciones reales y complementarias que generan una brecha de productividad documentada de hasta USD 1 700/ha/año. Al cierre del Sprint 2, la arquitectura de cuatro capas —firmware ESP32, Edge API Flask, RESTful API ASP.NET Core y aplicaciones de usuario— se encuentra funcionalmente integrada y desplegada en producción, con el flujo completo de transmisión de datos validado desde el sensor hasta la capa de visualización. La aplicación de Domain-Driven Design, GitFlow y Conventional Commits facilitó la organización del trabajo colaborativo y la trazabilidad entre requisitos e implementación. Quedan pendientes de validación empírica las hipótesis relacionadas con la aceptación del usuario (H1, H2, H5) y la autonomía del dispositivo en condiciones de campo amazónico (H4), aspectos que deberán abordarse en el Sprint 3 mediante entrevistas de validación y pruebas de campo del prototipo.

---

### Recomendaciones

**Para el Sprint 3 y la entrega final (TB2)**

1. Realizar las entrevistas de validación con usuarios representativos de ambos segmentos (dueño del cultivo e ingeniero agrónomo) aplicando los user flows definidos en la sección 6.3.1, de manera que la Hipótesis 1 y la Hipótesis 2 puedan evaluarse con evidencia directa de usuarios y no únicamente con base en el diseño de la solución.

2. Corregir los problemas de usabilidad identificados en las evaluaciones heurísticas del Sprint 2, priorizando los de severidad 3: diferenciación de CTAs en el Landing Page, indicador de carga en la Web Application, etiquetas de unidades de medida en la Mobile Application y diferenciación visual de alertas por nivel de severidad.

3. Avanzar en la validación de la Hipótesis 4 realizando una prueba de campo del Prototipo 2 en condiciones reales de operación, documentando la tasa de entrega de paquetes, el comportamiento ante interrupciones de red y la autonomía energética del dispositivo.

4. Implementar los `.feature` files de los cuatro tests BDD documentados en la sección 6.2.2.5 como proyecto de tests ejecutable dentro del repositorio del Web Service, de manera que la evidencia de testing sea verificable mediante `dotnet test` y no únicamente como documentación.

**Para el roadmap posterior al curso**

5. Ampliar el motor de recomendaciones agronómicas integrando los umbrales calibrados del INIA para las principales enfermedades de la palma en la Amazonia peruana (Marchitez Sorpresiva, Anillo Rojo, Pudrición del Cogollo), de manera que las recomendaciones generadas por la plataforma respondan al contexto fitosanitario específico de la región.

6. Migrar el prototipo de conectividad WiFi a LoRaWAN en el dispositivo de campo, condición necesaria para operar en las zonas rurales del corredor Pucallpa–Aguaytía donde la conectividad de banda ancha no está garantizada.

7. Evaluar la incorporación de energía solar con batería de respaldo en el hardware de campo antes del lanzamiento comercial, dado que la continuidad de las lecturas en zonas remotas sin acceso a red eléctrica es una condición operativa fundamental para el segmento objetivo.

8. Iniciar conversaciones con COCEPU, ASPASH y el Gobierno Regional de Ucayali como canales de adopción inicial, aprovechando la coincidencia del proyecto con los objetivos del Instrumento de Gestión MIDAGRI 2025–2034, que crea un contexto institucional favorable a la adopción de herramientas de monitoreo continuo por parte del pequeño y mediano palmicultor amazónico.
