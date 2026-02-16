MEMORY
{
	ram  : org = 0x7FFFFFE0, len = 32M
}

SECTIONS
{
  . = ORIGIN(ram);
  _start = .;
  .text : 
  {
    build/start.o (.text)
    *(.text);
  } >ram

  .data :
  {
    *(.data);
    *(.rodata);
  } >ram
  PRGM_END = .;

  __bss_start__ = .;
  .bss : 
  {
    *(.bss);
  } >ram
  __bss_end__ = .;
}

__program_size = PRGM_END - _start;
