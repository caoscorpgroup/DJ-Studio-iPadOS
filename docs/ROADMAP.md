# Hoja de ruta

Las etapas son secuenciales y sus fechas se definirán después de comprobar herramientas, licencias y disponibilidad de hardware.

## Fase 0 — Definición y auditoría
- [x] Crear repositorio privado.
- [x] Registrar visión y requisitos iniciales.
- [ ] Confirmar versión de iPadOS y adaptador/hub de la controladora.
- [ ] Auditar licencias y portabilidad de proyectos candidatos.
- [ ] Separar funciones imprescindibles de funciones posteriores.

## Fase 1 — Prueba técnica de audio
- [ ] Crear proyecto mínimo nativo iPadOS.
- [ ] Abrir archivo local y reproducirlo.
- [ ] Medir latencia y estabilidad.
- [ ] Probar salida master y salida cue multicanal.
- [ ] Verificar interrupciones y cambios de ruta.

Puerta de salida: reproducción estable y ruteo documentado antes de construir la interfaz completa.

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

## Fase 5 — FX y performance
- [ ] FX básicos y parámetros.
- [ ] Presets y perfiles.
- [ ] Loops, Beat Jump, Roll, Slip y Quantize.
- [ ] Grabación de mezcla.
- [ ] Pruebas de carga y estabilidad.

## Fase 6 — Cuatro decks
- [ ] Cuatro decks táctiles.
- [ ] Capas A/C y B/D para hardware de dos decks.
- [ ] Mixer de cuatro canales.
- [ ] Pruebas de CPU, memoria, latencia y temperatura.
- [ ] Ajustes de interfaz y rendimiento.

## Fase 7 — Extensibilidad y publicación
- [ ] Mapping editor.
- [ ] Evaluación AUv3.
- [ ] Auditoría de seguridad, licencias y privacidad.
- [ ] TestFlight/App Store o distribución alternativa, según viabilidad.
- [ ] Documentación de usuario y soporte.

## Regla de avance

No se marcará una tarea como completada hasta que exista evidencia verificable: código, prueba, medición, captura o documentación técnica reproducible.
