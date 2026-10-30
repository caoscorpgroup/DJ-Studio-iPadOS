# Compatibilidad de hardware

## Controladora prioritaria

**Hercules DJControl AIR original.** No confundir con DJControl AIR+ ni con modelos Inpulse.

La prioridad es determinar qué funciones expone realmente el dispositivo a iPadOS. La compatibilidad de una controladora con Mixxx en escritorio no demuestra compatibilidad idéntica en iPadOS.

## Elementos que deben validarse

| Elemento | Qué comprobar |
|---|---|
| USB | Enumeración, alimentación y estabilidad con el hub/adaptador usado |
| MIDI | Mensajes enviados por cada botón, knob y fader |
| Jog wheels | Resolución, dirección, velocidad y comportamiento táctil |

| Sensor AIR | Si los datos del sensor están expuestos como MIDI u otro protocolo accesible |
| Audio | Dispositivo de salida, número de canales y formatos |
| Master/Cue | Posibilidad real de separar canales de mezcla y preescucha |
| Feedback | LEDs y otros indicadores controlables desde iPadOS |

## Plan de validación

1. Registrar el modelo exacto y revisión de hardware de la etiqueta.
2. Registrar modelo de adaptador/hub y fuente de alimentación.
3. Conectar y comprobar si iPadOS enumera el dispositivo.
4. Capturar mensajes MIDI sin reproducir audio.
5. Crear una tabla de control → mensaje → acción.
6. Verificar salidas de audio y canales con señales de prueba.
7. Repetir tras desconexión, reconexión y suspensión.

## Limitaciones conocidas

- No se ha probado físicamente la DJControl AIR en este proyecto.
- El sensor AIR no debe considerarse compatible hasta capturar y entender su señal.
- No se debe asumir que el mapeo publicado para Mixxx se puede importar directamente.
- La cantidad de controles físicos y los mensajes que expone la controladora deben comprobarse directamente; no se presumirá ninguna función no validada.
- La preescucha independiente requiere que el dispositivo de audio exponga salidas suficientes.

## Datos pendientes del equipo real

- Versión exacta de iPadOS.
- Modelo de hub/adaptador USB y alimentación.
- Si la Hercules aparece en Ajustes/Audio o en alguna app MIDI del iPad.
- Si el audio se obtiene desde la propia controladora o desde una interfaz aparte.
