-- move_pdf.lua  (funciona en Windows y Linux)
-- Uso: texlua move_pdf.lua <ruta_al_tex> [outdir]
local doc = arg[1]
local outdir = arg[2] or "build"

if not doc or doc == "" then
  io.stderr:write("ERROR: falta ruta del .tex\n")
  os.exit(1)
end

-- Detecta separadores y extrae dir/base manejando / y \
local dir = doc:match("^(.*)[/\\]") or "."
local file = doc:match("([^/\\]+)$") or doc
local name = file:gsub("%.tex$", "")

-- Construye rutas absolutas hacia src y dst
local sep = package.config:sub(1,1) -- '/' o '\'
local function join(a,b) return a .. sep .. b end
local src = join(join(dir, outdir), name .. ".pdf")
local dst = join(dir, name .. ".pdf")

-- Helper: copiar si renombrar falla (por bloqueo o cross-device)
local function copy_file(s, d)
  local inF, err1 = io.open(s, "rb"); if not inF then return false, err1 end
  local outF, err2 = io.open(d, "wb"); if not outF then inF:close(); return false, err2 end
  local block = 1024 * 1024
  while true do
    local buf = inF:read(block)
    if not buf then break end
    outF:write(buf)
  end
  inF:close(); outF:close()
  return true
end

-- Comprueba existencia del PDF fuente
local test = io.open(src, "rb")
if not test then
  io.stderr:write("ERROR: no existe PDF de salida en: " .. src .. "\n")
  io.stderr:write("¿Falló lualatex/biber o el outDir no es '" .. outdir .. "'?\n")
  os.exit(1)
end
test:close()

-- Intenta borrar el destino si existe
os.remove(dst)

-- 1) intenta mover
local ok, msg = os.rename(src, dst)
if not ok then
  -- 2) copia y luego borra el origen (útil si el visor bloquea o cambia de FS)
  local ok2, msg2 = copy_file(src, dst)
  if not ok2 then
    io.stderr:write("ERROR al mover/copiar:\n - rename: " .. tostring(msg) .. "\n - copy: " .. tostring(msg2) .. "\n")
    os.exit(1)
  end
  os.remove(src)
end

io.write("PDF movido a: " .. dst .. "\n")
