# Registro de continuidad

## 2026-10-30 — Reanudación desde otra instancia

### Identidad y alcance
- Repositorio: `caoscorpgroup/DJ-Studio-iPadOS`.
- Rama de trabajo: `docs/swift6-technical-foundation`.
- PR de revisión: #1, con destino a `main`; permanece abierta y no se ha fusionado.
- Este repositorio corresponde exclusivamente a DJ Studio para iPadOS.
- Alcance aprobado: dos decks A/B y dos canales. No diseñar ni implementar decks adicionales sin aprobación explícita.
- Exclusiones del MVP: Scratch, Reverse, Slip, Roll, Beat Jump, Quantize, sampler y funciones avanzadas de performance no aprobadas.
- Grabación de mezclas queda fuera de la primera versión.
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

### Estado técnico confirmado
- No hay todavía un target completo de aplicación Xcode/iPadOS.
- No hay motor de audio ni transporte/decks funcionales.
- No se han validado latencia, ruteo master/cue, interrupciones, MIDI ni Hercules DJControl AIR original en hardware real.
- La biblioteca y sus pruebas iniciales siguen pendientes de compilación/ejecución en un entorno Apple y validación en el iPad A16.
- El paquete y el código inicial no deben presentarse como una aplicación terminada.

### Correcciones documentales de esta continuidad
Se reconciliaron README y documentos de arquitectura, producto, decisiones, implementación, roadmap y validación de hardware para eliminar supuestos heredados sobre scratch y decks adicionales. La decisión vigente queda registrada en `docs/DECISIONS.md`. También se corrigió la descripción del estado en `docs/GITHUB_ACTIONS_COST_RESEARCH.md`.

### Acceso y CI
- La lectura de la rama y de la PR #1 fue confirmada.
- La escritura en la rama `docs/swift6-technical-foundation` fue confirmada mediante commits documentales; no se escribió en `main`.
- La consulta de ejecuciones asociadas al HEAD actual (`4772693abd0ff969ba6be53dad0286919323a22d`) devolvió cero ejecuciones.
- No se ejecutó ningún workflow.
- No se pudo verificar desde esta instancia la facturación, cuota restante, presupuesto de Actions ni permisos específicos de Actions de la cuenta. Por tanto, no iniciar runners hasta que esos límites puedan comprobarse.
- El entorno local disponible para esta revisión es Linux x86_64 con Swift 6.2.1 y sin `xcodebuild`; no permite validar los frameworks ni la compilación nativa iPadOS.

### Siguiente orden de trabajo
1. Completar auditoría de código y pruebas existentes, conservando los componentes correctos.
2. Cerrar la prueba técnica mínima de compilación/ejecución en un entorno Apple autorizado y sin gasto no aprobado.
3. Crear el target mínimo de aplicación iPadOS y conectar la biblioteca existente sin duplicar su lógica.
4. Implementar el Audio POC según `docs/AUDIO_POC_SPEC.md`: archivo local, play/pause/stop/seek y diagnóstico.
5. Medir y documentar audio, rutas e interrupciones en el iPad A16 antes de iniciar mixer/decks.
6. Validar MIDI y la Hercules DJControl AIR original con el hardware y adaptador reales.
7. Avanzar a los dos decks A/B y mixer solo después de superar las puertas de validación anteriores.

Las tareas no se marcarán como completadas sin evidencia reproducible. Las decisiones del usuario prevalecen sobre propuestas técnicas previas.
