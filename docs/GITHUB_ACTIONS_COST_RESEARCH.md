# Investigación: compilación iPadOS con GitHub Actions sin costes adicionales

**Fecha de consulta:** 2026-10-30  
**Estado:** investigación documental; no se ha ejecutado ningún workflow ni generado consumo.

## Conclusión

Es técnicamente viable compilar una aplicación nativa iPadOS con Swift y Xcode en un runner macOS estándar de GitHub Actions. El repositorio DJ-Studio-iPadOS es privado, por lo que el uso de runners macOS consume el cómputo incluido en el plan de la cuenta. No es uso ilimitado gratuito.

La viabilidad sin cargos depende de que la cuota incluida esté disponible y de que el presupuesto de Actions impida cualquier consumo facturable adicional.

## Datos oficiales consultados

Según la documentación oficial de GitHub consultada el 2026-10-30:

- GitHub Free incluye **12 USD/mes de cómputo** para usos elegibles en repositorios privados.
- El runner macOS estándar (3 o 4 núcleos) cuesta **0,062 USD por minuto**.
- La cuota teórica equivale a unos **193 minutos de runner macOS al mes** (12 / 0,062), antes de descontar cualquier otro consumo que comparta ese saldo.
- GitHub Free incluye **500 MB de almacenamiento compartido para artefactos y GitHub Packages**.
- El caché de Actions tiene una asignación separada de 10 GB por repositorio.
- En repositorios públicos, los runners estándar hospedados por GitHub son gratuitos; esa alternativa no se recomienda aquí porque el usuario desea mantener privado el proyecto.
- El cómputo incluido se comparte con otros usos elegibles de la cuenta, incluidos cloud sandbox compute/memory. Los consumos adicionales pueden facturarse.
- Si no existe un método de pago válido, GitHub indica que el uso se bloquea al agotarse la cuota incluida. Si existe un método de pago, se debe revisar el presupuesto y activar el bloqueo de gasto para impedir cargos.

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

La revisión de metadatos indica que el repositorio es privado y su rama predeterminada es main. El README todavía describe el proyecto como fase de definición y auditoría, sin motor de audio implementado. No se encontró un workflow de compilación iPadOS en la ruta consultada.

**No se ha iniciado ninguna ejecución de GitHub Actions**, por lo que esta investigación no ha consumido minutos de runner.

## Decisión propuesta

Usar GitHub Actions macOS dentro de la cuota incluida, pero solo después de comprobar el presupuesto y el consumo real de la cuenta. Si no se puede garantizar el bloqueo de cargos adicionales, no ejecutar el runner macOS. No cambiar la visibilidad del repositorio ni contratar servicios para resolver esta limitación.
