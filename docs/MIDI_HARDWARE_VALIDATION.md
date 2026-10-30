# Validación MIDI y Hercules DJControl AIR

## Objetivo

Determinar qué controles de la Hercules DJControl AIR original pueden utilizarse desde iPadOS mediante Core MIDI y comprobar por separado el sensor AIR. No extrapolar resultados de DJControl AIR+, DJControl AIRS, Inpulse 500 u otros modelos.

## Identificación del equipo

Antes de probar se registrará:
- Nombre exacto impreso en el equipo y revisión si está disponible.
- Método de conexión al iPad.
- Adaptador/hub utilizado y alimentación.
- Si el dispositivo aparece en el sistema.
- Nombre y propiedades expuestas por Core MIDI.
- Versión exacta de iPadOS.

## Etapa 1 — Enumeración

- Consultar endpoints MIDI disponibles.
- Registrar nombre del dispositivo, entidad, origen y destino.
- Observar eventos de conexión y desconexión.
- No enviar mensajes MIDI hasta identificar el endpoint y su comportamiento.

## Etapa 2 — Captura pasiva

Construir una pantalla/log de diagnóstico que registre:
- Timestamp monotónico.
- Endpoint de origen.
- Tipo de mensaje.
- Canal MIDI.
- Número de control o nota.
- Valor recibido.
- Bytes originales cuando resulte útil.

Mover un solo control cada vez y repetirlo para identificar su mensaje. Guardar capturas de controles sin asociar todavía acciones de DJ.

## Etapa 3 — Mapeo

Crear una tabla verificada:

| Control físico | Mensaje observado | Rango | Comportamiento | Validado |
|---|---|---|---|---|
| Jog izquierdo | Pendiente | Pendiente | Pendiente | No |
| Jog derecho | Pendiente | Pendiente | Pendiente | No |
| Pitch izquierdo/derecho | Pendiente | Pendiente | Pendiente | No |
| Faders de canal | Pendiente | Pendiente | Pendiente | No |
| Crossfader | Pendiente | Pendiente | Pendiente | No |
| EQ/knobs | Pendiente | Pendiente | Pendiente | No |
| Botones | Pendiente | Pendiente | Pendiente | No |
| Sensor AIR | Pendiente | Pendiente | Pendiente | No |

No rellenar números CC/Note a partir de documentación de modelos similares sin capturarlos en el equipo real.

## Etapa 4 — Sensor AIR

Investigar y probar:
- Si el sensor aparece como mensajes MIDI estándar.
- Si requiere una aplicación o driver externo.
- Si su lectura depende de firmware o configuración del controlador.
- Rango, zonas muertas, ruido y estabilidad.
- Mensajes recibidos con mano/objeto a distintas distancias, sin asumir que el sistema puede detectar distancia absoluta.

Si el sensor no expone datos accesibles a Core MIDI en iPadOS, documentar la limitación; no diseñar una función basada en una lectura que la app no puede obtener.

## Etapa 5 — Calidad de control

Para cada control continuo:
- Identificar resolución efectiva.
- Medir ruido y saltos.
- Probar suavizado, dead zone y curvas.
- Evitar cambios bruscos de ganancia o parámetros.
- Permitir calibración y guardar configuración por dispositivo.

Para jog wheels:
- Medir dirección, resolución y velocidad de eventos.
- Evaluar latencia y comportamiento al detener el movimiento.
- Diferenciar búsqueda/posición y pitch bend según el tipo de mensaje observado.

## Etapa 6 — Mapping y capas

La arquitectura debe permitir:
- Perfiles de mapping configurables, guardables y exportables.
- Asignación de controles a funciones aprobadas, FX y parámetros.
- Restauración segura de valores al cambiar de perfil.

La asignación de controles físicos debe basarse en los mensajes MIDI realmente observados.

## Criterio de aceptación

No declarar compatible la Hercules DJControl AIR hasta probar en el iPad:
1. Enumeración estable.
2. Recepción de mensajes de todos los controles necesarios.
3. Desconexión y reconexión.
4. Jog wheels para búsqueda/posición y pitch bend, si el protocolo lo permite.
5. Sensor AIR, si expone datos accesibles.
6. Ruteo de audio master/cue con la interfaz realmente utilizada.

## Seguridad y alcance

No comprar adaptadores ni hardware para esta fase sin autorización. No instalar perfiles o drivers de procedencia dudosa. Registrar resultados negativos y mantener separadas las conclusiones sobre MIDI estándar y sensor AIR.
