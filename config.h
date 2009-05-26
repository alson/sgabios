/* Define FORCE_VBIOS_PRESENT to skip video bios detection and
 * assume it's there. Use this for systems that implement a functioning
 * int 10h handler in a segment other than c000 (usually at address 
 * f000:f065).
 */
#undef FORCE_VBIOS_PRESENT
