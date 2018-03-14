SFWMD.DBHYDRO.Data.WQ=function(SDATE,EDATE,WQ.Station,tests){
  SDATE=paste(format(SDATE,"%d"),toupper(format(SDATE,"%b")),format(SDATE,"%Y"),sep="-");#"%d-%b-%Y
  EDATE=paste(format(EDATE,"%d"),toupper(format(EDATE,"%b")),format(EDATE,"%Y"),sep="-");#"%d-%b-%Y
  WQ.Station=paste("'",WQ.Station,"'",collapse=",",sep="")
  tests=paste("(",paste(tests,collapse=",",sep=""),")",sep="")
  WQ.link=paste0("http://my.sfwmd.gov/dbhydroplsql/water_quality_data.report_full?v_where_clause=where+station_id+in+(",WQ.Station,")+and+test_number+in+",tests,"+and+date_collected+>=+'",SDATE,"'+and+date_collected+<+'",EDATE,"'+and+sample_type_new+=+'SAMP'&v_exc_qc=Y&v_exc_flagged=Y&v_target_code=file_csv")
  REPORT=read.csv(WQ.link);
  REPORT=subset(REPORT,is.na(Test.Number)==FALSE)
  REPORT$Collection_Date=as.POSIXct(strptime(REPORT$Collection_Date,"%d-%b-%Y %R"),tz="America/New_York")
  REPORT$First.Trigger.Date=as.POSIXct(strptime(REPORT$First.Trigger.Date,"%d-%b-%Y %R"),tz="America/New_York")
  REPORT$Date=as.POSIXct(strptime(REPORT$Collection_Date,"%F"),tz="America/New_York")
  REPORT$DateTime.EST=REPORT$Collection_Date
  attr(REPORT$DateTime.EST,"tzone")<-"EST"
  REPORT$Date.EST=as.POSIXct(strptime(REPORT$DateTime.EST,"%F"),tz="EST")
  #REPORT$Date.EST=REPORT$Date
  #attributes(REPORT$Date.EST)$tzone="EST"
  REPORT$HalfMDL=with(REPORT,ifelse(Value<0,abs(Value)/2,Value))
  return(REPORT)
}

  SFWMD.DBHYDRO.Data.daily=function(SDATE,EDATE,DBK){
  DBK.val=paste("",DBK,"",collapse="/",sep="")
  SDATE=paste(format(SDATE,"%Y"),toupper(format(SDATE,"%m")),format(SDATE,"%d"),sep="");#In YYYYMMDD format
  EDATE=paste(format(EDATE,"%Y"),toupper(format(EDATE,"%m")),format(EDATE,"%d"),sep="");#In YYYYMMDD format
  link=paste("http://my.sfwmd.gov/dbhydroplsql/web_io.report_process?v_period=uspec&v_start_date=",SDATE,"&v_end_date=",EDATE,"&v_report_type=format6&v_target_code=file_csv&v_run_mode=onLine&v_js_flag=Y&v_dbkey=",DBK.val,sep="")
  print(link)
  REPORT=read.csv(link,skip=length(DBK)+2)
  REPORT$Date=with(REPORT,as.POSIXct(as.character(Daily.Date),format="%d-%b-%Y",tz="America/New_York"))
  REPORT=subset(REPORT,is.na(Date)==FALSE)
  return(REPORT)
}
