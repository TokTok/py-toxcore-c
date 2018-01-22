# Linker script to export only the Python symbols.
{
  global:
    initpytox*;
    PyInit_pytox*;
  local: *;
};
