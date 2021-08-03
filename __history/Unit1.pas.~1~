unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.StdCtrls, FMX.Edit;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1DrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    arr:TArray<Double>;
    elementscol:integer;
    stringcolumn:TArray<TStringColumn>;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}



procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;  sum:double;  temp:double;
begin
  arr:=nil;

  sum:=0;
  SetLength(arr,elementscol);

  for i:=0 to elementscol-1 do
  arr[i]:=Double.Parse(StringGrid1.Cells[0,i]);

  for i:=0 to Length(arr)-1 do
  sum:=sum+arr[i];

  // Сортировка пузырьком
  for i:=1 to Length(arr) do
  begin
    for j:=Length(arr)-1 downto i do
    begin
      if arr[j-1]>arr[j]
       then
      begin
        temp:=arr[j-1];
        arr[j-1]:=arr[j];
        arr[j]:=temp;
      end;
    end;
  end;

  for i:=0 to elementscol-1 do
  begin
    StringGrid1.Cells[1,i]:=arr[i].ToString;
  end;

  Form1.Caption:=sum.ToString;

  ShowMessage('Результат: '+sum.ToString);

end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
    stringcolumn:=nil;
    elementscol:=integer.Parse(Edit1.Text);
    StringGrid1.RowCount:=elementscol;
    SetLength(stringcolumn,elementscol+1);

    for i:=0 to StringGrid1.ColumnCount-1 do
      begin
        Application.ProcessMessages;
        StringGrid1.Columns[0].Destroy;
        Sleep(10);
      end;





  for i:=0 to Length(stringcolumn)-1 do
  begin
     stringcolumn[i]:=TStringColumn.Create(StringGrid1);
     stringcolumn[i].Parent:=StringGrid1;
     stringcolumn[i].Visible:=true;
     stringcolumn[i].Name:='StringColumn'+i.ToString;
     stringcolumn[i].Header:='a['+(i+1).ToString+']';
     if i=Length(stringcolumn)-1 then stringcolumn[i].Header:='d';

  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
try
  StringGrid1.Destroy;
  StringGrid1.Free;
except on EAccessViolation do
  begin

  end;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  elementscol:=integer.Parse(Edit1.Text);
  StringGrid1.RowCount:=elementscol;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  stringcolumn:=nil;
end;

procedure TForm1.StringGrid1DrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var b:TRectF; border:integer;
begin
 // b:=bounds;
//  border:=1;
 { b.Top:=b.Top+border;
  b.Left:=b.Left-border;
  b.Height:=b.Height-border;
  b.Width:=b.Width-border;   }

 { b.Top:=b.Top;
  b.Left:=b.Left;
  b.Height:=b.Height;
  b.Width:=b.Width;

  Canvas.Fill.Color:=TAlphaColorRec.Coral;
  Canvas.FillRect(b,4,4,[TCorner.TopRight,TCorner.BottomRight,TCorner.BottomLeft,TCorner.BottomRight,TCorner.TopLeft],1);
  Canvas.Fill.Color:=TAlphaColorRec.Brown;
  Canvas.Font.Size:=14;
  Canvas.FillText(Bounds,Value.AsString,False,1,[],TTextAlign.Leading);     }
end;

end.
