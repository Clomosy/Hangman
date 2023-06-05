var 
  MyForm, MYSecondForm:TCLForm;
  startBtn : TclProButton;
  titlekImg,manImg: TClProImage; 
  chooseLbl,missingLetterLbl  : TClProLabel;
  chooseCombo : TClComboBox;
  loopCombo ,loop, source,counter : Integer;
  gamePanel,letterPanel,missingletterPanel,screenPanel,gameContentPnl,imageHintContentPnl,hintContentPnl : TclProPanel;
  strvalue, MyWord, WordMean,letter:String;
  MyWordMean:TclMemo;
  LblDisplay,ztStartLbl:TclLabel;
  myGameEngine:TclGameEngine;
  MyPanel:TclPanel;
  letterEdit,MyEdit:TclEdit;
  EditFixWidth:Single;
  ztHintBtn,ztStartBtn:TclImage;
  ztLayout,ztHintBtnLayout:TclLayout;
  AnswStr,word:String;
  wrongCount:integer;

  Procedure GetNewWord(wordLength:Integer);
  begin
    myGameEngine:= TclGameEngine.Create;
    MyWord := MyGameEngine.WordService('GETWORD:'+IntToStr(wordLength),'');
    With Clomosy.ClDataSetFromJSON(MyWord) Do 
    Begin
      MyWord := FieldByName('Word').AsString;
      MyWord := AnsiUpperCase(MyWord);
      LblDisplay.Text := MyWord;//UpperCase
      WordMean := FieldByName('MeanText').AsString; //?
      //ShowMessage(MyWord);
    End;
  End;
  
  
  Procedure wordControl;
  var
    j:integer;
  begin
    for j := 1 to StrToInt(chooseCombo.ItemIndex)+1 do
    begin
      if letterEdit.Text = '' Then
      begin
        exit;
      end
      else
        word := word+TClEdit(MYSecondForm.clFindComponent('MyEdit'+IntToStr(j))).Text;
    end;
  
  End;
  
  

  Procedure CheckGameOnClick;
  begin
    word := '';
    wordControl;
    AnswStr := word;
    AnswStr := AnsiUpperCase(AnswStr);
    If AnswStr=MyWord Then
    begin
      ShowMessage('Tebrikler');
      ztStartBtn.Tag := 0;
      MYSecondForm.setImage(ztStartBtn,'https://clomosy.com/educa/circled-play.png');
      ztStartLbl.Text := 'Start Game';
      missingLetterLbl.Text :='';
      TclProButton(MYSecondForm.clFindComponent('BtnGoBack')).Click;
    end;
    else
    begin
      //
    end;
  end;


  Procedure BtnStartGameClick;
  begin
    case ztStartBtn.Tag of
      0:
      begin
        ztStartBtn.Tag := 1; 
        wrongCount := 0;
        GetNewWord(StrToInt(chooseCombo.ItemIndex)+1);
        MyWordMean.Text := WordMean;
        letterEdit.Text:='';
        letterEdit.SetFocus;
        LblDisplay.Visible := False;
        ztStartBtn.Visible := False;
        ztStartLbl.Visible := False;
      end;
      1:
      begin
        CheckGameOnClick;
      end;
    end;
  End;
  
  
  Procedure MyEditOnChange;
  var
  harfState:Boolean;
  begin
    harfState:=False;
    source := MyWord;

    for loop := 1 to chooseCombo.ItemIndex+1 do
    begin
      letter := Copy(source, loop, 1);
      if letterEdit.Text = letter then
      begin
        harfState:=True;
        TClEdit(MYSecondForm.clFindComponent('MyEdit'+IntToStr(loop))).Text := letterEdit.Text;
        CheckGameOnClick;
      end;
    end;
   
    if not harfState then
    begin
      wrongCount := wrongCount +1;
      missingLetterLbl.Text:=missingLetterLbl.Text+ letterEdit.Text + ' , ';
      if wrongCount = 11 then
      begin
        ShowMessage('word: '+'"'+ MyWord+'"' +' You Failed .');
        MYSecondForm.setImage(ztStartBtn,'https://clomosy.com/educa/checked2.png');
        ztStartLbl.Text := 'Check Word';
        ztStartBtn.Tag := 1;
        wrongCount := 1;
        GetNewWord(StrToInt(chooseCombo.ItemIndex));
        MyWordMean.Text := WordMean;
        MyEdit.Text:='';
        
        MyEdit.SetFocus;
        LblDisplay.Visible := False;
        missingLetterLbl.Text:='';
      
        clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,
        "RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,
        "ImgUrl":"https://clomosy.com/educa/hangerTitle2.png", "ImgFit":"yes"}');
        TclProButton(MYSecondForm.clFindComponent('BtnGoBack')).Click;
      end;
      case wrongCount of
      1:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman1.png", "ImgFit":"yes"}');
      2:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman2.png", "ImgFit":"yes"}');
      3:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman3.png", "ImgFit":"yes"}');
      4:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman4.png", "ImgFit":"yes"}');
      5:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman5.png", "ImgFit":"yes"}');
      6:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman6.png", "ImgFit":"yes"}');
      7:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman7.png", "ImgFit":"yes"}');
      8:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman8.png", "ImgFit":"yes"}');
      9:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman9.png", "ImgFit":"yes"}');
      10:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman10.png", "ImgFit":"yes"}');
      11:clComponent.SetupComponent(manImg,'{"Align" : "Center","MarginLeft":5,"MarginRight":5,"MarginTop":50,"Width" :150, "Height":250,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangman11.png", "ImgFit":"yes"}');
      end;
    end;
 
  end;
  
  Procedure SetupLayout;
  begin

    MyPanel:= MYSecondForm.AddNewPanel(gameContentPnl,'MyPanel','');
    MyPanel.Align := alCenter;
    MyPanel.Height := 25;
    MyPanel.Margins.Top:=5;
    MyPanel.Margins.Left:=20;
    MyPanel.Margins.Right:=20;
 
    
    for counter:= 1 to chooseCombo.ItemIndex+1 do
    begin
      EditFixWidth := 25;
      MyEdit := MYSecondForm.AddNewEdit(MyPanel,'MyEdit'+IntToStr(counter),'_');
      MyEdit.Width := EditFixWidth;
      MyEdit.Align := alLeft;
      MyEdit.ReadOnly := True;
   
    end;
    MyPanel.Width := EditFixWidth*(chooseCombo.ItemIndex+1);
  end;

//HARFLER
Procedure cikmayanHarf
begin

     missingletterPanel:=MYSecondForm.AddNewProPanel(gameContentPnl,'missingletterPanel');
    clComponent.SetupComponent(missingletterPanel,'{"Align" : "MostTop","Width" :100, "MarginTop":5,
    "Height":50,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":2}');
    
     missingLetterLbl := MYSecondForm.AddNewProLabel(missingletterPanel,'missingLetterLbl','Harfler : ');
   clComponent.SetupComponent(missingLetterLbl,'{"Align" : "left","MarginBottom":10,"MarginLeft":20,"Width" :250, "Height":30,"TextColor":"#000000","TextSize":12,"TextVerticalAlign":"center",
   "TextHorizontalAlign":"left","TextBold":"yes"}');
   
end;

Procedure takeLetter
begin
    letterPanel:=MYSecondForm.AddNewProPanel(gameContentPnl,'letterPanel');
    clComponent.SetupComponent(letterPanel,'{"Align" : "Top","Width" :100, "MarginLeft":140,"MarginRight":140,"MarginTop":10,
    "Height":50,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":2}');
    
    EditFixWidth := 25;
    letterEdit:= MYSecondForm.AddNewEdit(letterPanel,'letterEdit','____');
    MYSecondForm.AddNewEvent(letterEdit,tbeOnChange,'MyEditOnChange');
    letterEdit.Width := EditFixWidth;
    letterEdit.Align := alCenter;
    letterEdit.MaxLength := 1;

end;

  Procedure SetupStartBtn;
  begin
    ztLayout := MYSecondForm.AddNewLayout(gamePanel,'ztLayout');
    ztLayout.Align:=alBottom;
    ztLayout.Height := 130;
    ztLayout.Margins.Top := 5;
    
    ztStartBtn:= MYSecondForm.AddNewImage(ztLayout,'ztStartBtn');
    ztStartBtn.Align := alTop;
    ztStartBtn.Height := 100;
    ztStartBtn.Width := 100;
    ztStartBtn.Tag := 0;
    
    MYSecondForm.setImage(ztStartBtn,'https://clomosy.com/educa/circled-play.png');
    MYSecondForm.AddNewEvent(ztStartBtn,tbeOnClick,'BtnStartGameClick');
    
    ztStartLbl:= MYSecondForm.AddNewLabel(ztLayout,'ztStartLbl','Start Game');
    ztStartLbl.StyledSettings := ssFamily;
    ztStartLbl.TextSettings.Font.Size:=20;
    ztStartLbl.Align := alCenter;
    ztStartLbl.Margins.Top := 5;
    ztStartLbl.Margins.Bottom := 5;
    ztStartLbl.Width := 150;
    
  end;
  Procedure ztHintBtnOnClick;
  begin
    LblDisplay.Visible := True;
  end;

  procedure SetupHintBtn;
  begin
    ztHintBtnLayout := MYSecondForm.AddNewLayout(hintContentPnl,'ztHintBtnLayout');
    ztHintBtnLayout.Align:=alClient;
    ztHintBtnLayout.Height := 100;
    ztHintBtnLayout.Width := 130;
    
    ztHintBtn:= MYSecondForm.AddNewImage(ztHintBtnLayout,'ztHintBtn');
    ztHintBtn.Align := alMostTop;
    ztHintBtn.Margins.Left:=30;
    ztHintBtn.Margins.Right:=30;
    ztHintBtn.Height:= 80;
    MYSecondForm.setImage(ztHintBtn,'https://clomosy.com/educa/hint1.png');
    MYSecondForm.AddNewEvent(ztHintBtn,tbeOnClick,'ztHintBtnOnClick');
    
    LblDisplay:= MYSecondForm.AddNewLabel(ztHintBtnLayout,'LblDisplay',' ');
    LblDisplay.Align := alTop;
    LblDisplay.Margins.Left :=5;
    LblDisplay.Margins.Right:= 5;
    LblDisplay.Margins.Top:=5;
    LblDisplay.Height := 30;
    LblDisplay.TextSettings.Font.Size:=3;
    LblDisplay.Visible := True;
    
  end;
  
  Procedure SetupWordMean;
  var
   ztProPanel : TclProPanel;
   begin
    ztProPanel:=MYSecondForm.AddNewProPanel(gamePanel,'ztProPanel');
    clComponent.SetupComponent(ztProPanel,'{"Align" : "MostTop","Width" :80, "MarginTop":10,"MarginRight":10,"MarginLeft":10, 
    "Height":100,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":2}');
    
    MyWordMean:= MYSecondForm.AddNewMemo(ztProPanel,'MyWordMean','');
    MyWordMean.Align := alClient;
    MyWordMean.ReadOnly := True;
    MyWordMean.TextSettings.WordWrap := True;
    MyWordMean.Height := MyWordMean.Height * 2;
   end;
  
  Procedure gameContent;
  begin
  
  gameContentPnl:=MyForm.AddNewProPanel(gamePanel,'gameContentPnl');
  clComponent.SetupComponent(gameContentPnl,'{"Align" : "Top","MarginTop":10, "MarginLeft":5,"MarginRight":5,
  "Height":400}');
  
  imageHintContentPnl:=MyForm.AddNewProPanel(gameContentPnl,'imageHintContentPnl');
  clComponent.SetupComponent(imageHintContentPnl,'{"Align" : "Bottom","MarginTop":10,"MarginLeft":5,"MarginRight":5,
  "Height":250}');

    manImg := MYSecondForm.AddNewProImage(imageHintContentPnl,'manImg');
    clComponent.SetupComponent(manImg,'{"Align" : "Right","RoundHeight":10,"RoundWidth":10,"MarginTop":5,"MarginBottom":5,
    "BorderColor":"#000000","BorderWidth":0,"ImgUrl":"https://clomosy.com/educa/hangerTitle2.png","ImgFit":"yes"}');
 
    hintContentPnl:=MyForm.AddNewProPanel(imageHintContentPnl,'hintContentPnl');
    clComponent.SetupComponent(hintContentPnl,'{"Align" : "Left","MarginTop":10,"MarginLeft":5,"Width":130}');
    
    SetupHintBtn;
  
  end;
  
  Procedure ScreenTwo;
  begin
    MYSecondForm := TCLForm.Create(Self);
    MYSecondForm.SetFormColor('#6af2e4','#CBEDD5',clGVertical);
    
    
    strvalue:=5;
    gamePanel:=MYSecondForm.AddNewProPanel(MYSecondForm,'gamePanel');
    clComponent.SetupComponent(gamePanel,'{"Align" : "Client","MarginRight":10,"MarginLeft":10,
    "MarginBottom":10,"MarginTop":10,"RoundHeight":10,"RoundWidth":10,
    "BorderColor":"#000000","BorderWidth":2}');
    
    SetupWordMean;  //MEMO
    
    gameContent;
    
    SetupLayout;
    SetupStartBtn;
    takeLetter;
    cikmayanHarf;
    
    MYSecondForm.Run;
  End;



procedure BtnOnClick;
var
  valueStr : String;
begin
  if chooseCombo.ItemIndex <> 0 then 
    ScreenTwo;
  else
    ShowMessage('Make Your Choice');
    
end;
begin

  MyForm := TCLForm.Create(Self);
  MyForm.SetFormColor('#6af2e4','#CBEDD5',clGVertical);

 screenPanel:=MyForm.AddNewProPanel(MyForm,'screenPanel');
 clComponent.SetupComponent(screenPanel,'{"Align" : "Client","Width" :300, "MarginTop":15,"MarginRight":15,"MarginLeft":15,"MarginBottom":15,
 "Height":600,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#000000","BorderWidth":2}');


 titlekImg := MyForm.AddNewProImage(screenPanel,'titlekImg');
 clComponent.SetupComponent(titlekImg,'{"Align" : "Top","MarginTop":45,"MarginRight":15,"MarginLeft":15,"Width" :150, "Height":150,"RoundHeight":10,"RoundWidth":10,"BorderColor":"#fabd2","BorderWidth":0,
 "ImgUrl":"https://clomosy.com/educa/hangerTitle.png", "ImgFit":"yes"}');



 chooseLbl := MyForm.AddNewProLabel(screenPanel,'chooseLbl','Select Word Length');
 clComponent.SetupComponent(chooseLbl,'{"Align" : "Center",
 "MarginBottom":100,
 "Width" :150,
 "Height":30,
 "TextColor":"#000000",
 "TextSize":14,
 "TextVerticalAlign":"center",
 "TextHorizontalAlign":"left",
 "TextBold":"yes"}');


  chooseCombo := MyForm.AddNewComboBox(screenPanel,'chooseCombo');
  chooseCombo.Align := alCenter;
  chooseCombo.Width := 150;
  chooseCombo.Margins.Bottom:=20;
  
  chooseCombo.AddItem('Make Your Choose','0')
  
  for loopCombo := 2 to 10 do 
  begin
   chooseCombo.AddItem(IntToStr(loopCombo),IntToStr(loopCombo));
  end;

   startBtn := MyForm.AddNewProButton(screenPanel,'startBtn','');
   clComponent.SetupComponent(startBtn,'{"caption":"","Align" : "Bottom","MarginBottom":40,"Width" :100, 
   "Height":70,"RoundHeight":2,
   "RoundWidth":2,"BorderColor":"#000000","BorderWidth":2}');
   MyForm.SetImage(startBtn,'https://clomosy.com/educa/hanger.png'); 
   MyForm.AddNewEvent(startBtn,tbeOnClick,'BtnOnClick');

MyForm.Run;
end;
