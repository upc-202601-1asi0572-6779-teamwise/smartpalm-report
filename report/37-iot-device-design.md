# 5.6 Device Design

## Introducción

#### En esta sección presentamos el diseño e implementación del dispositivo IoT desarrollado para SmartPalm, desde el diseño conceptual simulado en Wokwi hasta el prototipado físico real construido y validado en hardware.

El diseño se desarrolló en dos etapas. La primera etapa corresponde al **diseño conceptual** (Edge Node objetivo), que define la arquitectura completa de sensores, comunicación LoRaWAN y energía solar pensada para el despliegue final en campo, y que fue validada mediante simulación en Wokwi. La segunda etapa corresponde al **prototipado físico**, en la cual el equipo construyó y probó en hardware real dos dispositivos complementarios — un Nodo Sensor y un Nodo Gateway (Edge Node) — que implementan una versión reducida y funcional del diseño conceptual, ajustada a los componentes disponibles y a las condiciones de prueba en laboratorio. Las secciones siguientes documentan ambas etapas y la relación entre ellas.


---

# Parte A — Diseño Conceptual (Edge Node objetivo)

> Esta primera parte describe la arquitectura completa diseñada como objetivo final de SmartPalm, validada mediante simulación en Wokwi. El prototipado físico real, descrito en la Parte B, implementa una versión reducida de este diseño usando los componentes disponibles para el equipo en esta etapa del proyecto.

##  Circuit Design

![alt text](../assets/img/smartpalm_circuit_design.png)

### Componentes del sistema

| Componente | Modelo | Función | Interfaz |
|---|---|---|---|
| Microcontrolador | ESP32-WROOM-32 | Unidad central de procesamiento | — |
| Sensor temp/humedad aire | DHT22 | Temperatura y humedad ambiental | GPIO 34 (ADC) |
| Sensor temperatura suelo | DS18B20 | Temperatura del suelo | GPIO 33 (1-Wire) |
| Sensor humedad suelo | Capacitive v1.2 | Humedad volumétrica del suelo | GPIO 32 (ADC) |
| Sensor pH | SEN0161 (DFRobot) | pH del suelo | GPIO 35 (ADC) |
| Sensor EC | Analógico genérico | Conductividad eléctrica del suelo | GPIO 36 (ADC) |
| Módulo LoRa | SX1276 / Ra-02 915 MHz | Comunicación LoRaWAN | SPI (GPIO 18/19/23/5/14) |
| Display | LCD 1602 I2C | Visualización local de lecturas | I2C (GPIO 21/22) |
| Sistema de energía | Panel solar 5W + TP4056 + LiPo 5000mAh | Alimentación autónoma | VIN / 3.3V |

### Diagrama de circuito (Wokwi)

El esquemático fue implementado en Wokwi usando el ESP32 DevKit V1 como microcontrolador central. Los sensores analógicos (humedad de suelo, pH y EC) se conectan a los canales ADC de 12 bits del ESP32. El DHT22 usa un pin digital con resistencia pull-up de 10kΩ a 3.3V. El módulo LoRa SX1276 se comunica mediante el bus SPI completo. El LCD 1602 usa comunicación I2C con dirección 0x27.

![Circuit Design - SmartPalm IoT Edge Node](https://raw.githubusercontent.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/feature/37-iot-device-design/assets/img/smartpalm_circuit_design.png)

### Tabla de pin mapping

| Pin ESP32 | Función | Componente |
|---|---|---|
| GPIO 34 | ADC / Digital | DHT22 (data) |
| GPIO 32 | ADC | Soil Moisture (AOUT) |
| GPIO 33 | 1-Wire | DS18B20 (DQ) |
| GPIO 35 | ADC | pH Sensor (AOUT) |
| GPIO 36 | ADC | EC Sensor (AOUT) |
| GPIO 18 | SPI SCK | LoRa SX1276 |
| GPIO 19 | SPI MISO | LoRa SX1276 |
| GPIO 23 | SPI MOSI | LoRa SX1276 |
| GPIO 5 | SPI NSS/CS | LoRa SX1276 |
| GPIO 14 | RST | LoRa SX1276 |
| GPIO 2 | DIO0 | LoRa SX1276 |
| GPIO 21 | I2C SDA | LCD 1602 |
| GPIO 22 | I2C SCL | LCD 1602 |
| 3.3V | VCC | DHT22, Soil, pH, EC, LoRa |
| VIN (5V) | VCC | LCD, Boost converter |
| GND | GND | Todos los componentes |

###  Descripción del circuit design

El circuit design del SmartPalm Edge Node organiza los componentes en capas funcionales alrededor del ESP32 como unidad central. En la capa superior se encuentran los tres sensores de campo (DHT22, sensor de humedad de suelo y pH) que envían señales analógicas a los canales ADC del ESP32, el cual las convierte a valores digitales de 12 bits. En la capa izquierda se ubica el sensor EC, también analógico, separado por operar en una sonda independiente enterrada en el suelo. En la capa derecha se encuentra el módulo LoRa SX1276, conectado mediante el bus SPI de cuatro hilos (SCK, MISO, MOSI, NSS), que constituye la radio responsable de transmitir los datos a kilómetros de distancia hasta el gateway sin requerir infraestructura de internet. En la capa inferior se encuentra el sistema de energía compuesto por el panel solar, el módulo cargador TP4056 y la batería LiPo, que otorgan al dispositivo autonomía completa en campo remoto. Los rieles de alimentación de 3.3V y GND recorren el diagrama en color rojo y negro respectivamente, mientras que los cables de señal de cada sensor se diferencian por color. El flujo del sistema es: los sensores capturan los parámetros del cultivo, el ESP32 los procesa localmente aplicando lógica de edge computing, y el módulo LoRa transmite el resultado al gateway, todo alimentado de forma autónoma por energía solar.

---

##  Physical Device Design

###  Descripción física

El dispositivo físico SmartPalm consiste en una carcasa de ABS con protección IP67 (resistente a polvo e inmersión hasta 1 metro), montada sobre un poste de aluminio de 1.5 metros de altura. Esta protección es crítica para operar en las condiciones de alta pluviosidad de la Amazonia peruana (hasta 3500mm/año de precipitaciones).

**Dimensiones de la carcasa:** 22cm × 15cm × 10cm

![alt text](../assets/img/smartpalm_physical_device.png)

###  Componentes físicos y su ubicación

| Componente | Ubicación física |
|---|---|
| Panel solar 5W monocristalino | Panel superior, inclinación 15° hacia el norte |
| Antena LoRa 3dBi / SMA 915 MHz | Parte superior de la carcasa, exterior |
| Carcasa IP67 (ESP32 + LoRa + LiPo) | Cuerpo principal, sellada herméticamente |
| Cámara OV2640 2MP | Frente de la carcasa, protegida con vidrio |
| LED de estado | Frente de la carcasa |
| Puerto USB de configuración | Base de la carcasa, con tapa sellada |
| Sensor humedad suelo (capacitivo) | Sonda subterránea a 20cm de profundidad |
| Sensor temperatura suelo DS18B20 | Sonda subterránea a 15cm de profundidad |
| Sonda pH / EC | Sonda subterránea a 25cm de profundidad |

Las sondas subterráneas salen de la base de la carcasa mediante prensaestopas sellados, garantizando la estanqueidad del sistema. Los cables de los sensores van protegidos por manguera corrugada UV-resistente.

###  Diagrama físico

![Physical Device Design - SmartPalm IoT](https://raw.githubusercontent.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/feature/37-iot-device-design/assets/img/smartpalm_physical_device.png)

---

##  Implementación del Firmware (Wokwi)

###  Descripción de la simulación

En esta sección presentamos el diseño e implementación del dispositivo IoT desarrollado en Wokwi para SmartPalm. El sistema integra cinco sensores principales: un sensor de temperatura y humedad ambiental DHT22, un sensor de temperatura de suelo DS18B20, un sensor capacitivo de humedad de suelo, y dos sensores analógicos para medición de pH y conductividad eléctrica (EC) del suelo. Los datos son visualizados en tiempo real a través de una pantalla LCD 16x2 con interfaz I2C, la cual rota automáticamente entre cuatro vistas: temperatura y humedad del aire, temperatura y humedad del suelo, pH y EC, y estado general de alertas.

El sistema cuenta con un módulo de edge computing que evalúa cada lectura contra los umbrales agronómicos definidos por el INIA para la región Ucayali: humedad de suelo menor a 30% activa alerta de sequía, pH fuera del rango 4.5–6.5 indica condición ácida o alcalina crítica, y temperatura del aire superior a 35°C señala estrés térmico en el cultivo. Ante cualquier condición crítica, el LCD muestra el mensaje de alerta y el payload de transmisión incluye el flag correspondiente.

La comunicación LoRaWAN es simulada mediante el Serial Monitor, donde cada 15 segundos se genera un payload JSON comprimido con todas las lecturas del ciclo activo, el número de ciclo, el flag de alerta y la confirmación de envío al gateway con su respectivo ACK hacia Azure IoT Hub. La simulación fue desarrollada en Wokwi con un ESP32 DevKit V1, permitiendo validar el comportamiento completo del firmware — lectura de sensores, procesamiento edge y transmisión — antes de pasar a la implementación física del dispositivo en campo.

###  Librerías utilizadas

| Librería | Versión | Uso |
|---|---|---|
| DHT sensor library (Adafruit) | latest | Lectura DHT22 |
| Adafruit Unified Sensor | latest | Dependencia Adafruit |
| LiquidCrystal I2C (Frank de Brabander) | 1.1.2 | Display LCD I2C |
| OneWire | latest | Bus 1-Wire DS18B20 |
| DallasTemperature | latest | Lectura DS18B20 |

###  Estructura del payload LoRaWAN

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

> Ver archivo `sketch.ino` para el código fuente completo del firmware.

---

## Los 12 Steps del Device Design

**Step 1 — Definición del problema del dispositivo**  
El Edge Node de SmartPalm debe monitorear en tiempo real parámetros críticos del cultivo de palma aceitera en zonas remotas de la Amazonia peruana, donde no existe conectividad a internet, las condiciones ambientales son extremas (humedad >85%, temperatura 24–32°C, lluvias de hasta 3500mm/año) y el acceso técnico es infrecuente. El dispositivo debe operar de forma completamente autónoma.

**Step 2 — Selección del microcontrolador**  
Se seleccionó el ESP32-WROOM-32 como unidad de procesamiento principal. Justificación: procesador dual-core Xtensa LX6 a 240MHz, ADC de 12 bits con múltiples canales analógicos, bajo consumo energético con soporte para deep sleep (<10µA), Wi-Fi y Bluetooth integrados para configuración inicial, y compatibilidad nativa con el bus SPI para el módulo LoRa. Su costo (~$4 USD) y disponibilidad en el mercado peruano lo hacen viable para producción.

**Step 3 — Selección de sensores**  
Los sensores fueron seleccionados según los parámetros agronómicos críticos definidos por el INIA para la región Ucayali: DHT22 para temperatura ambiente (−40 a 80°C, ±0.5°C) y humedad relativa del aire (0–100%, ±2–5%); DS18B20 para temperatura del suelo con interfaz 1-Wire y resolución de 12 bits; sensor capacitivo de humedad de suelo v1.2 con salida analógica resistente a corrosión; SEN0161 (DFRobot) para pH del suelo en rango 0–14; sensor EC analógico para conductividad eléctrica del suelo en µS/cm; y OV2640 módulo de cámara 2MP para captura visual del estado fitosanitario.

**Step 4 — Selección del protocolo de comunicación**  
Se adoptó LoRaWAN 915 MHz (banda ISM libre en Perú) sobre alternativas como 2G/3G, WiFi o Zigbee. Ventajas determinantes: alcance de 2–15 km en terreno abierto, consumo de transmisión de apenas 30–50mA, operación sin infraestructura de internet, y capacidad de penetración en vegetación densa. El módulo Ra-02 (SX1276) se integra vía SPI al ESP32.

**Step 5 — Diseño del sistema de energía**  
El sistema de energía consta de un panel solar monocristalino de 5W/6V, un módulo cargador TP4056 con protección de sobrecarga/descarga, una batería LiPo de 3.7V/5000mAh y un convertidor boost MT3608 que eleva a 5V para alimentar el ESP32. La autonomía estimada es de 3–5 días sin luz solar (modo de bajo consumo con deep sleep cada 15 minutos), garantizando operación continua en períodos de alta pluviosidad amazónica.

**Step 6 — Circuit Design**  
Se diseñó el esquemático completo del Edge Node en Wokwi, incluyendo todas las conexiones GPIO, el bus SPI para LoRa, el bus I2C para el display LCD de diagnóstico, los rieles de alimentación 3.3V/5V y las resistencias de pull-up necesarias para el DHT22 (10kΩ) y el DS18B20. Ver sección 2 y archivo `diagram.json`.

**Step 7 — Pin Mapping e interfaz de pines**  
Ver tabla completa de pin mapping en la sección 2.3.

**Step 8 — Physical Device Design**  
El dispositivo físico consiste en una carcasa de ABS con protección IP67, montada sobre un poste de aluminio de 1.5m de altura. El panel solar se instala en el panel superior con inclinación de 15° hacia el norte. La antena LoRa de 3dBi con conector SMA se ubica en la parte superior de la carcasa. Las sondas de suelo salen selladas por la base mediante prensaestopas, penetrando el suelo hasta 30cm. Dimensiones de la carcasa: 22cm × 15cm × 10cm. Ver sección 3.

**Step 9 — Arquitectura del firmware**  
El firmware sigue un ciclo de operación: (1) wake-up del deep sleep → (2) inicialización de sensores → (3) lectura de todos los parámetros → (4) procesamiento edge local (validación de rangos, detección de anomalías) → (5) empaquetado del payload JSON → (6) transmisión LoRaWAN → (7) confirmación ACK o almacenamiento en buffer local → (8) vuelta a deep sleep por 15 minutos. El ciclo completo consume menos de 30 segundos activos.

**Step 10 — Lógica de Edge Computing**  
El ESP32 procesa localmente los datos antes de transmitir, aplicando los umbrales agronómicos del INIA: humedad suelo <30% → alerta sequía, pH <4.5 o >6.5 → alerta acidez/alcalinidad, temperatura >35°C → alerta estrés térmico. Solo se transmiten alertas y resúmenes estadísticos, reduciendo el payload de ~500B a ~120B por transmisión. En modo offline, los datos se almacenan en la flash del ESP32 (hasta 72h de buffer) y se sincronizan al recuperar conectividad.

**Step 11 — Diseño de transmisión de datos**  
El payload LoRa se estructura como JSON comprimido (ver sección 4.3). La frecuencia de transmisión es cada 15 minutos en modo normal y cada 5 minutos ante alertas activas. Se usa LoRaWAN Class A con ventanas de recepción para confirmación ACK. El gateway LoRa (Raspberry Pi + RAK2245) reenvía los datos a Azure IoT Hub via MQTT.

**Step 12 — Plan de pruebas y validación**  
Las pruebas se estructuran en tres fases: (1) pruebas de banco — verificación de lecturas de cada sensor contra instrumentos calibrados, pruebas de consumo energético con multímetro; (2) pruebas de integración — verificación del ciclo completo del firmware, alcance LoRa en entorno simulado, autonomía de batería en ciclo continuo de 72h; (3) pruebas de campo en Ucayali — validación de lecturas contra parámetros INIA, prueba de resistencia a lluvia intensa, medición de alcance LoRa real en vegetación amazónica, verificación de autonomía solar en período nublado. Criterio de aceptación: tasa de entrega de paquetes superior al 90% durante 30 días consecutivos.

> Las fases (1) y (2) de este plan ya cuentan con una primera validación real, documentada en la Parte B: el prototipado físico confirmó la lectura correcta de sensores, el ciclo completo de firmware (captura → buffer → reenvío por lotes) y la comunicación entre dos nodos vía WiFi. Las pruebas de campo en Ucayali y la validación con LoRaWAN quedan pendientes para la siguiente iteración, una vez integrados los componentes del diseño conceptual completo.

---

# Parte B — Prototipado Físico

## Del diseño conceptual al prototipo real

El diseño conceptual descrito en la Parte A contempla un único Edge Node con seis sensores, comunicación LoRaWAN y alimentación solar autónoma. Para esta etapa del proyecto, el equipo priorizó validar en hardware real el **flujo completo de datos** — desde la captura en campo hasta el envío a un backend — antes de invertir en los componentes de mayor costo y complejidad de integración (LoRa, sondas de pH/EC, sistema solar). Como resultado, se construyeron y probaron **dos prototipos físicos** que, trabajando en conjunto, cubren ese flujo de extremo a extremo:

| | Diseño conceptual | Prototipado físico |
|---|---|---|
| Sensores | DHT22, DS18B20, soil moisture, pH, EC | DHT11, HW-390 (soil), ARD-LDR (luz) |
| Comunicación | LoRaWAN 915 MHz | WiFi 802.11 b/g/n (AP + STA) |
| Topología | 1 nodo → gateway externo → cloud | 2 nodos propios (sensor + gateway) → Flask API |
| Energía | Solar + LiPo autónoma | USB / 3.3V de laboratorio |
| Estado | Validado por simulación (Wokwi) | Validado en hardware físico real |

La comunicación LoRaWAN del diseño conceptual fue reemplazada por WiFi en el prototipo porque el alcance de campo no era una variable a probar en esta etapa; en cambio, sí lo era la arquitectura de dos nodos (sensor + gateway) y el protocolo de telemetría hacia el backend, que se mantiene compatible con el diseño objetivo. Asimismo, los sensores agronómicos avanzados (pH, EC, temperatura de suelo) quedan pendientes de integración en una siguiente iteración del prototipo, una vez validado el flujo de comunicación.

### Arquitectura de los dos prototipos

![Arquitectura de los dos prototipos SmartPalm](../assets/img/smartpalm_prototipos_arquitectura.png)

El Prototipo 1 cumple el rol de **nodo sensor de campo**: captura las variables agronómicas y las envía por WiFi. El Prototipo 2 cumple el rol de **nodo gateway**: no tiene sensores propios, sino que recibe los datos del Prototipo 1, los almacena temporalmente y los reenvía en lote al backend, replicando — a menor escala y sobre WiFi en vez de LoRa — el mismo patrón de "nodo de campo → gateway → cloud" que define el diseño conceptual de la Parte A.

---

## Prototipo 1 — Nodo Sensor

### Hardware

El Prototipo 1 se implementó sobre la placa **NodeMCU-32S** (módulo ESP32-WROOM-32, dual-core 240 MHz, WiFi integrado, 38 pines).

| Componente | Modelo | Función |
|---|---|---|
| Microcontrolador | NodeMCU-32S (ESP32-WROOM-32) | Procesamiento, WiFi cliente, lectura de sensores |
| Sensor temp/humedad aire | DHT11 (módulo 3 pines) | Temperatura y humedad ambiental |
| Sensor humedad suelo | HW-390 (capacitivo) | Humedad volumétrica del suelo |
| Sensor luminosidad | ARD-LDR | Nivel de luz ambiental |
| Display | GME12864-51 OLED 0.96" (SSD1315, I2C 0x3C) | Visualización local de lecturas |
| LED de estado | LED built-in (GPIO2) | Indicador de ciclo de lectura activo |

### Conexiones físicas

| GPIO ESP32 | Componente | Señal | Cable |
|---|---|---|---|
| GPIO27 | DHT11 (S) | Digital (1-Wire-like) | Verde |
| GPIO32 | HW-390 (AOUT) | ADC1 Ch4 | Azul |
| GPIO33 | ARD-LDR (AO) | ADC1 Ch5 | Amarillo |
| GPIO21 | OLED (SDA) | I²C | Naranja |
| GPIO22 | OLED (SCL) | I²C | Morado |
| GPIO2 | LED built-in | Digital output | — |
| 3.3V | VCC de todos los periféricos | Alimentación | Rojo |
| GND | Tierra común | — | Negro |

> **Nota técnica:** GPIO32 y GPIO33 se eligieron porque pertenecen al canal **ADC1**, el único que el ESP32 puede leer de forma segura mientras el módulo WiFi está activo (el canal ADC2 queda bloqueado en modo WiFi). GPIO27, aunque pertenece a ADC2, se usa exclusivamente como pin digital para el DHT11, por lo que no genera conflicto.

### Fotografía del prototipo armado

![Prototipo 1 - Nodo Sensor SmartPalm](https://raw.githubusercontent.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/feature/37-iot-device-design/assets/img/prototipo1_nodo_sensor.jpeg)

### Firmware y payload

El firmware activo (`smart_palm_wifi.ino`) lee los 4 sensores cada 5 segundos (promediando 5 lecturas por sensor analógico), los muestra en el OLED, y los envía por HTTP POST en formato JSON al Edge Node:

```json
{
  "temperature": 26.5,
  "humidity": 72.0,
  "soilMoisture": 45,
  "light": 78,
  "timestamp": 12340
}
```

**Estado de implementación:**  Funcional en hardware físico. El ESP32 conecta correctamente al AP del Prototipo 2 y transmite lecturas en tiempo real.

---

## Prototipo 2 — Edge Node (Nodo Gateway)

### Rol en la arquitectura

A diferencia del Prototipo 1, el Edge Node **no tiene sensores agronómicos**. Su función es actuar como intermediario WiFi entre el nodo sensor y el backend: crea su propia red de acceso, recibe las lecturas, las acumula en un buffer y las reenvía en lote.

### Hardware

| Componente | Modelo | Función |
|---|---|---|
| Microcontrolador | ESP32-DevKitC-32U (mismo módulo ESP32-WROOM-32) | WiFi modo AP+STA simultáneo, servidor HTTP |
| Shield auxiliar | Shield 38Pin | Acceso a pines en protoboard |
| Display | LCD 1602A + módulo I²C PCF8574 (0x27) | Estado operativo del sistema (3 pantallas) |

### Conexiones físicas

| GPIO ESP32 | Componente | Señal | Cable |
|---|---|---|---|
| GPIO21 | LCD (SDA, vía PCF8574) | I²C | Naranja |
| GPIO22 | LCD (SCL, vía PCF8574) | I²C | Morado |
| 5V (Shield) | LCD / PCF8574 (VCC) | Alimentación | Rojo |
| GND | Tierra común | — | Negro |

> **⚠ Advertencia de hardware:** El módulo PCF8574 con el LCD 1602A requiere alimentación a **5V**, no 3.3V — a 3.3V el texto no se muestra o el contraste queda en blanco. Los pines de señal I²C (GPIO21/22) sí trabajan a 3.3V y son compatibles con el módulo a 5V; solo el VCC necesita el riel de 5V del Shield.

### Fotografía del prototipo armado

![Prototipo 2 - Edge Node SmartPalm](https://raw.githubusercontent.com/upc-202601-1asi0572-6779-teamwise/smartpalm-report/feature/37-iot-device-design/assets/img/prototipo2_edge_node.jpeg)

### Pantallas del LCD

El LCD rota cada 2.5 segundos entre tres vistas de estado:

| Pantalla | Contenido |
|---|---|
| A — Conectividad | Estado del Prototipo 1 (`D1:OK`/`---`), lecturas en buffer, estado del envío al backend (`BE:OK`/`---`), total reenviado |
| B — Última lectura | Temperatura, humedad, humedad de suelo y luminosidad más recientes recibidas del Prototipo 1 |
| C — Red y contadores | Nombre del AP creado, total de lecturas recibidas (`Rx`) y reenviadas (`Tx`) |

### Firmware y protocolo

El firmware (`smart_palm_edge_node.ino`) configura el ESP32 en modo **WIFI_AP_STA simultáneo**: crea el AP `SmartPalm-EdgeNode` (IP fija `192.168.4.1`) para recibir datos del Prototipo 1, y opcionalmente se conecta a una red externa para reenviar al backend.

| Parámetro | Valor | Descripción |
|---|---|---|
| `MAX_BUFFER` | 20 lecturas | Capacidad del buffer circular en RAM |
| `BATCH_TRIGGER` | 5 lecturas | Envío al backend al acumular este número |
| `BATCH_INTERVAL` | 30 s | Envío forzado aunque no se alcance el trigger |
| `D1_TIMEOUT` | 15 s | Tiempo sin datos para marcar al Prototipo 1 como desconectado |

Las lecturas se reciben y reenvían en formato `readings[]`, autenticado con headers `X-Device-Id` y `X-Api-Key`:

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

**Estado de implementación:**  Funcional en hardware físico. El AP queda activo, el LCD muestra las 3 pantallas y la recepción de lecturas del Prototipo 1 fue confirmada. El reenvío al Flask Edge API requiere configurar la IP del computador antes de flashear (`CLOUD_API_URL`).

---

## Comparación entre Prototipo 1 y Prototipo 2

| Aspecto | Prototipo 1 (Nodo Sensor) | Prototipo 2 (Edge Node) |
|---|---|---|
| Placa | NodeMCU-32S | ESP32-DevKitC-32U + Shield 38Pin |
| Sensores | DHT11, HW-390, ARD-LDR | Ninguno |
| Display | OLED 128×64 I²C 0x3C (3.3V) | LCD 1602A + PCF8574 I²C 0x27 (5V) |
| Rol WiFi | Station (cliente) | AP + Station simultáneo |
| Rol HTTP | Cliente (envía POST) | Servidor (recibe) + Cliente (reenvía) |
| Almacenamiento | Sin persistencia local | Buffer circular en RAM (20 lecturas) |

Esta separación de responsabilidades — un nodo que solo mide y un nodo que solo orquesta y reenvía — es la misma lógica de **edge computing distribuido** descrita en el diseño conceptual de la Parte A (Step 10), donde el procesamiento y filtrado de datos ocurre antes de llegar al backend final, reduciendo la carga de red y permitiendo operación con conectividad intermitente.

---

##  Conclusiones

El diseño del Edge Node SmartPalm integra de forma coherente la selección de hardware, el diseño del circuito, la arquitectura del firmware y el diseño físico para responder a las condiciones específicas de los cultivos de palma aceitera en la Amazonia peruana. La elección del ESP32 con LoRaWAN permite operar de forma autónoma en zonas sin conectividad, mientras que el sistema de energía solar garantiza operación continua sin intervención técnica. La simulación en Wokwi valida el comportamiento del firmware y la lógica de edge computing antes de la implementación física, reduciendo el riesgo técnico del prototipo.

El prototipado físico desarrollado en esta etapa valida en hardware real el patrón arquitectónico central del diseño conceptual: un nodo de campo que captura datos y un nodo gateway que los recibe, almacena temporalmente y reenvía al backend. Aunque el prototipo actual usa WiFi en lugar de LoRaWAN y un subconjunto reducido de sensores, el protocolo de telemetría y la lógica de buffer/reenvío por lotes son directamente extensibles al diseño objetivo, sirviendo como base funcional para la siguiente iteración del producto, en la que se integrarán los sensores agronómicos avanzados (pH, EC, temperatura de suelo), el módulo LoRa y el sistema de energía solar autónoma.
