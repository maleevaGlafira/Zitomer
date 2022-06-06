procedure TFormZav.Ed_ndomChange(Sender: TObject);
var i,dl,cur:integer;
    tt_str:string;
    fl_dl:boolean;
begin
  if not isClosed then
    begin
     cur:=Ed_ndom.SelStart;
     fl_dl:=false;
     tt_str:=Ed_ndom.Text;
     dl:=Length(tt_str);
     for i:=1 to dl do
      begin
        if (tt_str[i] in ['0'..'9']) or
           (tt_str[i] in ['À'..'ß']) or
           (tt_str[i] in ['à'..'ÿ']) or
            (tt_str[i]='/') then
          begin
            if (tt_str[i]='/') then
               begin
                  if (i<dl) and ((tt_str[i+1] in ['À'..'ß'])
                                         or(tt_str[i] in ['à'..'ÿ'])) then
                    begin
                      tt_str[i]:=' ';
                      fl_dl:=true;
                    end;
               end;
          end
        else
         begin
          tt_str[i]:=' ';
          fl_dl:=true;

         end;
      end;
     Ed_ndom.Text:=Lower(Strip('A',' ',tt_str));
     if fl_dl then
       begin
        Ed_ndom.SelStart:=cur;
        Beep;
       end;
    end;
 DBL_raonChange(NIL);
end;


procedure TFormZav.CheckAddrChange;
begin
 if (OldAddr.type_addr <> CB_tAdr.ItemIndex)or
    (OldAddr.baze_street <> DBL_ul1.text)or
    (OldAddr.cross_street <> DBL_ul2.text)or
    (OldAddr.house_numb <> Ed_ndom.text)or
    (OldAddr.dop_addr <> Ed_dopAdr.text)  then
     DM1.tempQr_q.SQL.Clear;
     DM1.tempQr_q.SQL.text:=
      Format('INSERT INTO TableLog (ftype, idobj, user_name, old_value, new_value) '+
             'values (%d, %d, "%s", "%s", "%s")' ,[1, ZavCode, NameUser,
             getAddr(OldAddr.type_addr, OldAddr.baze_street, OldAddr.cross_street,
                     OldAddr.house_numb, AntiQuote(OldAddr.dop_addr)),
             getAddr(CB_tAdr.ItemIndex, DBL_ul1.text, DBL_ul2.text,
                     Ed_ndom.text, AntiQuote(Ed_dopAdr.text))]);
     try
      DM1.tempQr_q.ExecSQL;
      OldAddr.type_addr:=CB_tAdr.ItemIndex;
      OldAddr.baze_street:=DBL_ul1.text;
      OldAddr.cross_street:=DBL_ul2.text;
      OldAddr.house_numb:=Ed_ndom.text;
      OldAddr.dop_addr:=Ed_dopAdr.text;
     except
      on E:Exception do
        begin
          MessageBox(handle,PChar(TrLangMSG(msgErrorExec)+' DM1.tempQr_q.ExecSQL:'#13+E.Message),
            PChar(TrLangMSG(msgCapMainForm)), MB_OK or MB_ICONWARNING);
        end;
     end;
end;