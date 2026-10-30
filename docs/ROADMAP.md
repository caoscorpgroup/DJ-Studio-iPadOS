# Hoja de ruta

Las etapas son secuenciales y sus fechas se definirán después de comprobar herramientas, licencias y disponibilidad de hardware.

## Fase 0 — Definición y auditoría
- [x] Crear repositorio privado.
- [x] Registrar visión y requisitos iniciales.
- [x] Aprobar Swift 6 como lenguaje principal.
- [ ] Confirmar versión de iPadOS y adaptador/hub de la controladora.
- [ ] Auditar licencias y portabilidad de proyectos candidatos.
- [ ] Separar funciones imprescindibles de funciones posteriores.
- [ ] Validar un flujo de desarrollo viable desde iPad, incluida compilación remota, firma e instalación.

## Fase 1 — Prueba técnica de audio
- [ ] Crear proyecto mínimo nativo iPadOS en Swift.
- [ ] Configurar un flujo de compilación reproducible con runner macOS remoto, si resulta viable sin coste.
- [ ] Abrir archivo local y reproducirlo.
- [ ] Medir latencia y estabilidad.
- [ ] Probar salida master y salida cue multicanal.
- [ ] Verificar interrupciones y cambios de ruta.
- [ ] Instalar y probar la compilación en el iPad A16.

Puerta de salida: reproducción estable, instalación reproducible y ruteo documentado antes de construir la interfaz completa.

## Fase 2 — Dos decks y mixer
- [ ] Dos decks con transporte.
- [ ] Ganancia, EQ, filtro y crossfader.
- [ ] BPM manual y sincronización inicial.
- [ ] Cue temporal y Hot Cues.
- [ ] Biblioteca local básica.

## Fase 3 — Hercules DJControl AIR
- [ ] Identificar enumeración USB/MIDI en iPadOS.
- [ ] Capturar mensajes MIDI de todos los controles.
- [ ] Validar jog wheels y scratch.
- [ ] Validar botones, faders, knobs y LEDs/feedback.
- [ ] Investigar sensor AIR.
- [ ] Validar master/cue y canales físicos con el adaptador real.
- [ ] Crear mapping inicial y pruebas de regresión.

## Fase 4 — Análisis y waveforms
- [ ] BPM automático.
- [ ] Tonalidad automática.
- [ ] Beatgrid editable.
- [ ] Waveform overview y detalle.
- [ ] Caché y análisis en segundo plano.
- [ ] Estimar y visualizar actividad/energía rítmica por secciones.

## Fase 5 — FX y performance
- [ ] FX básicos y parámetros.
- [ ] Presets y perfiles.
- [ ] Loops, Beat Jump, Roll, Slip y Quantize.
- [ ] Grabación de mezcla.
- [ ] Pruebas de carga y estabilidad.

## Fase futura — Evaluación de cuatro decks (fuera del alcance inicial)
- [ ] Reevaluar si cuatro decks aportan valor sin saturar la pantalla del iPad.
- [ ] Prototipar una distribución con un solo mixer central de cuatro canales.
- [ ] Evaluar capas A/C y B/D para hardware de dos decks.
- [ ] Medir CPU, memoria, latencia y temperatura antes de decidir su viabilidad.
- [ ] Requerirá una decisión de producto explícita antes de entrar en implementación.

## Fase 7 — Extensibilidad y publicación
- [ ] Mapping editor.
- [ ] Evaluación AUv3.
- [ ] Auditoría de seguridad, licencias y privacidad.
- [ ] TestFlight/App Store o distribución alternativa, según viabilidad.
- [ ] Documentación de usuario y soporte.

## Fase de diseño visual y navegación — antes de la implementación completa
- [ ] Usar edjing Mix como referencia de facilidad de uso, sin copiar su identidad ni recursos.
- [ ] Diseñar el layout principal de dos decks.
- [ ] Mantener el diseño inicial enfocado exclusivamente en dos decks y dos waveforms amplios.
- [ ] Definir navegación y jerarquía para DJ principal, FX Studio, Biblioteca, Performance y Hardware/Mapping.
- [ ] Diseñar el flujo de importación y escaneo de música.
- [ ] Diseñar visualización de waveform y análisis de secciones de mayor/menor actividad rítmica.
- [ ] Validar el diseño de dos decks en las dimensiones reales del iPad A16 antes de fijar tamaños.

## Regla de avance

No se marcará una tarea como completada hasta que exista evidencia verificable: código, prueba, medición, captura o documentación técnica reproducible.
