# Scripts de compatibilidad

La interfaz principal es:

```bash
python -m cuadernos update
```

`run_all.py` conserva compatibilidad con el flujo antiguo y ejecuta ese comando desde cualquier directorio:

```bash
python plantilla/scripts/run_all.py
```

`move_pdf.py` mueve a `pdf/` cualquier PDF antiguo que todavía esté mezclado con las fuentes.
