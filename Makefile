# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# $Id$

CFLAGS = -Wall -O2 -s

.SUFFIXES: .tmpbin

all: sgabios.bin

# FIXME: should calculate the size by rounding it up to the nearest
# 512-byte boundary
sgabios.bin: sgabios.tmpbin buildrom.py
	./buildrom.py sgabios.tmpbin sgabios.bin

sgabios.tmpbin: sgabios.S version.h

version.h: Makefile sgabios.S
	@echo '#define BIOS_BUILD_DATE "'`date -u +%D`'"' >version.h
	@echo '#define BIOS_FULL_DATE "'`date -u`'"' >>version.h
	@echo '#define BIOS_BUILD_HOST "'`echo $$LOGNAME@$$HOSTNAME`'"' >>version.h

.S.tmpbin:
	$(CC) -c $(CFLAGS) $*.S -o $*.o
	$(LD) -Ttext 0x0 -s --oformat binary $*.o -o $*.tmpbin

clean:
	$(RM) *.s *.o *.tmpbin *.bin *.srec *.com version.h
