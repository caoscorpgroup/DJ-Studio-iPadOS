# Plan de implementación de DJ Studio

## Propósito

Convertir la especificación de producto en entregas pequeñas, comprobables y reversibles. La prioridad inicial no es construir todas las pantallas: es demostrar que la plataforma puede reproducir audio de forma estable, enrutar master/cue y recibir MIDI en el iPad objetivo.

## Principios de ejecución

1. **Prueba antes de promesa:** ninguna capacidad se considerará compatible hasta contar con una prueba reproducible en dispositivo.
2. **Dos decks A/B:** el objetivo de rendimiento y diseño se limita a los dos decks aprobados; no se ampliará el alcance sin autorización explícita.
3. **Audio independiente de la interfaz:** SwiftUI nunca será responsable del ciclo de tiempo real del audio.
4. **Offline-first:** la reproducción, biblioteca y análisis básico deben funcionar con archivos locales, sin cuentas ni servicios remotos.
5. **Coste cero por defecto:** no activar servicios, suscripciones, APIs de pago ni infraestructura facturable. Si GitHub u otro proveedor muestra límites o cargos, detenerse y solicitar autorización.
6. **Cambios aislados:** trabajar en ramas; revisar cambios antes de integrarlos en main.
7. **Evidencia:** cada casilla completada debe enlazar código, prueba, medición o documento que permita repetir la validación.

## Fase A — Preparación del entorno

### Objetivos
- Confirmar qué puede editarse y ejecutarse desde el iPad.
- Verificar si Swift Playgrounds puede cubrir el prototipado inicial.
- Verificar si GitHub Actions ofrece un runner macOS adecuado dentro de los límites gratuitos disponibles.
- Definir cómo se instalará una compilación de prueba en el iPad sin exponer certificados ni secretos.

### Entregables
- Matriz de opciones de edición y compilación.
- Workflow mínimo de compilación para un proyecto iPadOS.
- Registro de limitaciones, requisitos de firma y costes potenciales.
- Procedimiento de instalación y captura de logs en dispositivo.

### Criterio de salida
Una compilación de prueba puede generarse de forma reproducible y existe un camino legal y práctico para instalarla en el iPad. Una compilación exitosa en CI, por sí sola, no satisface este criterio.

## Fase B — Prototipo de audio

### Alcance mínimo
- Aplicación nativa vacía con una pantalla de diagnóstico.
- Selección de un archivo de audio local mediante el selector del sistema.
- Reproducción, pausa, parada y búsqueda de posición.
- Lectura de duración y formato.
- Medición de interrupciones, errores y comportamiento al cambiar la salida.
- Registro de configuración de sesión y ruta de audio.

### Fuera de alcance
- Sin mixer visual completo.
- Sin efectos creativos.
- Sin análisis BPM/tonalidad.
- Sin scratch ni timestretch.
- Sin grabación de mezclas.
- Sin prometer preescucha hasta validar salidas físicas separadas.

### Criterio de salida
Reproducción repetible de archivos de prueba, sin bloqueos de interfaz ni fallos audibles recurrentes; resultados documentados en el iPad A16.

## Fase C — Ruteo y monitorización

- Investigar la configuración de sesión de audio y los endpoints disponibles.
- Comprobar si el iPad y la interfaz USB presentan salidas separadas utilizables para master y cue.
- Medir latencia de salida y estabilidad con buffers disponibles.
- Documentar qué adaptador/hub y qué interfaz se utilizaron.
- No asumir que un conector físico de auriculares equivale a dos buses independientes.

**Puerta de salida:** master y cue deben poder verificarse físicamente por separado antes de implementar la experiencia de preescucha.

## Fase D — MIDI y hardware

- Enumerar dispositivos MIDI con Core MIDI.
- Capturar mensajes sin asignar funciones inicialmente.
- Crear un registro legible de timestamp, origen, canal, tipo, número y valor.
- Identificar jog, pitch, faders, knobs, botones y controles de transporte.
- Probar desconexión y reconexión.
- Investigar por separado el sensor AIR de la Hercules DJControl AIR original.

**Puerta de salida:** mapping basado en mensajes observados, no en suposiciones ni en mappings de modelos parecidos.

## Fase E — Primer DJ funcional de dos decks

Solo después de superar las puertas anteriores:
- Dos decks con carga y transporte.
- Waveforms y posición.
- Mixer de dos canales.
- EQ de tres bandas, filtro, ganancia y crossfader.
- Cue y preescucha, si el ruteo está validado.
- BPM manual como primera base; análisis automático después.
- Persistencia local de biblioteca y puntos de cue.

## Fase F — Análisis, FX y ampliación

Orden recomendado:
1. BPM y beatgrid.
2. Tonalidad y visualización de waveform.
3. Hot Cues básicos y loops manuales/automáticos.
4. FX básicos con parámetros suavizados.
6. Medición de dos decks bajo carga.
7. Validación prolongada de los dos decks A/B bajo carga, con registro de CPU, memoria, latencia y temperatura.

El análisis de actividad rítmica por secciones será una estimación derivada de características de señal; deberá poder revisarse y ajustarse.

## Gestión de riesgos

| Riesgo | Respuesta |
|---|---|
| No poder compilar desde el iPad | Validar pronto Playgrounds y runner macOS; no diseñar el proyecto suponiendo que CI resuelve firma e instalación |
| Ruteo master/cue no disponible | Probar interfaces y rutas reales antes de diseñar la preescucha |
| Latencia o dropouts | Medir con señales conocidas y reducir alcance antes de añadir FX |
| Controladora no reconocida | Registrar modelo, conexión, enumeración y mensajes; separar USB-MIDI de sensor propietario |
| El procesamiento de dos decks excede recursos | Medir y optimizar el motor antes de ampliar efectos o visualización |
| Dependencia con licencia incompatible | Auditar licencias y obligaciones antes de incorporar código o frameworks |

## Registro de avance

Las tareas solo se marcarán completas cuando se adjunte evidencia verificable. Los resultados negativos también deben documentarse: evitan repetir pruebas y permiten tomar decisiones informadas.
