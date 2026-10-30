# DJ Studio para iPadOS — transferencia de continuidad para la siguiente instancia

> Documento de handoff para la instancia de ChatGPT que continuará el desarrollo en esta cuenta de GitHub. Leerlo antes de modificar código o ejecutar workflows.

## 1. Repositorio y estado confirmado

- Repositorio: https://github.com/caoscorpgroup/DJ-Studio-iPadOS
- Rama de trabajo con la base anterior: `docs/swift6-technical-foundation`
- Rama principal: `main` (no trabajar directamente sobre ella).
- La rama de trabajo ya contiene un paquete Swift 6 y una base inicial de biblioteca local.
- No existe todavía un target completo de aplicación iPadOS, un motor de audio DJ implementado ni validación física en el iPad/controladora.

Empieza inspeccionando el historial, los archivos y las pruebas de esa rama. No asumas que el README describe por sí solo todo el estado real.

## 2. Misión de la instancia receptora

Continúa el mismo proyecto y las decisiones del usuario. No lo reinicies, no sustituyas la arquitectura sin justificación y no vuelvas a preguntar requisitos que ya están definidos aquí.

El usuario no quiere programar personalmente. La instancia receptora debe implementar, probar, documentar los cambios y explicar el estado en términos claros.

La instancia receptora es responsable de la continuación técnica y de los workflows desde esta cuenta. Esta transferencia no autoriza gastos, suscripciones, servicios de pago ni cambios destructivos.

## 3. Producto aprobado

Aplicación DJ nativa para iPad, enfocada en archivos musicales locales, mezcla estable, análisis musical y control táctil/MIDI. La interfaz debe ser oscura, profesional y clara, sin saturar la pantalla.

### Primera versión: dos decks A/B

- Dos decks independientes y un mixer central de dos canales.
- Play/Pause/Cue.
- Crossfader y volumen independiente por canal.
- EQ de tres bandas y Gain.
- Pitch faders y BPM.
- SYNC que use BPM y beatgrid.
- Hot Cues básicos y loops manuales/automáticos.
- Waveforms y posición de reproducción.
- Preescucha/Cue separada del master, si el dispositivo de audio ofrece canales suficientes.
- Biblioteca local con selector de carpetas, permisos persistentes y metadatos.
- Análisis local de BPM, tonalidad, Camelot y beatgrid.
- FX Studio modular, con efectos y parámetros ajustables en tiempo real.
- Filtros Low-Pass y High-Pass.
- Mapping Core MIDI y evaluación de la Hercules DJControl AIR original.
- Evaluación del sensor AIR como fuente de control MIDI/continuo.

### Jog: Pitch Bend, no scratch

El jog solo hará Pitch Bend/Nudge:
- Giro hacia delante: aceleración temporal.
- Giro hacia atrás: ralentización temporal.
- Al soltar: retorno a la velocidad/BPM fijados por el pitch fader.
- No invierte el audio, no detiene la pista y no modifica permanentemente el pitch.

**Scratch queda expresamente descartado.** No implementarlo, ni como modo opcional ni como función oculta. Reverse tampoco está aprobado para el MVP.

### Fuera del alcance inicial

- Cuatro decks.
- Streaming o nube obligatoria.
- Grabación de mezclas.
- Integraciones externas obligatorias.
- Funciones avanzadas de performance no aprobadas.
- Servicios/API de IA.

No reincorporar funciones descartadas por iniciativa propia. Cualquier ampliación de alcance requiere aprobación del usuario.

## 4. Orden de desarrollo acordado

1. Biblioteca, selector de carpetas, permisos persistentes y metadatos.
2. Motor de audio y dos decks.
3. Mixer, EQ y controles de reproducción.
4. BPM, tonalidad y beatgrid.
5. SYNC, pitch y Pitch Bend.
6. FX Studio y filtros.
7. MIDI/Hercules.
8. Sensor AIR, pruebas y optimización.

La biblioteca inicial ya tiene código, pero sigue pendiente compilarla, integrarla en un target de app y validarla con archivos reales en iPadOS.

## 5. Base de código ya existente

Inspeccionar antes de reescribir. En la rama indicada ya se añadieron, entre otros:

- `Package.swift`: paquete Swift tools 6.0, targets `DJStudioCore` y `DJStudioCoreTests`.
- `Sources/DJStudioCore/Track.swift`: modelos de pista, metadatos y análisis.
- `MP3ID3Reader.swift`: lector local ID3v2.2/v2.3/v2.4 e ID3v1.
- `LocalFolderImporter.swift`: enumeración recursiva de formatos de audio.
- `LocalLibraryStore.swift`: catálogo JSON con escritura atómica.
- `LocalLibraryScanner.swift`: conexión entre importación, metadatos, análisis opcional y persistencia.
- `MusicFolderBookmarkStore.swift`: persistencia y resolución de bookmarks.
- `SystemAudioMetadataReader.swift`: AVFoundation y fallback ID3 para MP3.
- `MusicLibraryView.swift`: vista SwiftUI inicial de biblioteca.
- `LibraryInterfaces.swift`: contratos para lectura local y análisis offline.
- `CompatibilityEngine.swift`: comparador inicial de compatibilidad armónica/BPM/energía.
- Tests iniciales de compatibilidad, ID3, importación, almacenamiento y escaneo.

El README de la rama de trabajo describe más detalles. La implementación existente no equivale a una app terminada: aún no hay target Xcode completo, motor de audio, compilación validada ni prueba física en iPadOS.

## 6. Arquitectura y tecnologías

- Swift 6 como lenguaje principal.
- SwiftUI para interfaz.
- AVFAudio/AVAudioEngine como primera ruta de prototipo para reproducción, mezcla y procesamiento; comparar con Core Audio de menor nivel si las mediciones lo justifican.
- Core MIDI para controladoras.
- Accelerate/vDSP para FFT, filtros y operaciones DSP cuando aporten valor.
- C++/Objective-C++ solo para módulos concretos si benchmarks y auditoría de licencia lo justifican.

Separar el motor de audio de SwiftUI. El callback de audio no debe realizar I/O de disco/red, análisis musical, esperas bloqueantes, asignaciones impredecibles ni actualizaciones de UI. Decodificación, lectura, análisis y generación de waveforms deben ejecutarse fuera del hilo de audio.

La elección final del motor, el ruteo master/cue, la base de datos y el framework de análisis siguen pendientes de prototipos y pruebas.

## 7. Referencias técnicas ya identificadas

No repetir la búsqueda desde cero. Revisa las referencias y los resultados de la auditoría existente:

### Mixxx
https://github.com/mixxxdj/mixxx

Referencia de arquitectura DJ, decks, mixer, efectos y mappings. La auditoría existente identifica GPL-2.0-or-later como licencia investigada inicialmente. Tratarlo como referencia técnica; no copiar ni adaptar código sin revisión legal/licencia específica.

Manual/mapping de Hercules DJControl AIR:
https://github.com/mixxxdj/manual/blob/master/source/hardware/controllers/hercules_djcontrol_air.rst

### Essentia
https://github.com/MTG/essentia

Candidata para análisis de ritmo, tempo, características espectrales y tonalidad. Verificar licencia actual, dependencias, portabilidad iOS, tamaño y rendimiento antes de integrarla.

### KeyFinder
https://github.com/ibsh/is_KeyFinder

Candidato para investigar detección de tonalidad. Revisar mantenimiento, licencia, API, dependencias, precisión y viabilidad iOS.

### Mappings Hercules localizados previamente

- https://github.com/leonardogrimaldi/Hercules-DJControl-AIR-Mixxx-Mapping
- https://github.com/DJPhatso/Hercules-DJControl-AIR-Mixxx-Mapping
- https://github.com/erwanosouf/hercules-djcontrol-airs-controller-mapping

Son pistas de investigación, no mappings validados. Comprobar accesibilidad y que correspondan al modelo AIR original.

### Referencias de producto/interfaz

- DJUCED App: https://apps.apple.com/mx/app/djuced-app/id686434886
- edjing Mix se mencionó como referencia de facilidad de uso, navegación y flujo de mezcla. No copiar código, identidad ni recursos propietarios.

### Documentos internos que deben leerse

- `docs/OPEN_SOURCE_AUDIT.md`
- `docs/HARDWARE_COMPATIBILITY.md`
- `docs/ARCHITECTURE.md`
- `docs/PRODUCT_SPEC.md`
- `docs/ROADMAP.md`
- `docs/DECISIONS.md`

No duplicar investigaciones. Actualizar estos documentos cuando se confirmen nuevos hallazgos.

## 8. Contradicciones conocidas y estado de corrección

**Revisión del 2026-10-30:** las contradicciones enumeradas abajo ya fueron corregidas en la rama `docs/swift6-technical-foundation`:

- `docs/PRODUCT_SPEC.md`: eliminadas de las funciones activas del MVP Scratch, Reverse, Slip, Roll, Beat Jump, Quantize y sampler; grabación queda fuera de la primera versión.
- `docs/ROADMAP.md`: retiradas pruebas de scratch y funciones avanzadas de performance no aprobadas; se mantienen Hot Cues básicos y loops.
- `docs/ARCHITECTURE.md`: retirado Reverse y la progresión a decks adicionales; arquitectura limitada a dos decks A/B.
- `docs/DECISIONS.md`: alcance A/B y exclusiones registrados como decisión vigente.
- `docs/HARDWARE_COMPATIBILITY.md` y `docs/MIDI_HARDWARE_VALIDATION.md`: validación de jog limitada a búsqueda/posición y Pitch Bend, sin scratch ni capas para decks adicionales.
- `docs/AUDIO_POC_SPEC.md`, `docs/IMPLEMENTATION_PLAN.md` y `docs/FX_STUDIO_SPEC.md`: retiradas referencias a funciones no aprobadas dentro del trabajo activo.

Mantener diferenciadas las funciones aprobadas, las propuestas y las pendientes de validación. No reincorporar funciones excluidas sin aprobación explícita del usuario.

No marcar una función como completada solo porque exista una descripción o una interfaz visual.

## 9. Hercules DJControl AIR original

El usuario tiene el modelo **Hercules DJControl AIR original**, no AIR+ ni Inpulse.

Investigar y validar:
- Enumeración USB/MIDI en iPadOS.
- Mensajes reales de botones, knobs, faders y jogs.
- Resolución y dirección del jog para Pitch Bend.
- Posible dato MIDI/protocolo del sensor AIR y asignación a FX/filtro/parámetros.
- Audio, salidas disponibles y posibilidad real de separar master/cue.
- Adaptador/hub y alimentación utilizados.

La compatibilidad con Mixxx en escritorio no demuestra compatibilidad con iPadOS. No declarar compatibilidad completa hasta probar el hardware real con el iPad A16.

## 10. Workflows, GitHub y costes

La cuenta/repo receptor es la cuenta nueva que el usuario ha destinado a continuar este proyecto. La instancia receptora puede preparar y ejecutar workflows desde esa cuenta, pero debe revisar primero los límites, permisos, minutos disponibles, tipo de runner y posibles cargos de esa cuenta.

- No modificar `main` directamente.
- Crear o usar una rama de trabajo separada.
- No ejecutar workflows en la cuenta/repositorio anterior.
- No contratar runners, servicios, APIs ni suscripciones.
- No generar gastos ni consumir créditos de pago sin autorización explícita.
- No asumir que los workflows del proyecto anterior son adecuados para iOS: estudiar sus archivos YAML y reutilizar solo lo compatible.
- Antes de activar Actions, explicar qué workflow se ejecutará, qué runner utiliza y si puede consumir cuota o generar cargos.
- Proteger certificados, perfiles y secretos; nunca imprimirlos en logs.
- No hacer operaciones destructivas ni sobrescribir trabajo sin revisar el historial.
- Documentar ejecuciones, commits, artefactos y fallos.

El usuario indicó que el desarrollo y las ejecuciones de workflows continuarán desde esta nueva cuenta limpia. La fecha de revisión del 1 de noviembre correspondía a la cuenta anterior; no es un bloqueo automático para la nueva cuenta. Aun así, se deben verificar sus propias cuotas y costes antes de ejecutar.

## 11. Criterios de calidad y aceptación

- Dos pistas locales deben reproducirse y mezclarse de forma estable.
- Biblioteca y permisos deben sobrevivir al cierre/reapertura de la app.
- La UI no debe interrumpir el audio.
- SYNC debe apoyarse en BPM y beatgrid medibles y corregibles.
- Pitch Bend debe ser temporal y no cambiar el pitch permanente.
- FX y filtros deben evitar clicks y controlar el consumo de CPU.
- MIDI y sensor AIR deben validarse con la controladora real.
- Medir latencia, dropouts, memoria, CPU, temperatura y sesiones prolongadas.
- Mantener resultados de análisis con confianza/estimación y corrección manual.

## 12. Forma de trabajo y comunicación

En cada etapa:
1. Inspecciona antes de modificar.
2. Resume brevemente el estado real y los riesgos.
3. Implementa cambios pequeños en una rama separada.
4. Ejecuta solo pruebas/workflows previamente revisados por coste.
5. Comprueba los resultados; no afirmes éxito sin evidencia.
6. Actualiza README, roadmap y decisiones.
7. Informa al usuario qué cambió, qué falta y qué requiere prueba física.

El usuario aprueba las decisiones finales de producto. Si una decisión técnica implica cambiar el alcance, generar costes o descartar trabajo existente, consulta antes.

**Principio rector:** continuar y mejorar el trabajo ya realizado; no reiniciar, no duplicar investigación y no reintroducir funciones que el usuario descartó.


### Estado de automatización actualizado — 2026-10-30

- Se creó `.github/workflows/djstudio-core-validation.yml` en esta rama.
- Solo admite ejecución manual (`workflow_dispatch`); utiliza un único runner `macos-15`, timeout de 10 minutos, permiso `contents: read` y ejecuta `swift test --parallel`.
- No se ha ejecutado. La cuota, el presupuesto/hard stop y el permiso específico de Actions de la cuenta siguen sin verificarse; no iniciar el workflow hasta confirmar que no habrá cargos no autorizados.
- Su alcance es validar el paquete Swift en macOS. No compila un target iPadOS ni demuestra que exista una app instalable.
- Ver `docs/BUILD_AND_TEST_PIPELINE.md`, `docs/GITHUB_ACTIONS_COST_RESEARCH.md` y `docs/CONTINUITY_LOG.md` para el detalle y las condiciones de ejecución.
