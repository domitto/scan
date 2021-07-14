set_requestfile_path("$(TOP)","iocBoot/iocscan")
set_requestfile_path("$(AUTOSAVE)","asApp/Db")
set_requestfile_path("$(SSCAN)","sscanApp/Db")

set_savefile_path("$(TOP)/as")
set_pass0_restoreFile("standardScans_settings.sav","P=$(PREFIX):")
set_pass0_restoreFile("saveData_settings.sav","P=$(PREFIX):")
save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)

doAfterIocInit("create_monitor_set('standardScans_settings.req',5,'P=$(PREFIX):')")
doAfterIocInit("create_monitor_set('saveData_settings.req',5,'P=$(PREFIX):')")

#autosave configMenu
dbLoadRecords("$(AUTOSAVE)/asApp/Db/configMenu.db","P=$(PREFIX):,CONFIG=scan1")
doAfterIocInit("create_manual_set('scan1Menu.req','P=$(PREFIX):,CONFIG=scan1,CONFIGMENU=1')"

