unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    CloseButton: TButton;
    RadioGroup1: TRadioGroup;
    PerimeterRadioButton: TRadioButton;
    DiagonalRadioButton: TRadioButton;
    RhombRadioButton: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure DiagonalRadioButtonClick(Sender: TObject);
    procedure PerimeterRadioButtonClick(Sender: TObject);
    procedure RhombRadioButtonClick(Sender: TObject);
  private

  public

  end;

const
  K = 5; // размерность массива (KxK)
  lblCaption = 'Слово';

var
  Form1: TForm1;
  lbl: array[0..K, 0..K] of TLabel;
  StartLabelTop, StartLabelLeft: word;

procedure DeleteLabels();
function GetTestLabelHeight(): word;
function GetTestLabelWidth(): word;
function CreateLbl(IndentTop, IndentLeft: word): TLabel;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.DiagonalRadioButtonClick(Sender: TObject);
var
  i, j: byte;
begin
  DeleteLabels();

  for i := 1 to K do
    for j := 1 to K do
      if ((i = j) or (j = K - i + 1)) then
        lbl[i, j] := CreateLbl(StartLabelTop + GetTestLabelHeight() * i,
          StartLabelLeft + GetTestLabelWidth() * j);

end;


procedure TForm1.PerimeterRadioButtonClick(Sender: TObject);
var
  i, j: byte;
begin
  DeleteLabels();

  for i := 1 to K do
    for j := 1 to K do
      if (((i = 1) or (j = 1)) or ((i = K) or (j = K))) then
          lbl[i, j] := CreateLbl(StartLabelTop + GetTestLabelHeight() * i, StartLabelLeft + GetTestLabelWidth() * j);
end;

procedure TForm1.RhombRadioButtonClick(Sender: TObject);
var
  i, j: byte;
begin
  DeleteLabels();

  for i:=1 to K do
    for j:=1 to K do
       if
        (i = (K div 2) - j + 2)       // диагональ 1 ( лев верх )
        or (j = (K div 2) + i)        // диагональ 2 ( прав верх )
        or (j = i - (K div 2))        // диагональ 3 ( лев низ )
        or (i = K div 2 + K - j + 1)  // диагональ 4 ( прав низ )
        then
          lbl[i, j] := CreateLbl(StartLabelTop + GetTestLabelHeight() * i, StartLabelLeft + GetTestLabelWidth() * j);

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  TestLabelHeight, TestLabelWidth: byte;
begin
  {
   Создаем тестовую надпись lbl[0] для считывания ее размеров

   Размеры нужны будут, чтобы отцентрировать положение надписей на Panel1

   Надпись находится на Panel1, но невидима для нас,т.к. находится за
   ее пределами -> Top:=Panel1.Height + RadioGroup1.Height + 20
  }
  lbl[0,0] := CreateLbl(Panel1.Height + RadioGroup1.Height + 20, 1);
  TestLabelHeight := GetTestLabelHeight();
  TestLabelWidth := GetTestLabelWidth();

  {
   Выведем сообщение, если сумма размеров надписей больше размера Panel1
   Если нет -
  }
  if (Panel1.Height < (TestLabelHeight * K)) then
    ShowMessage('Высота надписей больше панели')
  else
    StartLabelTop := (Panel1.Height - TestLabelHeight * K) div 2;

  if (Panel1.Width < (TestLabelWidth * K)) then
    ShowMessage('Ширина надписей больше панели')
  else
  begin
    StartLabelLeft := (Panel1.Width - TestLabelWidth * K) div 2;
    { ShowMessage('TestLabelWidth=' + IntToStr(TestLabelWidth) + ', Panel1.Width=' + IntToStr(Panel1.Width) + ', StartLabelLeft=' + IntToStr(StartLabelLeft)); }
  end;

  // Определим четная или нет размерность матрицы
  if not Odd(K) then
     ShowMessage('В качестве размерности массива указано четное число. Правильность работы не гарантирована!');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    DeleteLabels();
    Form1.PerimeterRadioButton.Checked := False;
    Form1.DiagonalRadioButton.Checked := False;
    Form1.RhombRadioButton.Checked := False;
end;

procedure DeleteLabels();
var i, j: Byte;
begin
  for i:=1 to K do
    for j:=1 to K do
        if (lbl[i, j]<>nil) then
           FreeAndNil(lbl[i, j]);
end;

function GetTestLabelHeight(): word;
begin
  Result := lbl[0, 0].Height;
end;

function GetTestLabelWidth(): word;
begin
  Result := lbl[0, 0].Width;
end;

function CreateLbl(IndentTop, IndentLeft: word): TLabel;
var
  l: TLabel;
begin
  l := TLabel.Create(Form1);
  l.AutoSize := True;
  l.Parent := Form1.Panel1;
  l.Caption := lblCaption;
  l.Top := IndentTop;
  l.Left := IndentLeft;
  Result := l;
end;


end.
