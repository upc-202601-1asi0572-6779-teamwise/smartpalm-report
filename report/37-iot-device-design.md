# 5.6 Device Design

## Introducción

El diseño e implementación del ecosistema de hardware para **SmartPalm** se ha estructurado de manera incremental y rigurosa, dividiéndose en dos fases metodológicas fundamentales que aseguran la viabilidad del monitoreo automatizado de la palma aceitera en la Amazonia peruana:

- **Parte A: Diseño Conceptual (Edge Node Objetivo):** Define la arquitectura integral de producción adaptada para su despliegue en campo. Este diseño considera la integración de sensores de grado industrial para la caracterización completa del suelo y del microclima, un esquema de alimentación fotovoltaica autónoma y un sistema de radiocomunicación de largo alcance basado en el estándar LoRaWAN 915 MHz. Su viabilidad funcional y el firmware de control fueron completamente validados mediante simulación avanzada en la plataforma Wokwi.

- **Parte B: Prototipado Físico (Validación en Hardware Real):** Representa la traslación del diseño teórico a componentes físicos disponibles en laboratorio. En lugar de construir un único nodo monolítico, el equipo distribuyó las responsabilidades de adquisición y enrutamiento en dos unidades de hardware independientes: un **Nodo Sensor de Campo** y un **Edge Node (Nodo Gateway Local)**. Esta fase valida empíricamente la estabilidad de los firmwares, los algoritmos de filtrado local (*Edge Computing*) y el comportamiento del buffer circular ante cortes de conectividad.

---

# Parte A — Diseño Conceptual (Edge Node Objetivo)

> Esta primera parte describe la arquitectura completa diseñada como objetivo final de SmartPalm, validada mediante simulación en Wokwi. El prototipado físico real, descrito en la Parte B, implementa una versión reducida de este diseño usando los componentes disponibles para el equipo en esta etapa del proyecto.

## Circuit Design

### Componentes del sistema

La unidad de procesamiento central seleccionada es el microcontrolador **ESP32-WROOM-32** de 38 pines. Su arquitectura de doble núcleo Xtensa LX6 a 240 MHz proporciona la potencia de cómputo necesaria para ejecutar scripts de filtrado estadístico local sin penalizar los tiempos de respuesta.

| Componente | Modelo Técnico | Función en el Cultivo | Interfaz / Protocolo | Riel de Voltaje |
|---|---|---|---|---|
| **Microcontrolador** | ESP32-WROOM-32 | Procesamiento central y Edge Computing | Dual-Core LX6 a 240 MHz | 3.3V DC |
| **Sensor Clima** | DHT22 | Temperatura y humedad relativa del aire | Digital 1 hilo (GPIO 34) | 3.3V DC |
| **Sensor Temp Suelo** | DS18B20 (Sonda) | Temperatura radicular en subsuelo | Bus 1-Wire (GPIO 33) | 3.3V DC |
| **Sensor Hum Suelo** | Capacitivo V1.2 | Humedad volumétrica (inmune a corrosión) | Analógico ADC1_CH4 (GPIO 32) | 3.3V DC |
| **Sensor pH Suelo** | DFRobot SEN0161 | Monitoreo de acidez y asimilación de nutrientes | Analógico ADC1_CH7 (GPIO 35) | 3.3V DC |
| **Sensor EC Suelo** | Analógico Genérico | Conductividad eléctrica (salinidad de la solución) | Analógico ADC1_CH0 (GPIO 36) | 3.3V DC |
| **Radio Transceptor** | Ra-02 (SX1276) | Transmisión de telemetría a larga distancia | Bus SPI dedicado | 3.3V DC |
| **Display Local** | LCD 1602 + PCF8574 | Diagnóstico e inspección visual en campo | Bus I2C (GPIO 21/22) | 5.0V DC (VIN) |
| **Gestión de Energía** | Panel 5W + TP4056 | Captación solar, carga y protección de batería | Líneas de potencia DC | 3.7V – 6V DC |

### Diagrama de circuito (Wokwi)

El esquemático fue implementado en Wokwi usando el ESP32 DevKit V1 como microcontrolador central. Los sensores analógicos (humedad de suelo, pH y EC) se conectan exclusivamente a los canales ADC1 del ESP32, garantizando compatibilidad con el módulo WiFi activo. El DHT22 usa un pin digital con resistencia pull-up de 10 kΩ a 3.3V. El módulo LoRa SX1276 se comunica mediante el bus SPI completo. El LCD 1602 usa comunicación I2C con dirección 0x27.

![Circuit Design - SmartPalm IoT Edge Node](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/d8b14dffca8e88d238c5bc001bfc8cf111b5459d/assets/img/smartpalm_pinout_diagram.svg)

### Tabla de pin mapping

| Pin Físico ESP32 | Nombre del Pin | Componente Asociado | Dirección / Tipo | Configuración de Hardware |
|---|---|---|---|---|
| GPIO 34 | ADC1_CH6 | DHT22 (línea de datos) | Entrada digital | Pull-up externa 10 kΩ a 3.3V |
| GPIO 32 | ADC1_CH4 | Sensor capacitivo humedad suelo | Entrada analógica | Atenuación 11 dB en firmware |
| GPIO 33 | ADC1_CH5 | DS18B20 (línea DQ) | Bidireccional (1-Wire) | Pull-up externa 4.7 kΩ |
| GPIO 35 | ADC1_CH7 | Sensor pH SEN0161 | Entrada analógica | Calibrado con soluciones buffer pH 4 y 7 |
| GPIO 36 | ADC1_CH0 (VP) | Sensor EC conductividad | Entrada analógica | Filtro promedio móvil por software |
| GPIO 18 | VSPI_SCK | Módulo LoRa Ra-02 (SX1276) | Salida digital | Reloj bus SPI |
| GPIO 19 | VSPI_MISO | Módulo LoRa Ra-02 (SX1276) | Entrada digital | Datos hacia microcontrolador |
| GPIO 23 | VSPI_MOSI | Módulo LoRa Ra-02 (SX1276) | Salida digital | Datos desde microcontrolador |
| GPIO 5 | VSPI_SS | Módulo LoRa Ra-02 (SX1276) | Salida digital | Chip select (NSS/CS) activo en BAJO |
| GPIO 14 | HSPICLK | Módulo LoRa Ra-02 (SX1276) | Salida digital | Reset por hardware (RST) |
| GPIO 2 | HSPIWP | Módulo LoRa Ra-02 (SX1276) | Entrada digital | Interrupción DIO0 para eventos TX/RX |
| GPIO 21 | I2C_SDA | Módulo I2C LCD 1602 (PCF8574) | Bidireccional open-drain | Datos bus I2C |
| GPIO 22 | I2C_SCL | Módulo I2C LCD 1602 (PCF8574) | Bidireccional open-drain | Reloj bus I2C |

> **Consideración crítica de diseño:** Todas las señales analógicas (humedad, pH y EC) se direccionan estrictamente al bloque **ADC1** del ESP32. El bloque ADC2 queda bloqueado por hardware cuando el módulo WiFi ejecuta procesos de comunicación inalámbrica, por lo que su uso generaría lecturas inestables o bloqueadas.

### Descripción del circuit design

El circuit design del SmartPalm Edge Node organiza los componentes en capas funcionales alrededor del ESP32 como unidad central. En la capa superior se encuentran los tres sensores de campo (DHT22, sensor de humedad de suelo y pH) que envían señales analógicas a los canales ADC del ESP32, el cual las convierte a valores digitales de 12 bits. En la capa izquierda se ubica el sensor EC, también analógico, separado por operar en una sonda independiente enterrada en el suelo. En la capa derecha se encuentra el módulo LoRa SX1276, conectado mediante el bus SPI de cuatro hilos (SCK, MISO, MOSI, NSS). En la capa inferior se encuentra el sistema de energía compuesto por el panel solar, el módulo cargador TP4056 y la batería LiPo. El flujo del sistema es: los sensores capturan los parámetros del cultivo, el ESP32 los procesa localmente aplicando lógica de edge computing, y el módulo LoRa transmite el resultado al gateway, todo alimentado de forma autónoma por energía solar.

---

## Power Budget — Análisis de Balance Energético

Para fundamentar matemáticamente la viabilidad de la autonomía energética en campo, se desarrolló un modelo de balance de cargas basado en el peor escenario operativo en la región Ucayali (baja radiación por nubosidad extrema e incremento estacional de lluvias).

### Modelado de consumo del nodo objetivo

El dispositivo opera bajo un régimen asíncrono controlado por el temporizador RTC interno. El ciclo se modela con dos estados recurrentes:

- **Estado Activo ($T_{act}$):** Duración fija de 5 segundos. El microcontrolador despierta, energiza sensores mediante un interruptor MOSFET de canal P, ejecuta el muestreo ADC con sobremuestreo (16 muestras por canal), procesa los algoritmos locales y realiza la transmisión RF a máxima potencia (+20 dBm).
$$\text{Consumo promedio en ráfaga} = 130\text{ mA}$$

- **Estado de Inactividad ($T_{sleep}$):** Duración nominal de 15 minutos (900 segundos). El ESP32 se configura en modo *Deep Sleep* con retención de variables en RTC Fast Memory. Los periféricos se desconectan físicamente mediante MOSFET de corte.
$$\text{Consumo promedio residual} = 15\text{ µA} = 0.015\text{ mA}$$

### Cálculo de carga eléctrica diaria

El tiempo total del ciclo es $T_{ciclo} = 5\text{ s} + 900\text{ s} = 905\text{ s}$. El número de ciclos por día es:

$$N_{ciclos} = \frac{86400\text{ s}}{905\text{ s}} \approx 95.47\text{ ciclos/día}$$

La capacidad consumida en estado activo por ciclo:

$$Q_{act\_ciclo} = 130\text{ mA} \times \left(\frac{5\text{ s}}{3600\text{ s/h}}\right) \approx 0.1805\text{ mAh}$$

La capacidad consumida en estado de reposo por ciclo:

$$Q_{sleep\_ciclo} = 0.015\text{ mA} \times \left(\frac{900\text{ s}}{3600\text{ s/h}}\right) \approx 0.00375\text{ mAh}$$

La carga total por día, con factor de seguridad del 20% por auto-descarga y degradación térmica:

$$Q_{diaria} = (0.18425\text{ mAh} \times 95.47) \times 1.2 = \mathbf{21.11\text{ mAh/día}}$$

### Dimensionamiento del sistema fotovoltaico y autonomía

Con una batería LiPo de 5000 mAh y límite de descarga al 80% (4000 mAh útiles):

$$D_A = \frac{4000\text{ mAh}}{21.11\text{ mAh/día}} \approx \mathbf{189.48\text{ días de autonomía sin solar}}$$

Un panel solar monocristalino de 5W operando con 3.0 HSP mínimas (peor caso Ucayali) y eficiencia del sistema del 70% genera:

$$\text{Energía generada} = \frac{5\text{W} \times 0.70}{3.7\text{V}} \times 3.0\text{ HSP} \approx \mathbf{2838\text{ mAh/día}}$$

Dado que la energía generada (2838 mAh/día) supera ampliamente el consumo diario (21.11 mAh/día), el panel solar garantiza recarga completa en menos de una hora de sol directo, demostrando la sostenibilidad energética indefinida del sistema.

---

## Link Budget — Modelo de Propagación LoRa

La plantación de palma aceitera genera un entorno crítico para la propagación RF por la alta densidad foliar y su elevado contenido de agua, induciendo pérdidas por absorción y difracción. Se validó la viabilidad del enlace a una distancia objetivo de 2 km.

### Parámetros del transceptor Ra-02 (SX1276)

| Parámetro | Valor |
|---|---|
| Potencia de transmisión ($P_{TX}$) | +20 dBm |
| Ganancia antena transmisora ($G_{TX}$) | +3 dBi |
| Ganancia antena gateway ($G_{RX}$) | +6 dBi |
| Sensibilidad del receptor ($Rx_{sens}$) | −148 dBm (SF=12, BW=125 kHz, CR=4/5) |

### Cálculo de pérdidas y presupuesto de enlace

Pérdida en espacio libre a 915 MHz y 2 km:

$$L_{FSPL} = 20\log_{10}(2) + 20\log_{10}(915) + 32.44 = \mathbf{97.69\text{ dB}}$$

Atenuación por vegetación densa de palma aceitera (banda 900 MHz, trayecto horizontal):

$$L_{veg} = \mathbf{22\text{ dB}}$$

Potencia recibida estimada en el gateway (ecuación de Friis extendida):

$$P_{RX} = 20 + 3 + 6 - 97.69 - 22 - 1.5 = \mathbf{-92.19\text{ dBm}}$$

### Margen de desvanecimiento (Fade Margin)

$$\text{Fade Margin} = P_{RX} - Rx_{sens} = -92.19 - (-148) = \mathbf{55.81\text{ dB}}$$

Un enlace se considera de grado industrial con Fade Margin superior a +20 dB. El margen de 55.81 dB demuestra robustez redundante, garantizando una tasa de pérdida de paquetes (PER) cercana al 0% bajo las condiciones meteorológicas extremas de Ucayali.

---

## Physical Device Design

### Descripción física e ingeniería de carcasa

El despliegue en la Amazonia peruana impone restricciones climáticas severas (hasta 3500 mm/año de pluviosidad, humedad relativa persistente >85%). El diseño físico adopta directrices de ingeniería mecánica e hidráulica industrial:

- **Material:** Carcasa ABS de alta densidad con aditivos de protección UV.
- **Grado de hermeticidad:** Certificación **IP67** — protección absoluta contra polvo e inmersión temporal. Dimensiones: 22 cm × 15 cm × 10 cm.
- **Anclaje:** Mástil de aluminio anodizado de 1.5 m con abrazaderas de acero inoxidable.
- **Captación solar:** Panel monocristalino 5W con inclinación estática de 15° orientada al norte geográfico.
- **Acometidas subterráneas:** Sonda capacitiva a 20 cm, sonda DS18B20 a 15 cm, sondas pH/EC a 25 cm. Cada cable ingresa por prensaestopas hermético de nailon con sello de goma NBR. Cableado exterior en manguera corrugada UV-resistente.

### Componentes físicos y su ubicación

| Componente | Ubicación física |
|---|---|
| Panel solar 5W monocristalino | Panel superior, inclinación 15° hacia el norte |
| Antena LoRa 3 dBi / SMA 915 MHz | Parte superior de la carcasa, exterior |
| Carcasa IP67 (ESP32 + LoRa + LiPo) | Cuerpo principal, sellada herméticamente |
| Cámara OV2640 2MP | Frente de la carcasa, protegida con vidrio |
| LED de estado | Frente de la carcasa |
| Puerto USB de configuración | Base de la carcasa, con tapa sellada |
| Sensor humedad suelo (capacitivo) | Sonda subterránea a 20 cm |
| Sensor temperatura suelo DS18B20 | Sonda subterránea a 15 cm |
| Sonda pH / EC | Sonda subterránea a 25 cm |

### Diagrama del dispositivo físico

![Physical Device Design - SmartPalm IoT](https://raw.githubusercontent.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/feature/37-iot-device-design/assets/img/smartpalm_physical_device_1.png)

## Réplica del prototipo físico en Wokwi

> Prototipo Nodo Sensor (Replica del modelo fisico)

![Physical Sensor Node Prototype WW - SmartPalm IoT](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/d8b14dffca8e88d238c5bc001bfc8cf111b5459d/assets/img/Node%20Prototype%20Wokwi.png)

---

> Prototipo Nodo Gateway (Replica del modelo Fisico)

![Physical Gateway Node Prototype WW - SmartPalm IoT](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/c782b3961e4104c08b6fb236a19068d39c4fe530/assets/img/node_gateway_prototype.png)

---

### Implementación del Firmware (Wokwi)

### Descripción de la simulación

El sistema integra cinco sensores principales: DHT22, DS18B20, sensor capacitivo de humedad de suelo, y dos sensores analógicos para pH y EC del suelo. Los datos se visualizan en tiempo real a través de una pantalla LCD 16x2 con interfaz I2C, que rota automáticamente entre cuatro vistas: temperatura y humedad del aire, temperatura y humedad del suelo, pH y EC, y estado general de alertas.

El sistema cuenta con un módulo de edge computing que evalúa cada lectura contra los umbrales agronómicos del INIA para la región Ucayali. La comunicación se simula mediante el Serial Monitor, donde cada 15 segundos se genera un payload JSON comprimido con todas las lecturas del ciclo activo, el número de ciclo, el flag de alerta y la confirmación de envío al gateway con su respectivo ACK hacia Azure IoT Hub.

### Arquitectura del firmware y lógica de edge computing

El firmware opera bajo una máquina de estados optimizada para entornos de baja potencia. En lugar de transmitir datos crudos continuamente, el microcontrolador actúa como unidad de decisión en el borde de la red:

![Logic Architecture](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/1d20ba760d2b4bd64a3c3e322a9257019774cf00/assets/img/logic_architecture.svg)

Cada vez que el microcontrolador completa un ciclo de lectura, evalúa los datos contra la matriz de umbrales agronómicos del INIA:

| Variable | Rango óptimo | Alerta generada |
|---|---|---|
| Humedad suelo | 30–80% | < 30% sequía · > 80% anegamiento |
| pH suelo | 4.5–6.5 | < 4.5 acidez crítica · > 6.5 alcalinidad |
| Temperatura aire | hasta 35°C | > 35°C estrés térmico |
| EC suelo | 200–2000 µS/cm | fuera de rango: nutrición deficiente |

### Librerías utilizadas

| Librería | Versión | Uso |
|---|---|---|
| DHT sensor library (Adafruit) | latest | Lectura DHT22 |
| Adafruit Unified Sensor | latest | Dependencia Adafruit |
| LiquidCrystal I2C (Frank de Brabander) | 1.1.2 | Display LCD I2C |
| OneWire | latest | Bus 1-Wire DS18B20 |
| DallasTemperature | latest | Lectura DS18B20 |

### Estructura del payload

```json
{
  "c": 1,
  "ta": 28.4,
  "ha": 72.1,
  "ts": 27.1,
  "hs": 65.3,
  "ph": 5.82,
  "ec": 412,
  "al": 0
}
```

| Campo | Descripción | Unidad |
|---|---|---|
| `c` | Número de ciclo | — |
| `ta` | Temperatura del aire | °C |
| `ha` | Humedad del aire | % |
| `ts` | Temperatura del suelo | °C |
| `hs` | Humedad del suelo | % |
| `ph` | pH del suelo | 0–14 |
| `ec` | Conductividad eléctrica | µS/cm |
| `al` | Flag de alerta (0=OK, 1=alerta) | — |



---

## Los 12 Steps del Device Design

**Step 1 — Definición del problema del dispositivo**
El Edge Node de SmartPalm debe monitorear en tiempo real parámetros críticos del cultivo de palma aceitera en zonas remotas de la Amazonia peruana, donde no existe conectividad a internet, las condiciones ambientales son extremas (humedad >85%, temperatura 24–32°C, lluvias de hasta 3500 mm/año) y el acceso técnico es infrecuente. El dispositivo debe operar de forma completamente autónoma.

**Step 2 — Selección del microcontrolador**
Se seleccionó el ESP32-WROOM-32 como unidad de procesamiento principal. Justificación: procesador dual-core Xtensa LX6 a 240 MHz, ADC de 12 bits en canal ADC1 compatible con WiFi activo, soporte para deep sleep con consumo menor a 15 µA, WiFi y Bluetooth integrados para configuración inicial, y compatibilidad nativa con el bus SPI para el módulo LoRa. Su costo (~$4 USD) y disponibilidad en el mercado peruano lo hacen viable para producción.

**Step 3 — Selección de sensores**
Los sensores fueron seleccionados según los parámetros agronómicos críticos definidos por el INIA para la región Ucayali: DHT22 para temperatura ambiente (−40 a 80°C, ±0.5°C) y humedad relativa del aire; DS18B20 para temperatura del suelo con interfaz 1-Wire y resolución de 12 bits; sensor capacitivo de humedad de suelo v1.2 resistente a corrosión; SEN0161 (DFRobot) para pH del suelo en rango 0–14; sensor EC analógico para conductividad eléctrica; y OV2640 módulo de cámara 2MP para captura visual del estado fitosanitario.

**Step 4 — Selección del protocolo de comunicación**
Se adoptó LoRaWAN 915 MHz (banda ISM libre en Perú según normativa MTC) sobre alternativas como 2G/3G, WiFi o Zigbee. Ventajas determinantes: alcance de 2–15 km en terreno abierto con Fade Margin de 55.81 dB validado matemáticamente, consumo de transmisión de 30–50 mA, operación sin infraestructura de internet, y penetración en vegetación densa. El módulo Ra-02 (SX1276) se integra vía SPI al ESP32.

**Step 5 — Diseño del sistema de energía**
El sistema consta de un panel solar monocristalino de 5W/6V, módulo cargador TP4056 con protección de sobrecarga/descarga, batería LiPo de 3.7V/5000 mAh y convertidor boost MT3608. El análisis de Power Budget demuestra una autonomía de 189.48 días sin generación solar y recarga completa en menos de una hora de sol directo.

**Step 6 — Circuit Design**
Se diseñó el esquemático completo del Edge Node en Wokwi, incluyendo todas las conexiones GPIO, el bus SPI para LoRa, el bus I2C para el display LCD, los rieles de alimentación 3.3V/5V y las resistencias pull-up para el DHT22 (10 kΩ) y el DS18B20 (4.7 kΩ).

**Step 7 — Pin Mapping e interfaz de pines**
Ver tabla completa de pin mapping en la sección Circuit Design. La asignación estricta al bloque ADC1 (GPIO 32, 33, 35, 36) para todos los sensores analógicos es una decisión de diseño crítica que garantiza compatibilidad con el módulo WiFi en operación simultánea.

**Step 8 — Physical Device Design**
Carcasa ABS IP67 de 22×15×10 cm montada sobre poste de aluminio de 1.5 m. Panel solar con inclinación 15° al norte. Antena LoRa 3 dBi con conector SMA exterior. Sondas de suelo selladas con prensaestopas NBR penetrando hasta 25 cm. Ver sección Physical Device Design.

**Step 9 — Arquitectura del firmware**
El firmware opera en ciclo: wake-up → inicialización → lectura y promediado → procesamiento edge → empaquetado JSON → transmisión LoRa → ACK o buffer flash → deep sleep por 15 minutos. Ciclo activo menor a 30 segundos. Consumo en deep sleep inferior a 15 µA.

**Step 10 — Lógica de Edge Computing**
El ESP32 evalúa localmente los datos contra los umbrales INIA antes de transmitir. Solo se envían alertas y estadísticas del intervalo (media, mínimo, máximo), reduciendo el payload de ~500 B a ~120 B. En modo offline, los datos se almacenan en flash SPIFFS (hasta 72 h de buffer) y se sincronizan al recuperar conectividad.

**Step 11 — Diseño de transmisión de datos**
Payload LoRa en JSON comprimido (ver estructura en sección Firmware). Frecuencia de 15 minutos en modo normal y 5 minutos ante alertas activas. LoRaWAN Class A con ventanas RX1 para confirmación ACK. El gateway (Raspberry Pi + RAK2245) reenvía a Azure IoT Hub via MQTT con autenticación por certificado X.509.

**Step 12 — Plan de pruebas y validación**
Las pruebas se estructuran en tres fases: (1) pruebas de banco — verificación de lecturas contra instrumentos calibrados, medición de consumo con multímetro; (2) pruebas de integración — ciclo completo del firmware, alcance LoRa en entorno abierto, autonomía de batería en ciclo continuo de 72 h; (3) pruebas de campo en Ucayali — validación contra parámetros INIA, resistencia a lluvia intensa, alcance LoRa en vegetación amazónica, autonomía solar en período nublado. Criterio de aceptación: tasa de entrega de paquetes superior al 90% durante 30 días consecutivos.

> Las fases (1) y (2) ya cuentan con una primera validación real documentada en la Parte B: el prototipado físico confirmó la lectura correcta de sensores, el ciclo completo de firmware (captura → buffer → reenvío por lotes) y la comunicación entre dos nodos.
---

# Parte B — Prototipado Físico (Validación de Concepto)

## Justificación e inclusión en la estrategia IoT

Para garantizar que las capas superiores de software (Backend API, Base de Datos y Dashboards) funcionen correctamente con la estructura de telemetría planificada, el equipo implementó una fase de desarrollo intermedio. El prototipado físico en hardware de laboratorio tuvo como objetivo prioritario validar el **flujo de datos de extremo a extremo y la lógica de enrutamiento jerárquico**.

Debido a restricciones presupuestarias y de disponibilidad de componentes industriales, se sustituyeron las tecnologías de largo alcance y las sondas de grado de campo por hardware comercial equivalente, permitiendo evaluar los algoritmos de empaquetamiento y retransmisión sin comprometer la inversión en infraestructura LoRaWAN.

### Tabla de equivalencia técnica (Diseño Objetivo vs. Prototipo Físico)

| Eje Arquitectónico | Diseño Conceptual (Parte A) | Prototipo Físico (Parte B) | Métrica Validada |
|---|---|---|---|
| **Topología de Red** | Estrella (nodo → gateway LoRa) | Jerárquica (nodo sensor → gateway WiFi local) | Aislamiento del nodo sensor del tráfico exterior |
| **Enlace de Datos** | LoRaWAN 915 MHz | WiFi 802.11 b/g/n (AP local de laboratorio) | Estructuración correcta de tramas HTTP y objetos JSON |
| **Ecosistema de Captura** | DHT22, DS18B20, Humedad Cap., pH, EC | DHT11, HW-390 (capacitivo), ARD-LDR | Rutinas ADC, promediado estadístico y formateo |
| **Gestión de Energía** | Panel Solar 5W + LiPo 5000 mAh | Alimentación continua USB 5V DC | Estabilidad de bucles lógicos y ausencia de fugas de memoria |

### Arquitectura de los dos prototipos

![Arquitectura de los dos prototipos SmartPalm](../assets/img/smartpalm_prototipos_arquitectura.png)

El Prototipo 1 cumple el rol de **nodo sensor de campo**: captura variables agronómicas y las envía por WiFi. El Prototipo 2 cumple el rol de **nodo gateway**: recibe los datos, los almacena en buffer circular y los reenvía en lote al backend, replicando a menor escala el patrón "nodo de campo → gateway → cloud" del diseño conceptual.

---

## Prototipo 1 — Nodo Sensor de Campo

El Prototipo 1 representa la unidad encargada del monitoreo ambiental directo. Se construyó sobre la placa **NodeMCU-32S** (ESP32-WROOM-32, dual-core 240 MHz, WiFi integrado, 38 pines). Su firmware lee secuencialmente los periféricos, calcula promedios locales para mitigar el ruido analógico, renderiza las variables en un display OLED y emite una solicitud HTTP POST hacia el Gateway local.

### Hardware

| Componente | Modelo | Función |
|---|---|---|
| Microcontrolador | NodeMCU-32S (ESP32-WROOM-32) | Procesamiento, WiFi cliente, lectura de sensores |
| Sensor temp/humedad | DHT11 (módulo 3 pines) | Temperatura (0–50°C, ±2°C) y humedad (20–90% HR, ±5%) |
| Sensor humedad suelo | HW-390 (capacitivo, IC TLC555) | Permitividad dieléctrica del suelo — sin corrosión galvánica |
| Sensor luminosidad | ARD-LDR (fotorresistencia CdS) | Radiación lumínica relativa del entorno |
| Display | OLED 0.96" GME12864-51 (SSD1315, I2C 0x3C) | Lecturas en tiempo real, diagnóstico local |
| LED de estado | Built-in GPIO2 | Indicador de ciclo de lectura activo |

### Esquema de conexiones físicas

![Scheme Physical Sensor SmartPalm](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/1d20ba760d2b4bd64a3c3e322a9257019774cf00/assets/img/scheme_physical_sensor.svg)

> **Nota técnica:** GPIO 32 y GPIO 33 pertenecen al canal ADC1, el único operable con WiFi activo en el ESP32. GPIO 27, aunque pertenece a ADC2, se usa exclusivamente como pin digital para el DHT11, sin generar conflicto.

### Firmware y payload

El firmware (`smart_palm_wifi.ino`) promedia 5 lecturas por sensor analógico antes de cada envío para reducir el ruido. Cada 5 segundos transmite el siguiente payload JSON al Prototipo 2 por HTTP POST:

```json
{
  "temperature": 26.5,
  "humidity": 72.0,
  "soilMoisture": 45,
  "light": 78,
  "timestamp": 12340
}
```

**Estado de implementación:** Funcional. El ESP32 conecta correctamente al AP del Prototipo 2 y transmite lecturas en tiempo real.

---

## Prototipo 2 — Edge Node (Nodo Gateway Local)

El Prototipo 2 actúa como el núcleo de enrutamiento y gestión local de la red experimental. Se estructuró usando una tarjeta **ESP32-DevKitC-32U** con Shield de expansión de 38 pines. No tiene sensores de adquisición directa: su ingeniería se orienta al control de tráfico de red, manejo de colas en memoria y despliegue de interfaces de diagnóstico.

### Hardware

| Componente | Modelo | Función |
|---|---|---|
| Microcontrolador | ESP32-DevKitC-32U (ESP32-WROOM-32) | WiFi modo AP+Station simultáneo, servidor HTTP |
| Shield auxiliar | Shield 38Pin | Acceso a pines en protoboard, riel de 5V |
| Display | LCD 1602A + módulo I²C PCF8574 (0x27) | Estado operativo del sistema (3 pantallas rotativas) |

### Esquema de conexiones físicas

![Scheme Physical Gateway SmartPalm](https://github.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/blob/1d20ba760d2b4bd64a3c3e322a9257019774cf00/assets/img/scheme_physical_gateway.svg)

> **⚠ Advertencia crítica de hardware:** El módulo PCF8574 con el LCD 1602A requiere alimentación a **5V DC**. A 3.3V el contraste se degrada completamente impidiendo la visualización. El VCC del display se vincula al riel de 5V del Shield, mientras que las líneas I2C (GPIO 21/22) operan seguros a 3.3V gracias a la configuración open-drain del bus.

### Pantallas del LCD

El LCD rota cada 2.5 segundos entre tres vistas de diagnóstico:

| Pantalla | Contenido |
|---|---|
| A — Conectividad | Estado P1 (`D1:OK`/`---`), lecturas en buffer, estado backend (`BE:OK`/`---`), total enviado |
| B — Última lectura | Temperatura, humedad, humedad suelo y luminosidad más recientes del Prototipo 1 |
| C — Red y contadores | SSID del AP creado, total recibido (`Rx`) y reenviado (`Tx`) |

### Firmware y protocolo de buffer

El firmware (`smart_palm_edge_node.ino`) configura el ESP32 en modo **WIFI_AP_STA simultáneo**: crea el AP `SmartPalm-EdgeNode` (IP fija `192.168.4.1`) para recibir datos del Prototipo 1, y se conecta a red externa para reenviar al backend.

| Parámetro | Valor | Descripción |
|---|---|---|
| `MAX_BUFFER` | 20 lecturas | Capacidad del buffer circular en RAM |
| `BATCH_TRIGGER` | 5 lecturas | Envío al backend al acumular este número |
| `BATCH_INTERVAL` | 30 s | Envío forzado aunque no se alcance el trigger |
| `D1_TIMEOUT` | 15 s | Tiempo sin datos para marcar P1 como desconectado |

### Secuencia de transacciones

| Secuencia | Nodo Sensor (P1) | Edge Gateway (P2) | Flask Cloud API |
|---|---|---|---|
| **T1 (cada 5 s)** | Emite HTTP POST (JSON) → | Recibe en puerto 80 | Inactivo |
| **T2 (procesamiento)** | Espera respuesta | Inserta en cola RAM (buffer +1) | Inactivo |
| **T3 (condición lote)** | Continúa muestreo | ¿Contador == 5? o ¿Tiempo > 30s? | Inactivo |
| **T4 (transmisión)** | Inactivo | Compila `readings[]` → | Recibe HTTP POST con API keys |
| **T5 (confirmación)** | Inactivo | ← HTTP 201 | Valida e inserta en base de datos |
| **T6 (liberación)** | Inactivo | Vierte buffer a cero | Inactivo |

El payload reenviado incluye autenticación por headers `X-Device-Id` y `X-Api-Key`:

```json
{
  "readings": [
    { "variable": "temperature",   "value": 25.5, "unit": "C",   "timestamp": "2026-06-18T10:00:00+00:00" },
    { "variable": "humidity",      "value": 65.0, "unit": "%",   "timestamp": "2026-06-18T10:00:00+00:00" },
    { "variable": "soil_moisture", "value": 45.0, "unit": "%",   "timestamp": "2026-06-18T10:00:00+00:00" },
    { "variable": "light",         "value": 780.0,"unit": "lux", "timestamp": "2026-06-18T10:00:00+00:00" }
  ]
}
```

**Estado de implementación:** Funcional. AP activo, LCD mostrando las 3 pantallas, recepción de lecturas del Prototipo 1 confirmada.

---

## Memory Assessment — Análisis de Capacidad del Buffer en RAM

Para emular los escenarios de conectividad intermitente de la Amazonia peruana, el firmware del Gateway establece un buffer circular en RAM. Se analiza la capacidad máxima de retención ante caídas de conectividad.

### Ecuaciones de consumo de memoria

Un objeto JSON de lectura única tiene un tamaño de $B_{msj} = 196\text{ bytes}$. Con frecuencia de muestreo de 5 segundos:

$$\Delta M = \frac{196\text{ bytes}}{5\text{ s}} = 39.2\text{ bytes/s} \approx 2.35\text{ KB/min}$$

### Evaluación de límites del heap

El ESP32 dispone de 520 KB de SRAM. Descontando FreeRTOS, pila TCP/IP de WiFi y variables globales (220 KB reservados), el heap libre es de 300 KB. Aplicando techo de seguridad del 70%:

$$M_{buffer\_util} = 307{,}200\text{ bytes} \times 0.70 = 215{,}040\text{ bytes}$$

$$N_{max\_mensajes} = \frac{215{,}040\text{ bytes}}{196\text{ bytes}} = \mathbf{1097\text{ registros}}$$

### Tiempo máximo de resiliencia ante caída de conectividad

$$T_{max\_caida} = 1097 \times 5\text{ s} = 5485\text{ s} \approx \mathbf{1.52\text{ horas}}$$

Este análisis valida el buffer en RAM para el ciclo de laboratorio. Para el despliegue final en Ucayali (donde los cortes pueden extenderse por días), la arquitectura migrará el buffer hacia memoria Flash SPIFFS o tarjeta micro-SD por bus SPI, permitiendo almacenar más de un año de lecturas agronómicas continuas.

---

## Comparación entre Prototipo 1 y Prototipo 2

| Aspecto | Prototipo 1 (Nodo Sensor) | Prototipo 2 (Edge Node) |
|---|---|---|
| Placa | NodeMCU-32S | ESP32-DevKitC-32U + Shield 38Pin |
| Sensores | DHT11, HW-390, ARD-LDR | Ninguno |
| Display | OLED 128×64 I²C 0x3C (3.3V) | LCD 1602A + PCF8574 I²C 0x27 (5V) |
| Rol WiFi | Station (cliente) | AP + Station simultáneo |
| Rol HTTP | Cliente — envía POST | Servidor (recibe) + Cliente (reenvía) |
| Almacenamiento | Sin persistencia local | Buffer circular RAM (20 lecturas / 1097 máx teórico) |

Esta separación de responsabilidades — un nodo que solo mide y un nodo que orquesta, almacena y reenvía — es la misma lógica de **edge computing distribuido** del Step 10, donde el procesamiento ocurre antes de llegar al backend, reduciendo la carga de red y permitiendo operación con conectividad intermitente.

---

## Conclusiones

El diseño del Edge Node SmartPalm integra de forma coherente la selección de hardware embebido, el diseño del circuito, la arquitectura del firmware con lógica de edge computing y el diseño físico resistente a las condiciones amazónicas. El análisis de Power Budget demuestra una autonomía de 189 días sin generación solar. El Link Budget valida un Fade Margin de 55.81 dB para el enlace LoRa a 2 km en vegetación densa, garantizando calidad de grado industrial. La simulación en Wokwi valida el comportamiento del firmware antes de la implementación física.

El prototipado físico demuestra en hardware real la viabilidad del patrón arquitectónico central: un nodo sensor que captura parámetros, un nodo gateway que recibe, almacena en buffer y reenvía en lote con autenticación, y un Flask Edge API que persiste los datos. El Memory Assessment confirma 1.52 horas de resiliencia en RAM, escalable a almacenamiento Flash o micro-SD para el despliegue final. Esta iteración constituye la base de ingeniería para integrar los módulos LoRa, el sistema de energía solar y las sondas industriales de la arquitectura objetivo.
