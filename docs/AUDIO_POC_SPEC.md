# Especificación del prototipo de audio (Audio POC)

## Objetivo

Validar en el iPad A16 una ruta de audio nativa y reproducible antes de implementar decks, mixer, efectos o análisis musical.

## Hipótesis técnicas

- Swift 6 será el lenguaje de la aplicación.
- AVFAudio/AVAudioEngine será la primera tecnología evaluada.
- La sesión de audio y las rutas disponibles se inspeccionarán en tiempo de ejecución.
- La UI se comunicará con un controlador de reproducción; no ejecutará trabajo en el callback de audio.
- Si AVAudioEngine no ofrece el control o ruteo requerido, se documentará una evaluación de Core Audio de menor nivel antes de cambiar la arquitectura.

Estas son hipótesis de implementación, no afirmaciones de compatibilidad ya demostrada.

## Alcance funcional

### Incluido
- Pantalla de estado de audio.
- Selección de archivo local mediante API del sistema.
- Información del archivo: nombre, duración, sample rate y canales cuando estén disponibles.
- Play, pause, stop y seek.
- Indicador de progreso.
- Enumeración/observación de cambios de ruta cuando las API lo permitan.
- Registro de errores e interrupciones.
- Pruebas con archivos PCM/formatos comunes que el sistema pueda decodificar.

### Excluido
- Funcionalidad de decks y mixer DJ, que pertenece a fases posteriores.
- Pitch shifting y time-stretch.
- BPM, key, beatgrid y waveform detallado.
- EQ, crossfader y efectos.
- Grabación.
- Ruteo master/cue considerado terminado sin prueba física.

## Separación de componentes propuesta

- **AudioSessionCoordinator:** configura y observa la sesión y las interrupciones.
- **LocalAudioFileProvider:** obtiene acceso autorizado al archivo y mantiene el acceso mientras sea necesario.
- **PlaybackEngine:** encapsula AVAudioEngine/AVAudioPlayerNode o la alternativa seleccionada.
- **PlaybackState:** expone estado de reproducción y posición a la UI.
- **AudioDiagnostics:** recoge formato, ruta, errores y métricas.
- **AudioPOCView:** interfaz SwiftUI de diagnóstico; no contiene lógica de tiempo real.

Los nombres son propuestas para el prototipo y pueden cambiar durante la implementación.

## Reglas de tiempo real

- No realizar operaciones de disco, red, logging pesado ni análisis musical en el callback de audio.
- Evitar locks bloqueantes y asignaciones impredecibles en el camino de render.
- Preparar/decodificar audio fuera del callback cuando corresponda.
- Enviar a la UI únicamente actualizaciones de estado a una frecuencia razonable.
- Mantener la interfaz receptiva aunque la reproducción continúe.
- No asumir que una actualización de UI puede ejecutarse en el hilo de audio.

## Matriz de pruebas

| ID | Prueba | Resultado que se debe registrar |
|---|---|---|
| AUD-01 | Abrir archivo local | Éxito/error, formato y duración |
| AUD-02 | Play/pause repetido | Respuesta correcta, clicks o cortes |
| AUD-03 | Seek a inicio/mitad/final | Posición solicitada y real, artefactos |
| AUD-04 | Reproducción prolongada | Duración, interrupciones, memoria y errores |
| AUD-05 | Bloquear/desbloquear iPad | Recuperación y estado |
| AUD-06 | Interrupción del sistema | Evento recibido y política de reanudación |
| AUD-07 | Conectar/desconectar salida | Ruta anterior/nueva y recuperación |
| AUD-08 | Cambiar de app | Continuidad o pausa según política de sesión |
| AUD-09 | Archivos con distintos sample rates | Formato de entrada y salida, errores |
| AUD-10 | UI bajo interacción intensa | Ausencia de bloqueos del audio atribuibles a UI |

## Medidas y evidencia

Para cada ejecución:
- Modelo de iPad y versión exacta de iPadOS.
- Build/commit probado.
- Archivo de prueba (sin subir música con copyright al repositorio).
- Ruta de salida y hardware conectado.
- Duración de la prueba.
- Eventos, errores y observaciones auditivas.
- Métricas disponibles de CPU/memoria y cualquier dropout.
- Resultado: PASS, FAIL o BLOCKED, con explicación.

## Criterios de aceptación

El prototipo no se considerará aprobado hasta que:
1. Se instale y ejecute en el iPad físico.
2. Abra y reproduzca archivos locales autorizados.
3. Play, pause y seek funcionen repetidamente.
4. No existan bloqueos de UI ni fallos recurrentes de reproducción.
5. Se documenten interrupciones y cambios de ruta.
6. Se conozca qué rutas de salida ofrece el hardware probado.

La latencia se medirá y registrará; no se fijará una cifra objetivo arbitraria antes de conocer el hardware y método de medición.
