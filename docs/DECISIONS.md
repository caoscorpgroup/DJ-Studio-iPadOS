# Registro de decisiones

Este documento recoge decisiones y supuestos del proyecto. Las decisiones nuevas deben añadirse con fecha y razón.

## 2026-10-29 — Producto y plataforma
- Nombre provisional: DJ Studio.
- Plataforma inicial: iPadOS.
- Archivos locales como fuente musical inicial.
- Alcance inicial: exclusivamente dos decks A/B.
- Interfaz oscura profesional y personalizable.

## 2026-10-29 — Hardware prioritario
- Controladora prioritaria: Hercules DJControl AIR original.
- No confundir con AIR+ ni Inpulse 500.
- La compatibilidad física y el sensor AIR siguen pendientes de prueba.

## 2026-10-29 — Política de costes
- Priorizar herramientas gratuitas y ejecución local.
- No contratar servicios, comprar APIs, activar suscripciones ni incurrir en gastos sin autorización explícita.

## 2026-10-29 — Seguridad de ramas
- El repositorio comienza privado.
- La rama principal se mantiene estable.
- Experimentos y cambios de riesgo se desarrollarán en ramas separadas y se revisarán antes de integrar.

## 2026-10-30 — Referencia visual y navegación
- edjing Mix se adopta como referencia de facilidad de uso, organización de pantallas y flujo de trabajo DJ; no se copiarán su código, identidad visual ni recursos propietarios.
- La pantalla principal usará dos decks como disposición predeterminada.
- La pantalla principal se diseñará exclusivamente para dos decks A/B y dos waveforms amplios.
- La navegación se organizará en cinco áreas: DJ principal, FX Studio, Biblioteca, Performance y Hardware/Mapping.
- La biblioteca deberá escanear música local y analizar BPM, tonalidad, beatgrid y waveform; también se estudiará una visualización de actividad rítmica/energética a lo largo de la pista.
- La interfaz mantendrá controles esenciales visibles y desplazará opciones avanzadas a paneles secundarios para evitar saturación.

## 2026-10-30 — Lenguaje y base tecnológica aprobados
- Swift 6 queda aprobado como lenguaje principal de DJ Studio.
- SwiftUI será la tecnología principal de presentación.
- AVFAudio/AVAudioEngine será la primera ruta a evaluar para el prototipo de audio; la elección definitiva frente a Core Audio de menor nivel queda condicionada a pruebas.
- Core MIDI será la base de comunicación con controladoras MIDI.
- Accelerate/vDSP se utilizará cuando sea útil para análisis y procesamiento de señales.
- C++/Objective-C++ no será una dependencia central; se permitirá para módulos DSP concretos únicamente si benchmarks y auditoría de licencia justifican su uso.
- La aplicación priorizará procesamiento local y herramientas gratuitas. No se autoriza ningún gasto, suscripción ni servicio de pago.
- El desarrollo debe considerar que el usuario no dispone de Mac local: se investigará Swift Playgrounds y compilación remota macOS, sin dar por resueltos firma, instalación ni depuración hasta probarlos.

## 2026-10-30 — Confirmación de alcance y exclusiones
- El producto se limita a dos decks (A/B); no se diseñarán ni implementarán decks adicionales sin una nueva aprobación explícita del usuario.
- Scratch queda fuera del alcance aprobado y no se añadirá a la hoja de ruta ni a las pruebas de hardware.
- Las decisiones explícitas del usuario prevalecen sobre propuestas o supuestos anteriores que contradigan este alcance.

## Exclusiones vigentes del MVP — 2026-10-30
- No implementar Scratch ni Reverse.
- No implementar Slip, Roll, Beat Jump, Quantize, sampler ni otras funciones avanzadas de performance que no hayan sido aprobadas.
- La grabación de mezclas queda fuera de la primera versión.
- La validación del jog se limita a búsqueda/posición y Pitch Bend temporal; al soltarlo debe regresar a la velocidad definida por el pitch fader.

## Pendiente de decisión o validación
- Versión mínima de iPadOS.
- Motor de audio definitivo y arquitectura de ruteo master/cue.
- Base de datos local.
- Framework de análisis musical después de auditoría de licencia y portabilidad.
- Compatibilidad real de la Hercules DJControl AIR original, incluido sensor AIR.
- Flujo reproducible de compilación, firma, instalación y depuración desde el entorno disponible.
- Política de distribución y publicación.
