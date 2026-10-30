# Investigación: compilación iPadOS con GitHub Actions sin costes adicionales

**Fecha de consulta:** 2026-10-30  
**Estado:** investigación documental; no se ha ejecutado ningún workflow ni generado consumo.

## Conclusión

Es técnicamente viable compilar una aplicación nativa iPadOS con Swift y Xcode en un runner macOS estándar de GitHub Actions. El repositorio DJ-Studio-iPadOS es privado, por lo que el uso de runners macOS consume el cómputo incluido en el plan de la cuenta. No es uso ilimitado gratuito.

La viabilidad sin cargos depende de la cuota incluida que realmente tenga la cuenta, del consumo compartido actual y de que el presupuesto de Actions bloquee cualquier gasto adicional. Esta instancia no puede leer la facturación, cuota ni presupuesto privado de la cuenta; esos datos deben verificarse en GitHub antes de cualquier ejecución.

## Datos oficiales consultados

Según la documentación oficial de GitHub consultada el 2026-10-30:

- La asignación de cómputo incluida depende del plan: GitHub Free publica **12 USD/mes**; GitHub Pro y Team, **18 USD/mes**; Enterprise Cloud, **300 USD/mes**. No se ha verificado qué plan tiene la cuenta conectada.
- El runner macOS estándar de 3 o 4 núcleos cuesta **0,062 USD por minuto**. GitHub redondea los minutos y fracciones de cada job al minuto entero siguiente.
- Como referencia teórica, 12 USD cubrirían unos **193 minutos macOS** (12 / 0,062) si todo el saldo estuviera disponible y se dedicara exclusivamente a ese runner. No es una cuota fija de minutos ni confirma el saldo real de esta cuenta.
- GitHub Free incluye **500 MB de almacenamiento de artefactos**; Pro incluye 1 GB. La caché de Actions tiene una asignación separada de 10 GB por repositorio.
- Los runners estándar hospedados por GitHub son gratuitos para repositorios públicos; no se propone hacer público este repositorio privado para ahorrar costes.
- El cómputo incluido se comparte con otros usos elegibles, incluidos cloud sandbox compute y memoria. El uso que exceda lo incluido puede facturarse.
- Los presupuestos pueden configurarse para detener el uso al alcanzar el límite cuando esa opción esté disponible. La documentación indica que los presupuestos a nivel de usuario imponen un hard stop; debe verificarse qué tipo de presupuesto y controles tiene esta cuenta.
- No se puede deducir el plan, saldo, consumo compartido, método de pago ni presupuesto activo de la cuenta a partir del repositorio o de los permisos GitHub disponibles en esta instancia.

### Fuentes oficiales

- GitHub Actions billing: https://docs.github.com/en/billing/concepts/product-billing/github-actions
- Product usage included with each plan: https://docs.github.com/en/billing/reference/product-usage-included
- GitHub-hosted runners reference: https://docs.github.com/en/actions/reference/runners/github-hosted-runners
- Actions limits: https://docs.github.com/en/actions/reference/limits

## Recomendación para DJ Studio

1. Mantener el repositorio privado.
2. Utilizar un runner estándar macOS 15 o macOS latest (Apple Silicon) para las compilaciones de iPadOS, una vez comprobada la versión de Xcode/SDK necesaria.
3. Reservar macOS exclusivamente para compilar y ejecutar pruebas que requieran Xcode.
4. Ejecutar validaciones de Markdown, estructura, scripts y otras tareas que no necesiten Xcode en ubuntu-latest, que tiene un coste por minuto mucho menor.
5. Activar un presupuesto de GitHub Actions con límite de gasto adicional en **0 USD** y la opción de detener el uso al alcanzar el límite, si está disponible en la configuración de facturación de la cuenta.
6. Revisar el consumo incluido antes de ejecutar builds repetidos. La cuota puede estar compartida con otros repositorios o productos elegibles.
7. Mantener los artefactos pequeños, con retención corta y sin incluir archivos musicales personales.
8. Evitar matrices de compilación, builds automáticos por cada cambio documental y ejecuciones concurrentes.
9. No almacenar certificados, perfiles de firma, contraseñas ni tokens en el repositorio o en logs.
10. No hacer pública la aplicación ni el repositorio para obtener minutos gratuitos.

## Diseño seguro del workflow futuro

Cuando exista un proyecto Xcode real, el primer workflow deberá:

- Tener activación manual mediante workflow_dispatch inicialmente.
- Utilizar un solo job y un runner macOS estándar.
- Fijar un timeout-minutes corto (por ejemplo, 10 minutos para una primera prueba).
- Evitar matrices, cachés y pasos innecesarios.
- Compilar primero para simulador; la compilación para dispositivo y su firma se probarán por separado.
- No ejecutar hasta que el usuario haya comprobado el presupuesto de gasto y la disponibilidad de cuota.
- No habilitar publicación, TestFlight ni distribución automática.

## Límites técnicos importantes

- Un runner macOS con Xcode puede compilar el proyecto, pero no sustituye la prueba física en el iPad.
- Compilar para simulador no demuestra que la app esté firmada e instalable en el dispositivo.
- La firma, provisioning, instalación y depuración requieren una validación independiente.
- Los runners hospedados por GitHub son efímeros; no deben tratarse como un Mac permanente.
- Swift Playgrounds puede ser útil para prototipos en iPad, pero no debe asumirse que cubre todo el flujo de Xcode.

## Estado actual del repositorio

La revisión de la rama `docs/swift6-technical-foundation` confirma que el paquete `DJStudioCore` y la biblioteca local tienen código inicial, pero no existe todavía un target completo de aplicación iPadOS ni un motor de audio. El PR #1 no incluye archivos de workflow entre sus cambios y la consulta de ejecuciones asociadas al HEAD revisado devolvió cero ejecuciones. Esto no demuestra que no existan workflows en otras ramas ni permite conocer la configuración de Actions de la cuenta.

**No se ha iniciado ninguna ejecución de GitHub Actions**, por lo que esta investigación no ha consumido minutos de runner.

## Decisión propuesta

Usar GitHub Actions macOS dentro de la cuota incluida, pero solo después de comprobar el presupuesto y el consumo real de la cuenta. Si no se puede garantizar el bloqueo de cargos adicionales, no ejecutar el runner macOS. No cambiar la visibilidad del repositorio ni contratar servicios para resolver esta limitación.
