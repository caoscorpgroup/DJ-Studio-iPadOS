# Registro de decisiones

Este documento recoge decisiones y supuestos del proyecto. Las decisiones nuevas deben añadirse con fecha y razón.

## 2026-10-29 — Producto y plataforma
- Nombre provisional: DJ Studio.
- Plataforma inicial: iPadOS.
- Archivos locales como fuente musical inicial.
- Dos decks como vista predeterminada; cuatro decks como modo opcional.
- Interfaz oscura profesional y personalizable.

## 2026-10-29 — Hardware prioritario
- Controladora prioritaria: Hercules DJControl AIR original.
- No confundir con AIR+ ni Inpulse 500.
- La compatibilidad física y el sensor AIR siguen pendientes de prueba.

## 2026-10-29 — Arquitectura
- App nativa con Swift/SwiftUI.
- Core Audio y Core MIDI como tecnologías principales a evaluar.
- C++ solo para DSP/algoritmos donde aporte valor.
- Separación estricta entre UI y motor de audio.
- No usar Python como motor de audio de producción.

## 2026-10-29 — Política de costes
- Priorizar herramientas gratuitas y ejecución local.
- No contratar servicios, comprar APIs, activar suscripciones ni incurrir en gastos sin autorización explícita.

## 2026-10-29 — Seguridad de ramas
- El repositorio comienza privado.
- La rama principal se mantiene estable.
- Experimentos y cambios de riesgo se desarrollarán en ramas separadas y se revisarán antes de integrar.

## Pendiente de decisión
- Versión mínima de iPadOS.
- Estrategia definitiva de motor de audio (Core Audio de bajo nivel frente a AVAudioEngine u otra combinación).
- Base de datos local.
- Framework de análisis musical después de auditoría.
- Política de distribución y publicación.
## 2026-10-30 — Referencia visual y navegación
- edjing Mix se adopta como referencia de facilidad de uso, organización de pantallas y flujo de trabajo DJ; no se copiarán su código, identidad visual ni recursos propietarios.
- La pantalla principal usará dos decks como disposición predeterminada.
- Cuatro decks serán un modo de estudio opcional, solo cuando los cuatro waveforms y controles sigan siendo legibles.
- La navegación se organizará en cinco áreas: DJ principal, FX Studio, Biblioteca, Performance y Hardware/Mapping.
- La biblioteca deberá escanear música local y analizar BPM, tonalidad, beatgrid y waveform; también se estudiará una visualización de actividad rítmica/energética a lo largo de la pista.
- La interfaz mantendrá controles esenciales visibles y desplazará opciones avanzadas a paneles secundarios para evitar saturación.

## Próxima sesión — lenguaje y base tecnológica
- Revisar y decidir el lenguaje y las tecnologías de implementación para iPadOS.
- Comparar Swift/SwiftUI, Core Audio, Core MIDI y las opciones de motor de audio con criterios de latencia, estabilidad, compatibilidad con iPadOS, mantenimiento y posibilidad de compilar sin un Mac local.
- No cerrar la elección del motor de audio ni iniciar una implementación amplia hasta documentar las ventajas, limitaciones y una prueba técnica mínima.
