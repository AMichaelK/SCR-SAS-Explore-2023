data sasep.out;
   dcl package pymas pm;
   dcl package logger logr('App.MM.Python.DS2');
   dcl varchar(32767) character set utf8 pypgm;
   dcl double resultCode revision;
   dcl varchar(100) "Carrier";
   dcl double "DayofMonth";
   dcl varchar(100) "OriginAirport";
   dcl double "ScheduledElapsedTimeMinutes";
   dcl double "ArrivalHour";
   dcl double "DepatureHour";
   dcl varchar(100) "EM_CLASSIFICATION";
   dcl double "EM_EVENTPROBABILITY";

   method score(
   varchar(100) "Carrier",
   double "DayofMonth",
   varchar(100) "OriginAirport",
   double "ScheduledElapsedTimeMinutes",
   double "ArrivalHour",
   double "DepatureHour",
   in_out double resultCode,
   in_out varchar(100) "EM_CLASSIFICATION",
   in_out double "EM_EVENTPROBABILITY");

      resultCode = revision = 0;
      if null(pm) then do;
         pm = _new_ pymas();
         resultCode = pm.useModule('model_exec_fd2a6708-5ecb-4388-bc5b-b0de912c4492', 1);
         if resultCode then do;
            resultCode = pm.appendSrcLine('import sys');
            resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/e4949fbb-1dfb-43f7-92b3-442f8b968dc7/")');
            resultCode = pm.appendSrcLine('import settings_e4949fbb_1dfb_43f7_92b3_442f8b968dc7');
            resultCode = pm.appendSrcLine('settings_e4949fbb_1dfb_43f7_92b3_442f8b968dc7.pickle_path = "/models/resources/viya/e4949fbb-1dfb-43f7-92b3-442f8b968dc7/"');
            resultCode = pm.appendSrcLine('import score_SKLearn_Logistic_Regression');
            resultCode = pm.appendSrcLine('def score(Carrier, DayofMonth, OriginAirport, ScheduledElapsedTimeMinutes, ArrivalHour, DepatureHour):');
            resultCode = pm.appendSrcLine('    "Output: EM_CLASSIFICATION, EM_EVENTPROBABILITY"');
            resultCode = pm.appendSrcLine('    return score_SKLearn_Logistic_Regression.score(Carrier, DayofMonth, OriginAirport, ScheduledElapsedTimeMinutes, ArrivalHour, DepatureHour)');

            revision = pm.publish(pm.getSource(), 'model_exec_fd2a6708-5ecb-4388-bc5b-b0de912c4492');
            if ( revision < 1 ) then do;
               logr.log( 'e', 'py.publish() failed.');
               resultCode = -1;
               return;
            end;
         end;
      end;

      resultCode = pm.useMethod('score');
      if resultCode then do;
         logr.log('E', 'useMethod() failed. resultCode=$s', resultCode);
         return;
      end;
      resultCode = pm.setString('Carrier', Carrier);
      if resultCode then
         logr.log('E', 'setString for Carrier failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DayofMonth', DayofMonth);
      if resultCode then
         logr.log('E', 'setDouble for DayofMonth failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('OriginAirport', OriginAirport);
      if resultCode then
         logr.log('E', 'setString for OriginAirport failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('ScheduledElapsedTimeMinutes', ScheduledElapsedTimeMinutes);
      if resultCode then
         logr.log('E', 'setDouble for ScheduledElapsedTimeMinutes failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('ArrivalHour', ArrivalHour);
      if resultCode then
         logr.log('E', 'setDouble for ArrivalHour failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DepatureHour', DepatureHour);
      if resultCode then
         logr.log('E', 'setDouble for DepatureHour failed.  resultCode=$s', resultCode);
      resultCode = pm.execute();
      if (resultCode) then
         logr.log('E', 'Error: pm.execute failed.  resultCode=$s', resultCode);
      else do;
         "EM_CLASSIFICATION" = pm.getString('EM_CLASSIFICATION');
         "EM_EVENTPROBABILITY" = pm.getDouble('EM_EVENTPROBABILITY');
      end;
   end;

   method run();
      set SASEP.IN;
      score("Carrier","DayofMonth","OriginAirport","ScheduledElapsedTimeMinutes","ArrivalHour","DepatureHour", resultCode, "EM_CLASSIFICATION", "EM_EVENTPROBABILITY");
   end;
enddata;
