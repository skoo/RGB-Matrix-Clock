#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile

# Environment
MKDIR=mkdir -p
RM=rm -f 
CP=cp 
# Macros
CND_CONF=default

ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof
endif
# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}
# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/btn.o ${OBJECTDIR}/rgbmatrix_digits.o ${OBJECTDIR}/rtc.o ${OBJECTDIR}/rgbmatrix.o ${OBJECTDIR}/calendar.o ${OBJECTDIR}/isr.o ${OBJECTDIR}/main.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

OS_ORIGINAL="Linux"
OS_CURRENT="$(shell uname -s)"
############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
MP_CC=/opt/microchip/mplabc18/v3.36/bin/mcc18
# MP_BC is not defined
MP_AS=/opt/microchip/mplabc18/v3.36/bin/../mpasm/MPASMWIN
MP_LD=/opt/microchip/mplabc18/v3.36/bin/mplink
MP_AR=/opt/microchip/mplabc18/v3.36/bin/mplib
# MP_BC is not defined
MP_CC_DIR=/opt/microchip/mplabc18/v3.36/bin
# MP_BC_DIR is not defined
MP_AS_DIR=/opt/microchip/mplabc18/v3.36/bin/../mpasm
MP_LD_DIR=/opt/microchip/mplabc18/v3.36/bin
MP_AR_DIR=/opt/microchip/mplabc18/v3.36/bin
# MP_BC_DIR is not defined
# This makefile will use a C preprocessor to generate dependency files
MP_CPP=/opt/microchip/mplabx/mplab_ide/mplab_ide/modules/../../bin/mplab-cpp
.build-conf: ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof

# ------------------------------------------------------------------------------------
# Rules for buildStep: createRevGrep
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
__revgrep__:   nbproject/Makefile-${CND_CONF}.mk
	@echo 'grep -q $$@' > __revgrep__
	@echo 'if [ "$$?" -ne "0" ]; then' >> __revgrep__
	@echo '  exit 0' >> __revgrep__
	@echo 'else' >> __revgrep__
	@echo '  exit 1' >> __revgrep__
	@echo 'fi' >> __revgrep__
	@chmod +x __revgrep__
else
__revgrep__:   nbproject/Makefile-${CND_CONF}.mk
	@echo 'grep -q $$@' > __revgrep__
	@echo 'if [ "$$?" -ne "0" ]; then' >> __revgrep__
	@echo '  exit 0' >> __revgrep__
	@echo 'else' >> __revgrep__
	@echo '  exit 1' >> __revgrep__
	@echo 'fi' >> __revgrep__
	@chmod +x __revgrep__
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
.PHONY: ${OBJECTDIR}/btn.o
${OBJECTDIR}/btn.o: btn.asm __revgrep__ nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	-${MP_AS}  -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p18F45J10  -l"${OBJECTDIR}/btn.lst" -e"${OBJECTDIR}/btn.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/btn.o" btn.asm 
else 
	-${MP_AS}  -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p18F45J10 -u  -l"${OBJECTDIR}/btn.lst" -e"${OBJECTDIR}/btn.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/btn.o" btn.asm 
endif 
	@cat  "${OBJECTDIR}/btn.err" | sed -e 's/\x0D$$//' -e 's/\(^Warning\|^Error\|^Message\)\(\[[0-9]*\]\) *\(.*\) \([0-9]*\) : \(.*$$\)/\3:\4: \1\2: \5/g'
	@./__revgrep__ "^Error" ${OBJECTDIR}/btn.err
.PHONY: ${OBJECTDIR}/isr.o
${OBJECTDIR}/isr.o: isr.asm __revgrep__ nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	-${MP_AS}  -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p18F45J10  -l"${OBJECTDIR}/isr.lst" -e"${OBJECTDIR}/isr.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/isr.o" isr.asm 
else 
	-${MP_AS}  -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p18F45J10 -u  -l"${OBJECTDIR}/isr.lst" -e"${OBJECTDIR}/isr.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/isr.o" isr.asm 
endif 
	@cat  "${OBJECTDIR}/isr.err" | sed -e 's/\x0D$$//' -e 's/\(^Warning\|^Error\|^Message\)\(\[[0-9]*\]\) *\(.*\) \([0-9]*\) : \(.*$$\)/\3:\4: \1\2: \5/g'
	@./__revgrep__ "^Error" ${OBJECTDIR}/isr.err
else
.PHONY: ${OBJECTDIR}/btn.o
${OBJECTDIR}/btn.o: btn.asm __revgrep__ nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	-${MP_AS}  -q -p18F45J10  -l"${OBJECTDIR}/btn.lst" -e"${OBJECTDIR}/btn.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/btn.o" btn.asm 
else 
	-${MP_AS}  -q -p18F45J10 -u  -l"${OBJECTDIR}/btn.lst" -e"${OBJECTDIR}/btn.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/btn.o" btn.asm 
endif 
	@cat  "${OBJECTDIR}/btn.err" | sed -e 's/\x0D$$//' -e 's/\(^Warning\|^Error\|^Message\)\(\[[0-9]*\]\) *\(.*\) \([0-9]*\) : \(.*$$\)/\3:\4: \1\2: \5/g'
	@./__revgrep__ "^Error" ${OBJECTDIR}/btn.err
.PHONY: ${OBJECTDIR}/isr.o
${OBJECTDIR}/isr.o: isr.asm __revgrep__ nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	-${MP_AS}  -q -p18F45J10  -l"${OBJECTDIR}/isr.lst" -e"${OBJECTDIR}/isr.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/isr.o" isr.asm 
else 
	-${MP_AS}  -q -p18F45J10 -u  -l"${OBJECTDIR}/isr.lst" -e"${OBJECTDIR}/isr.err" $(ASM_OPTIONS)  -o"${OBJECTDIR}/isr.o" isr.asm 
endif 
	@cat  "${OBJECTDIR}/isr.err" | sed -e 's/\x0D$$//' -e 's/\(^Warning\|^Error\|^Message\)\(\[[0-9]*\]\) *\(.*\) \([0-9]*\) : \(.*$$\)/\3:\4: \1\2: \5/g'
	@./__revgrep__ "^Error" ${OBJECTDIR}/isr.err
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/rgbmatrix_digits.o: rgbmatrix_digits.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rgbmatrix_digits.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rgbmatrix_digits.o   rgbmatrix_digits.c  > ${OBJECTDIR}/rgbmatrix_digits.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rgbmatrix_digits.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rgbmatrix_digits.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rgbmatrix_digits.o.temp rgbmatrix_digits.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rgbmatrix_digits.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rgbmatrix_digits.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rgbmatrix_digits.o.d
else
	cat ${OBJECTDIR}/rgbmatrix_digits.o.temp >> ${OBJECTDIR}/rgbmatrix_digits.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rtc.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rtc.o   rtc.c  > ${OBJECTDIR}/rtc.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rtc.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rtc.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rtc.o.temp rtc.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rtc.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rtc.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rtc.o.d
else
	cat ${OBJECTDIR}/rtc.o.temp >> ${OBJECTDIR}/rtc.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/rgbmatrix.o: rgbmatrix.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rgbmatrix.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rgbmatrix.o   rgbmatrix.c  > ${OBJECTDIR}/rgbmatrix.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rgbmatrix.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rgbmatrix.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rgbmatrix.o.temp rgbmatrix.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rgbmatrix.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rgbmatrix.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rgbmatrix.o.d
else
	cat ${OBJECTDIR}/rgbmatrix.o.temp >> ${OBJECTDIR}/rgbmatrix.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/calendar.o: calendar.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/calendar.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/calendar.o   calendar.c  > ${OBJECTDIR}/calendar.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/calendar.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/calendar.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/calendar.o.temp calendar.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/calendar.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/calendar.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/calendar.o.d
else
	cat ${OBJECTDIR}/calendar.o.temp >> ${OBJECTDIR}/calendar.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/main.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/main.o   main.c  > ${OBJECTDIR}/main.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/main.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/main.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/main.o.temp main.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/main.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/main.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/main.o.d
else
	cat ${OBJECTDIR}/main.o.temp >> ${OBJECTDIR}/main.o.d
endif
	${RM} __temp_cpp_output__
else
${OBJECTDIR}/rgbmatrix_digits.o: rgbmatrix_digits.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rgbmatrix_digits.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rgbmatrix_digits.o   rgbmatrix_digits.c  > ${OBJECTDIR}/rgbmatrix_digits.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rgbmatrix_digits.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rgbmatrix_digits.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rgbmatrix_digits.o.temp rgbmatrix_digits.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rgbmatrix_digits.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rgbmatrix_digits.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rgbmatrix_digits.o.d
else
	cat ${OBJECTDIR}/rgbmatrix_digits.o.temp >> ${OBJECTDIR}/rgbmatrix_digits.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rtc.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rtc.o   rtc.c  > ${OBJECTDIR}/rtc.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rtc.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rtc.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rtc.o.temp rtc.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rtc.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rtc.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rtc.o.d
else
	cat ${OBJECTDIR}/rtc.o.temp >> ${OBJECTDIR}/rtc.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/rgbmatrix.o: rgbmatrix.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/rgbmatrix.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/rgbmatrix.o   rgbmatrix.c  > ${OBJECTDIR}/rgbmatrix.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/rgbmatrix.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/rgbmatrix.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/rgbmatrix.o.temp rgbmatrix.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/rgbmatrix.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/rgbmatrix.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/rgbmatrix.o.d
else
	cat ${OBJECTDIR}/rgbmatrix.o.temp >> ${OBJECTDIR}/rgbmatrix.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/calendar.o: calendar.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/calendar.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/calendar.o   calendar.c  > ${OBJECTDIR}/calendar.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/calendar.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/calendar.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/calendar.o.temp calendar.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/calendar.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/calendar.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/calendar.o.d
else
	cat ${OBJECTDIR}/calendar.o.temp >> ${OBJECTDIR}/calendar.o.d
endif
	${RM} __temp_cpp_output__
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${RM} ${OBJECTDIR}/main.o.d 
	${MKDIR} ${OBJECTDIR} 
	${MP_CC}  -p18F45J10 -I".." -I"../i2c" -ml -ou- -ot- -ob- -op- -or- -od- -opa-  -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/main.o   main.c  > ${OBJECTDIR}/main.err 2>&1 ; if [ $$? -eq 0 ] ; then cat ${OBJECTDIR}/main.err | sed 's/\(^.*:.*:\)\(Warning\)\(.*$$\)/\1 \2:\3/g' ; else cat ${OBJECTDIR}/main.err | sed 's/\(^.*:.*:\)\(Error\)\(.*$$\)/\1 \2:\3/g' ; exit 1 ; fi
	${MP_CPP}  -MMD ${OBJECTDIR}/main.o.temp main.c __temp_cpp_output__ -D __18F45J10 -D __18CXX -I /home/saku/src -I /home/saku/src/rgbmatrixclock/../i2c -I /opt/microchip/mplabc18/v3.36/bin/../h  -D__18F45J10
	printf "%s/" ${OBJECTDIR} > ${OBJECTDIR}/main.o.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT)))
	cat ${OBJECTDIR}/main.o.temp | sed -e 's/\\\ /__SPACES__/g' -e's/\\$$/__EOL__/g' -e 's/\\/\//g' -e 's/__SPACES__/\\\ /g' -e 's/__EOL__/\\/g' >> ${OBJECTDIR}/main.o.d
else
	cat ${OBJECTDIR}/main.o.temp >> ${OBJECTDIR}/main.o.d
endif
	${RM} __temp_cpp_output__
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD}   -p18f45j10  -w -x -l"/opt/microchip/mplabc18/v3.36/lib"  -z__MPLAB_BUILD=1  -u_CRUNTIME -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PK3=1  -l ${MP_CC_DIR}/../lib  -odist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof ${OBJECTFILES}      
else
dist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD}   -p18f45j10  -w  -l"/opt/microchip/mplabc18/v3.36/lib"  -z__MPLAB_BUILD=1  -u_CRUNTIME -l ${MP_CC_DIR}/../lib  -odist/${CND_CONF}/${IMAGE_TYPE}/rgbmatrixclock.${IMAGE_TYPE}.cof ${OBJECTFILES}      
endif


# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf:
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
