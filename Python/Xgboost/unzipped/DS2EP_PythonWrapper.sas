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
         resultCode = pm.useModule('model_exec_feddea30-6131-4664-ad12-e2df3108f6f6', 1);
         if resultCode then do;
            resultCode = pm.appendSrcLine('import sys');
            resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/5b2981f2-4814-48cb-825a-463d76801b2c/")');
            resultCode = pm.appendSrcLine('import settings_5b2981f2_4814_48cb_825a_463d76801b2c');
            resultCode = pm.appendSrcLine('settings_5b2981f2_4814_48cb_825a_463d76801b2c.pickle_path = "/models/resources/viya/5b2981f2-4814-48cb-825a-463d76801b2c/"');
            resultCode = pm.appendSrcLine('import score_Xgboost');
            resultCode = pm.appendSrcLine('def score(Carrier, DayofMonth, OriginAirport, ScheduledElapsedTimeMinutes, ArrivalHour, DepatureHour):');
            resultCode = pm.appendSrcLine('    "Output: EM_CLASSIFICATION, EM_EVENTPROBABILITY"');
            resultCode = pm.appendSrcLine('    return score_Xgboost.score(Carrier, DayofMonth, OriginAirport, ScheduledElapsedTimeMinutes, ArrivalHour, DepatureHour)');

            revision = pm.publish(pm.getSource(), 'model_exec_feddea30-6131-4664-ad12-e2df3108f6f6');
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
