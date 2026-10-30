# Registro de continuidad

## 2026-10-30 — Reanudación desde otra instancia

### Identidad y alcance
- Repositorio: `caoscorpgroup/DJ-Studio-iPadOS`.
- Rama de trabajo: `docs/swift6-technical-foundation`.
- PR de revisión: #1, con destino a `main`; permanece abierta y no se ha fusionado.
- Este repositorio corresponde exclusivamente a DJ Studio para iPadOS.
- Alcance aprobado: dos decks A/B y dos canales. No diseñar ni implementar decks adicionales sin aprobación explícita.
- Funciones aprobadas de la primera versión según `docs/AI_HANDOFF.md`: dos decks A/B y mixer de dos canales; Play/Pause/Cue; crossfader y volumen por canal; EQ de tres bandas y gain; pitch faders/BPM y SYNC basado en BPM/beatgrid; Hot Cues básicos y loops manuales/automáticos; waveforms y posición; preescucha separada si el hardware ofrece canales; biblioteca local; análisis local de BPM, tonalidad, Camelot y beatgrid; FX Studio modular y filtros Low-Pass/High-Pass; Core MIDI y evaluación de la Hercules DJControl AIR original/sensor AIR.
- Exclusiones del MVP: Scratch, Reverse, Slip, Roll, Beat Jump, Quantize, sampler y funciones avanzadas de performance no aprobadas.
- Grabación de mezclas queda fuera de la primera versión; streaming/nube obligatoria, integraciones externas obligatorias y servicios de IA tampoco forman parte del alcance inicial.
- Jog limitado a búsqueda/posición y Pitch Bend temporal; al soltar, vuelve al valor fijado por el pitch fader.
- No modificar `main`, no fusionar la PR ni ejecutar workflows sin autorización y verificación previa de permisos, cuota y costes.

### Base existente recuperada
- Paquete Swift 6 `DJStudioCore` en `Package.swift`.
- Modelos de pista, metadatos y análisis en `Track.swift`.
- Lectura ID3v2.2/v2.3/v2.4 e ID3v1 para MP3.
- Enumeración recursiva de archivos locales y catálogo JSON con persistencia atómica.
- Escáner de biblioteca con lector de metadatos y analizador opcional.
- Bookmarks de carpetas y vista SwiftUI inicial de biblioteca para iOS.
- Lector AVFoundation para metadatos comunes y duración, con fallback ID3 para MP3.
- Comparador inicial de compatibilidad por tonalidad Camelot, BPM y energía.
- Seis archivos de pruebas unitarias iniciales: compatibilidad, importador, escáner, almacenamiento y parser ID3 (incluida fixture temporal).
- La selección de pista para Deck A/B solo prepara la pista; no carga ni reproduce audio.

### Auditoría estática del código (pendiente de corrección y pruebas)
- `MP3ID3Reader` no salta correctamente una cabecera extendida ID3v2.3 antes de recorrer frames.
- La máscara de flags de formato de frame solo comprueba bits 0x0C; para ID3v2.3 los flags de compresión/cifrado usan 0x80/0x40. Requiere corrección y pruebas para v2.3/v2.4.
- La cobertura ID3 actual se concentra en un caso v2.3. La fixture temporal contiene bytes ID3 válidos y un payload parecido a MPEG, pero no es una grabación MP3 completa ni decodificable.
- `CompatibilityEngine` solo interpreta claves Camelot; el fallback `TrackMetadata.musicalKey` puede contener notación musical ID3 convencional (por ejemplo, Am) y entonces no produce puntuación armónica.
- `MusicLibraryView.scanURL`: la enumeración recursiva se movió a `Task.detached(priority: .utility)` en el commit `51da5715695f10accd5ce1ac16b8b5d825096ba3` para evitar bloquear `MainActor`; compilación y prueba todavía pendientes.
- No hay pruebas específicas para bookmarks, integración AVFoundation ni la vista SwiftUI; el catálogo tampoco tiene cobertura para JSON corrupto o IDs duplicados.
- Estos son hallazgos de revisión estática, no fallos reproducidos en ejecución. No se ha afirmado que estén corregidos.

### Estado técnico confirmado
- No hay todavía un target completo de aplicación Xcode/iPadOS.
- No hay motor de audio ni transporte/decks funcionales.
- No se han validado latencia, ruteo master/cue, interrupciones, MIDI ni Hercules DJControl AIR original en hardware real.
- La biblioteca y sus pruebas iniciales siguen pendientes de compilación/ejecución en un entorno Apple y validación en el iPad A16.
- El paquete y el código inicial no deben presentarse como una aplicación terminada.

### Correcciones documentales de esta continuidad
Se reconciliaron README y documentos de arquitectura, producto, decisiones, implementación, roadmap, Audio POC, FX Studio y validación MIDI/hardware para alinear el MVP con `docs/AI_HANDOFF.md`. Se corrigió en código la enumeración de carpetas desde `MainActor`, pendiente de compilación/prueba. Se retiraron del alcance activo Reverse, Scratch, Slip, Roll, Beat Jump, Quantize, sampler, capas para decks adicionales y grabación de mezclas. La decisión vigente queda registrada en `docs/DECISIONS.md`. También se corrigió la descripción del estado y los límites no verificados de Actions en `docs/GITHUB_ACTIONS_COST_RESEARCH.md`.

### Acceso y CI
- La lectura de la rama y de la PR #1 fue confirmada.
- La escritura en la rama `docs/swift6-technical-foundation` fue confirmada mediante commits documentales; no se escribió en `main`.
- La consulta de ejecuciones asociadas al HEAD revisado (`e9c6db144c1595fd158fdbfc51610eb7031d82a5`) devolvió cero ejecuciones. La lista de archivos modificados de la PR no contiene workflows; los permisos de Actions y el árbol completo de workflows no se han podido verificar.
- No se ejecutó ningún workflow.
- No se pudo verificar desde esta instancia la facturación, cuota restante, presupuesto de Actions ni permisos específicos de Actions de la cuenta. Por tanto, no iniciar runners hasta que esos límites puedan comprobarse.
- El entorno local disponible para esta revisión es Linux x86_64 con Swift 6.2.1 y sin `xcodebuild`; no permite validar los frameworks ni la compilación nativa iPadOS.

### Siguiente orden de trabajo
1. Resolver los hallazgos de la auditoría estática del parser ID3, comparador de tonalidad y pruebas de biblioteca; compilar y ejecutar las pruebas en un entorno Apple autorizado.
2. Cerrar la prueba técnica mínima de compilación/ejecución en un entorno Apple autorizado y sin gasto no aprobado.
3. Crear el target mínimo de aplicación iPadOS y conectar la biblioteca existente sin duplicar su lógica.
4. Implementar el Audio POC según `docs/AUDIO_POC_SPEC.md`: archivo local, play/pause/stop/seek y diagnóstico.
5. Medir y documentar audio, rutas e interrupciones en el iPad A16 antes de iniciar mixer/decks.
6. Validar MIDI y la Hercules DJControl AIR original con el hardware y adaptador reales.
7. Avanzar a los dos decks A/B y mixer solo después de superar las puertas de validación anteriores.

Las tareas no se marcarán como completadas sin evidencia reproducible. Las decisiones del usuario prevalecen sobre propuestas técnicas previas.


## 2026-10-30 — Continuación: primer workflow controlado

### Estado GitHub confirmado
- PR #1: abierta, no fusionada, destino `main`; HEAD observado: `cd266d15ae9992d734c7e3bcc9a3b2a577123103`.
- Comparación de rama: 100 commits por delante de `main`, 0 por detrás.
- La cuenta conectada tiene permiso de colaborador `write` en el repositorio. No se ha confirmado permiso específico de Actions ni acceso a controles de facturación.
- Los archivos cambiados de PR #1 no incluyen workflows. La consulta de `.github/workflows` en la rama devolvió 404 antes de crear el primer archivo.

### Cambio realizado
- Creado `.github/workflows/djstudio-core-validation.yml`.
- Workflow manual únicamente (`workflow_dispatch`), runner `macos-15`, un job, timeout de 10 minutos, `contents: read`, checkout fijado a SHA y ejecución de `swift test --parallel`.
- Sin triggers automáticos, matriz, artefactos, firma, publicación ni secretos.
- Actualizados `docs/BUILD_AND_TEST_PIPELINE.md` y `docs/GITHUB_ACTIONS_COST_RESEARCH.md` para documentar su alcance y límites.

### Validación y restricciones
- Los cambios se escribieron en esta rama; no se modificó `main` ni se fusionó PR #1.
- El workflow **no se ejecutó**. No se ha consumido cómputo de GitHub Actions por esta configuración.
- Cuota, presupuesto, hard stop y permiso específico de Actions siguen sin verificarse; no despachar el workflow hasta comprobarlos.
- El job valida el paquete Swift en macOS, no una app iPadOS instalable. El target de aplicación y el motor de audio siguen sin existir.
- Próximo paso técnico: inspeccionar y corregir el parser ID3 y el fallback de tonalidad, añadir pruebas de regresión y preparar una validación ejecutable cuando el entorno Apple y los costes estén autorizados.
