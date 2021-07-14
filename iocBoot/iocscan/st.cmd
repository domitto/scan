#!../../bin/linux-x86_64/scan

#- You may have to change scan to something else
#- everywhere it appears in this file

< envPaths
epicsEnvSet("MAX_PTS",1000)
epicsEnvSet("PREFIX","omitto")

## Register all support components
dbLoadDatabase("../../dbd/scan.dbd",0,0)
scan_registerRecordDeviceDriver(pdbbase) 

#- ### Scan-support software
#- crate-resident scan.  This executes 1D, 2D, 3D, and 4D scans, and caches
#- 1D data, but it doesn't store anything to disk.  (See 'saveData' below for that.)
dbLoadRecords("$(SSCAN)/sscanApp/Db/standardScans.db","P=$(PREFIX):,MAXPTS1=$(MAX_PTS),MAXPTS2=$(MAX_PTS),MAXPTS3=$(MAX_PTS),MAXPTS4=$(MAX_PTS),MAXPTSH=$(MAX_PTS)")

# devIocStats
dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db","IOC=$(PREFIX)")

# interpolation
#dbLoadRecords("$(CALC)/calcApp/Db/interp.db", "P=$(PREFIX):,N=2000")
#dbLoadRecords("$(CALC)/calcApp/Db/interpNew.db", "P=$(PREFIX):,Q=1,N=2000")

#- in saveData.req will *always* write data files.  There is no programmable
#- disable for this software.
dbLoadRecords("$(SSCAN)/sscanApp/Db/saveData.db","P=$(PREFIX):")
doAfterIocInit("saveData_Init('$(REQ_FILE=saveData.req)', 'P=$(PREFIX):')")

dbLoadRecords("$(SSCAN)/sscanApp/Db/scanProgress.db","P=$(PREFIX):scanProgress:")
doAfterIocInit("seq &scanProgress, 'S=$(PREFIX):, P=$(PREFIX):scanProgress:'")

< autosave.cmd

iocInit()

