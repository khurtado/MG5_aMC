$ !
$ ! VMS procedure to compile and link modules for Histoscope tool.
$ !
$ ! SCCS ID: @(#)comutil.com	1.2     11/15/93
$ SET NOVERIFY
$ ON ERROR THEN EXIT
$ COMPILE := CC
$ @[-.HISTO]COMSYM
$ SET VERIFY
$ !
$ COMPILE DIALOGF.C
$ COMPILE FILEUTILS.C
$ COMPILE GETFILES.c
$ COMPILE MISC.C  
$ COMPILE STRINGUTILS.C
$ COMPILE HELP.C
$ COMPILE PSUTILS.C
$ COMPILE PREFFILE.C
$ COMPILE FONTSEL.C
$ COMPILE PRINTUTILS.C
$ !
$ LIBR/CREATE/OBJ LIBUTIL DIALOGF, FILEUTILS, GETFILES, MISC, STRINGUTILS, -
	HELP, PSUTILS, PRINTUTILS, PREFFILE, FONTSEL
$ !
$ COMPILE VMSUTILS.C
$ !
$ LIBR/CREATE/OBJ VMSUTILS VMSUTILS
$ !
$ COMPILE TESTDIALOGF.C
$ LINK TESTDIALOGF, LIBUTIL.OLB/LIB, [-.HISTO]HISTO_OPTIONS_FILE/OPT
$ COMPILE TESTGETFILES.C
$ LINK TESTGETFILES, LIBUTIL.OLB/LIB, [-.HISTO]HISTO_OPTIONS_FILE/OPT
$ COMPILE TESTGREEK.C
$ LINK TESTGREEK, LIBUTIL.OLB/LIB, [-.HISTO]HISTO_OPTIONS_FILE/OPT
$ COMPILE TESTPRINT.C
$ LINK TESTPRINT, LIBUTIL.OLB/LIB, [-.HISTO]HISTO_OPTIONS_FILE/OPT