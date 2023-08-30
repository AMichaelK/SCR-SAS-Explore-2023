data sasep.out;
   dcl package pymas pm;
   dcl package logger logr('App.MM.Python.DS2');
   dcl varchar(32767) character set utf8 pypgm;
   dcl double resultCode revision;
   dcl varchar(100) "JOB";
   dcl varchar(100) "REASON";
   dcl double "CLAGE";
   dcl double "CLNO";
   dcl double "DEBTINC";
   dcl double "DELINQ";
   dcl double "DEROG";
   dcl double "NINQ";
   dcl double "YOJ";
   dcl double "EM_EVENTPROBABILITY";
   dcl varchar(100) "EM_CLASSIFICATION";

   method score(
   varchar(100) "JOB",
   varchar(100) "REASON",
   double "CLAGE",
   double "CLNO",
   double "DEBTINC",
   double "DELINQ",
   double "DEROG",
   double "NINQ",
   double "YOJ",
   in_out double resultCode,
   in_out double "EM_EVENTPROBABILITY",
   in_out varchar(100) "EM_CLASSIFICATION");

      resultCode = revision = 0;
      if null(pm) then do;
         pm = _new_ pymas();
         resultCode = pm.useModule('model_exec_264bb25f-03c7-4ad0-b549-fa8ccb89b542', 1);
         if resultCode then do;
            resultCode = pm.appendSrcLine('import sys');
            resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/62c6c111-0c77-4bbc-a7c0-f6f40cf959c6/")');
            resultCode = pm.appendSrcLine('import settings_62c6c111_0c77_4bbc_a7c0_f6f40cf959c6');
            resultCode = pm.appendSrcLine('settings_62c6c111_0c77_4bbc_a7c0_f6f40cf959c6.pickle_path = "/models/resources/viya/62c6c111-0c77-4bbc-a7c0-f6f40cf959c6/"');
            resultCode = pm.appendSrcLine('import hmeq_logistic_score');
            resultCode = pm.appendSrcLine('def scoreHMEQLogisticModel(JOB, REASON, CLAGE, CLNO, DEBTINC, DELINQ, DEROG, NINQ, YOJ):');
            resultCode = pm.appendSrcLine('    "Output: EM_EVENTPROBABILITY, EM_CLASSIFICATION"');
            resultCode = pm.appendSrcLine('    return hmeq_logistic_score.scoreHMEQLogisticModel(JOB, REASON, CLAGE, CLNO, DEBTINC, DELINQ, DEROG, NINQ, YOJ)');

            revision = pm.publish(pm.getSource(), 'model_exec_264bb25f-03c7-4ad0-b549-fa8ccb89b542');
            if ( revision < 1 ) then do;
               logr.log( 'e', 'py.publish() failed.');
               resultCode = -1;
               return;
            end;
         end;
      end;

      resultCode = pm.useMethod('scoreHMEQLogisticModel');
      if resultCode then do;
         logr.log('E', 'useMethod() failed. resultCode=$s', resultCode);
         return;
      end;
      resultCode = pm.setString('JOB', JOB);
      if resultCode then
         logr.log('E', 'setString for JOB failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('REASON', REASON);
      if resultCode then
         logr.log('E', 'setString for REASON failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLAGE', CLAGE);
      if resultCode then
         logr.log('E', 'setDouble for CLAGE failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLNO', CLNO);
      if resultCode then
         logr.log('E', 'setDouble for CLNO failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEBTINC', DEBTINC);
      if resultCode then
         logr.log('E', 'setDouble for DEBTINC failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DELINQ', DELINQ);
      if resultCode then
         logr.log('E', 'setDouble for DELINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEROG', DEROG);
      if resultCode then
         logr.log('E', 'setDouble for DEROG failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('NINQ', NINQ);
      if resultCode then
         logr.log('E', 'setDouble for NINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('YOJ', YOJ);
      if resultCode then
         logr.log('E', 'setDouble for YOJ failed.  resultCode=$s', resultCode);
      resultCode = pm.execute();
      if (resultCode) then
         logr.log('E', 'Error: pm.execute failed.  resultCode=$s', resultCode);
      else do;
         "EM_EVENTPROBABILITY" = pm.getDouble('EM_EVENTPROBABILITY');
         "EM_CLASSIFICATION" = pm.getString('EM_CLASSIFICATION');
      end;
   end;

   method run();
      set SASEP.IN;
      score("JOB","REASON","CLAGE","CLNO","DEBTINC","DELINQ","DEROG","NINQ","YOJ", resultCode, "EM_EVENTPROBABILITY", "EM_CLASSIFICATION");
   end;
enddata;
