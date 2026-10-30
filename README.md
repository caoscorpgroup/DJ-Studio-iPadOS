# DJ Studio for iPadOS

Proyecto de aplicación DJ nativa para iPad, orientada a mezcla local, baja latencia, controladoras MIDI y una interfaz profesional configurable.

> Estado: fase de definición y auditoría técnica. Todavía no existe un motor de audio implementado ni compatibilidad de hardware validada.

## Objetivos principales

- Reproducir y mezclar archivos de audio locales.
- Ofrecer dos decks como vista predeterminada y una opción de cuatro decks.
- Diseñar una interfaz profesional, configurable y usable en iPad.
- Priorizar compatibilidad con la **Hercules DJControl AIR original**.
- Permitir una arquitectura de mappings extensible para otras controladoras.
- Separar el motor de audio de la interfaz para proteger la continuidad de reproducción.
- Mantener funciones esenciales disponibles sin conexión y sin suscripción.

## Documentación

- [Especificación del producto](docs/PRODUCT_SPEC.md)
- [Arquitectura técnica propuesta](docs/ARCHITECTURE.md)
- [Hoja de ruta](docs/ROADMAP.md)
- [Compatibilidad de hardware](docs/HARDWARE_COMPATIBILITY.md)
- [Auditoría inicial de código abierto](docs/OPEN_SOURCE_AUDIT.md)
- [Decisiones del proyecto](docs/DECISIONS.md)

## Principios

1. Estabilidad de audio antes que cantidad de funciones.
2. Desarrollo modular y pruebas por etapas.
3. No asumir compatibilidad sin pruebas en el iPad y la controladora reales.
4. Revisar licencias antes de copiar, adaptar o distribuir código.
5. Sin servicios de pago, APIs de pago ni suscripciones sin autorización explícita.
6. No modificar la rama principal con cambios experimentales sin revisar su impacto.

## Plataforma y tecnología

Propuesta inicial: Swift, SwiftUI, Core Audio, Core MIDI y Accelerate; C++/Objective-C++ únicamente donde aporten valor medible para DSP o reutilización de algoritmos. La selección definitiva queda sujeta a prototipos y pruebas.

## Estado actual

Este repositorio contiene documentación de planificación. No representa todavía una aplicación funcional.
