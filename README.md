# DJ Studio for iPadOS

Proyecto de aplicación DJ nativa para iPad, orientada a mezcla local, baja latencia, controladoras MIDI y una interfaz profesional configurable.

> Estado: fase de definición y auditoría técnica. Todavía no existe un motor de audio implementado ni compatibilidad de hardware validada.

## Objetivos principales

- Reproducir y mezclar archivos de audio locales.
- Diseñar una interfaz profesional, configurable y usable en iPad.
- Mantener dos decks (A/B) como alcance inicial; cuatro decks quedan para una posible fase futura.
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

Se ha iniciado un paquete Swift independiente, `DJStudioCore`, como primera base de código. Incluye modelos de pistas/análisis, interfaces para lectura de metadatos y análisis local, y un primer comparador explicable de compatibilidad armónica, BPM y energía. Es una base de dominio, no todavía una aplicación iPadOS instalable ni un motor de audio.

## Base de código

- `Package.swift`: paquete Swift 6.
- `Sources/DJStudioCore/Track.swift`: modelos de pista, metadatos ID3, bookmarks y análisis.
- `Sources/DJStudioCore/MP3ID3Reader.swift`: lector local de ID3v2.2/v2.3/v2.4 e ID3v1; lee solo los bytes de etiquetas.
- `Sources/DJStudioCore/LocalFolderImporter.swift`: enumeración recursiva de formatos de audio locales.
- `Sources/DJStudioCore/LocalLibraryStore.swift`: catálogo JSON local con escritura atómica.
- `Sources/DJStudioCore/LocalLibraryScanner.swift`: conexión de importación, lectura de metadatos, análisis opcional y persistencia.
- `Sources/DJStudioCore/LibraryInterfaces.swift`: contratos para lectura local y análisis offline; enriquecimiento externo opcional.
- `Sources/DJStudioCore/CompatibilityEngine.swift`: primera clasificación transparente de compatibilidad.
- `Tests/DJStudioCoreTests/CompatibilityEngineTests.swift`: pruebas unitarias iniciales.

La primera versión del producto está centrada en dos decks. La biblioteca local no depende de servicios de streaming ni servidores externos. La app iPadOS deberá gestionar los permisos y bookmarks de carpetas seleccionadas por el usuario. No se han ejecutado workflows de GitHub Actions ni compilaciones remotas. La base todavía requiere validación con Swift/Xcode y pruebas en el iPad objetivo.
