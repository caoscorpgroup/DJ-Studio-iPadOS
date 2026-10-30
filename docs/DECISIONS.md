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
