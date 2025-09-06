-- copy_pdf.lua (Windows/Linux compatible)
-- Uso: texlua copy_pdf.lua <ruta_al_tex> <outdir> <destino>

local doc     = arg[1]
local outdir  = arg[2] or "build"
local destdir = arg[3]

if not doc or not destdir then
  io.stderr:write("Uso: texlua copy_pdf.lua <archivo.tex> <outdir> <destino>\n")
  os.exit(1)
end

-- Detecta separador de rutas
local sep = package.config:sub(1,1)

local function join(a, b)
  return a .. sep .. b
end

-- Extrae carpeta, nombre base y nombre sin extensión
local dir  = doc:match("^(.*)[/\\]") or "."
local file = doc:match("([^/\\]+)$") or doc
local name = file:gsub("%.tex$", "")

-- Construye rutas
local src = join(join(dir, outdir), name .. ".pdf")
local dst = join(destdir, name .. ".pdf")

-- Función auxiliar para copiar archivos
local function copy_file(s, d)
  local inF, err1 = io.open(s, "rb")
  if not inF then return false, err1 end
  local outF, err2 = io.open(d, "wb")
  if not outF then inF:close(); return false, err2 end
  local block = 1024 * 1024
  while true do
    local buf = inF:read(block)
    if not buf then break end
    outF:write(buf)
  end
  inF:close(); outF:close()
  return true
end

-- Comprueba que el PDF existe
local test = io.open(src, "rb")
if not test then
  io.stderr:write("ERROR: no existe el PDF en " .. src .. "\n")
  os.exit(1)
end
test:close()

-- Crea carpeta destino si no existe
if sep == "\\" then
  os.execute(string.format('if not exist "%s" mkdir "%s"', destdir, destdir))
else
  os.execute(string.format('mkdir -p "%s"', destdir))
end

-- Copia
local ok, msg = copy_file(src, dst)
if not ok then
  io.stderr:write("ERROR al copiar: " .. tostring(msg) .. "\n")
  os.exit(1)
end

io.write("PDF copiado a: " .. dst .. "\n")
